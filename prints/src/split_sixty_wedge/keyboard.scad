// KEYBOARD: Split Sixty Wedge
// First step towards a more functional design: Adding a PCB, reducing space for hand-wires.

// MULTI-MODULE VARS
// General inputs
keys_and_caps=true;
plates=true;
pcbs=true;

mcu_mount=true;
mcu=true;

trackball_mount=true;
trackball=true;
sensor=true;
bearings=true;

keyboard_x_count = 6;
keyboard_y_count = 5;
keyboard_switch_spacing = 19;
keyboard_y_rotation = 50;
keyboard_z_rotation = 11;

include <switch_plate.scad>;

// switch_base attributes
switch_base_thickness = 1.5;
switch_base_bottom_width = 3;
switch_base_tolerance_dy = 0.5;

switch_base_dx = switch_plate_dx + 2*switch_base_thickness;
switch_base_dy = switch_plate_dy + 2*switch_base_thickness + switch_base_tolerance_dy;
switch_base_dz = switch_base_thickness;

// Keyboard attributes
keyboard_snap_hole_rad = 3;
keyboard_bottom_connector_bottom_z = -switch_base_dx * sin(keyboard_y_rotation);
keyboard_bottom_connector_top_z = -(switch_base_dx-switch_base_bottom_width) * sin(keyboard_y_rotation);
keyboard_bottom_connector_dz = keyboard_bottom_connector_top_z - keyboard_bottom_connector_bottom_z;
keyboard_bottom_connector_front_y = switch_base_dx * cos(keyboard_y_rotation) * sin(keyboard_z_rotation);

keyboard_mcu_connectors_shift_dy = 5 + keyboard_snap_hole_rad;
keyboard_mcu_connectors_dx = 10 + 2*keyboard_snap_hole_rad;
keyboard_mcu_connectors_dy = 34 + 2*keyboard_snap_hole_rad;

keyboard_top_dx = switch_base_dy*sin(keyboard_z_rotation)*2;
keyboard_top_dy = switch_base_dy*cos(keyboard_z_rotation);
keyboard_top_dz = switch_base_bottom_width * sin(keyboard_y_rotation);

include <trackball_mount.scad>;
include <elite_c_mount.scad>;

keyboard();
module keyboard() {
  e = 0.01;

  x_count = keyboard_x_count;
  y_count = keyboard_y_count;
  switch_spacing = keyboard_switch_spacing;

  base_color = [80/255, 100/255, 200/255];
  base_thickness = switch_base_thickness;
  base_bottom_width = switch_base_bottom_width;
  base_dx = switch_base_dx;
  base_dy = switch_base_dy;

  y_rotation = keyboard_y_rotation;
  z_rotation = keyboard_z_rotation;

  bottom_connector_bottom_z = keyboard_bottom_connector_bottom_z;
  bottom_connector_top_z = keyboard_bottom_connector_top_z;
  bottom_connector_dz = keyboard_bottom_connector_dz;
  bottom_connector_front_y = keyboard_bottom_connector_front_y;

  snap_hole_rad = keyboard_snap_hole_rad;
  mcu_connectors_shift_dy = keyboard_mcu_connectors_shift_dy;
  mcu_connectors_dx = keyboard_mcu_connectors_dx;
  mcu_connectors_dy = keyboard_mcu_connectors_dy;

  wedge_mirror() {
    switch_base();
  }
  color(base_color) {
    // Top connector plate
    difference() {
      hull() {
        wedge_mirror() {
          translate([0, -base_dy, 0]) {
            cube([base_bottom_width, base_dy, e]);
          }
        }
      }
      translate([0, -keyboard_top_dy, 0]) {
        trackball_mount_cutout();
      }
    }
    // Bottom connector plate
    difference() {
      hull() {
        wedge_mirror() {
          translate([base_dx-base_bottom_width, -base_dy, 0]) {
            cube([base_bottom_width, base_dy, e]);
          }
        }
      }
      // MCU connector snap holes
      translate([0, bottom_connector_front_y, bottom_connector_bottom_z+bottom_connector_dz/2]) {
        translate([0, -mcu_connectors_shift_dy, 0]) {
          translate([mcu_connectors_dx/2, 0, 0]) sphere(r=snap_hole_rad, $fn=20);
          translate([-mcu_connectors_dx/2, 0, 0]) sphere(r=snap_hole_rad, $fn=20);
          translate([mcu_connectors_dx/2, -mcu_connectors_dy, 0]) sphere(r=snap_hole_rad, $fn=20);
          translate([-mcu_connectors_dx/2, -mcu_connectors_dy, 0]) sphere(r=snap_hole_rad, $fn=20);
        }
      }
    }
  }
  if (trackball_mount) {
    translate([0, -keyboard_top_dy, 0]) {
      trackball_mount();
    }
  }
  if (mcu_mount) {
    translate([0, bottom_connector_front_y, bottom_connector_top_z]) {
      elite_c_mount(mcu);
    }
  }

  
  module wedge_mirror() {
    wedge_rotate() {
      children();
    }
    mirror([1, 0, 0]) {
      wedge_rotate() {
        children();
      }
    }
  }

  module wedge_rotate() {
    rotate([0, y_rotation, z_rotation]) {
      children();
    }
  }

  //switch_base();
  module switch_base() {
    e = 0.01;

    x_count = keyboard_x_count;
    y_count = keyboard_y_count;
    switch_spacing = keyboard_switch_spacing;
    y_rotation = keyboard_y_rotation;
    z_rotation = keyboard_z_rotation;

    pcb_dz = switch_column_plate_pcb_dz;
    pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;

    plate_dz = switch_plate_dz;
    plate_dx = switch_plate_dx;
    plate_dy = switch_plate_dy;

    base_thickness = switch_base_thickness;
    base_dx = switch_base_dx;
    base_dy = switch_base_dy;
    base_dz = switch_base_dz;
    base_bottom_width = switch_base_bottom_width;

    color(base_color) {
      translate([0, -base_dy, 0]) {
        difference() {
          union() {
            // Main frame
            cube([base_dx, base_dy, base_dz]);
            cube([base_thickness, base_dy, plate_dz+base_thickness*2]);
            cube([base_dx, base_thickness, (plate_dz+base_thickness)/4]);
            translate([base_dx-base_thickness, 0, 0]) {
              cube([base_thickness, base_dy, plate_dz+base_thickness*2]);
            }
            // Overreach tabs
            translate([base_thickness, 0, plate_dz+1.5*base_thickness]) {
              rotate([-90, 0, 0]) {
                cylinder(h=base_dy, d=base_thickness, $fn=8);
                translate([plate_dx, 0, 0]) {
                  cylinder(h=base_dy, d=base_thickness, $fn=8);
                }
              }
            }
          }
          // Bottom subtraction
          translate([base_bottom_width, base_bottom_width, -e]) {
            cube([base_dx-2*base_bottom_width, base_dy-base_bottom_width*2, base_thickness+2*e]);
          }
        }
      }
      // Front
      translate([0, -base_thickness, ]) {
        cube([base_dx, base_thickness, base_dz+pcb_holder_overreach_dz/2]);
        cube([base_thickness*1.5, base_thickness, plate_dz+base_thickness*2]);
        translate([base_dx-base_thickness*1.5, 0, 0]) {
          cube([base_thickness*1.5, base_thickness, plate_dz+base_thickness*2]);
        }
      }
    }
    if (plates) {
      translate([base_thickness, -base_thickness, base_dz+2*e]) {
        switch_plate();
      }
    }

  }
}
