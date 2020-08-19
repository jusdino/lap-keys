// KEYBOARD: Split Sixty Wedge
// First step towards a more functional design: Adding a PCB, reducing space for hand-wires.

include <components/switches.scad>;
include <components/mcus.scad>;
include <components/sockets.scad>;
include <components/keycaps.scad>;
include <abstractions.scad>;

split_sixty_wedge(
  x_count=6,
  y_count=5,
  switch_spacing=19,
  keys_and_caps=true,
  plates=true,
  pcbs=true,
  mcu=true);
module split_sixty_wedge(x_count, y_count, switch_spacing, keys_and_caps=false, plates=false, pcbs=false, mcu=false) {
  e = 0.01;

  // MULTI-MODULE VARS
  // switch_column attributes
  switch_column_plate_pcb_dx = 16.5;
  switch_column_plate_pcb_dy = 99.7;
  switch_column_plate_pcb_dz = 1.6;
  switch_column_plate_pcb_y = -7.8;

  switch_column_plate_pcb_holder_inset = 1;
  switch_column_plate_pcb_headroom_dz = 2;
  switch_column_plate_pcb_holder_overreach_dz = 1;
  switch_column_plate_pcb_holder_dz = switch_column_plate_pcb_dz + switch_column_plate_pcb_holder_overreach_dz;

  // switch_base attributes
  switch_base_thickness = 1.5;
  switch_base_bottom_width = 3;
  switch_base_hull_dz = cherrymx_socket_hull_dz;
  switch_base_pcb_dz = switch_column_plate_pcb_dz;
  switch_base_pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;

  switch_base_plate_dz = switch_base_hull_dz + switch_base_pcb_dz + switch_column_plate_pcb_holder_overreach_dz;
  switch_base_plate_dx = switch_spacing * x_count;
  switch_base_plate_dy = switch_spacing * y_count;

  switch_base_tolerance_dy = 0.5;

  switch_base_dx = switch_base_plate_dx + 2*switch_base_thickness;
  switch_base_dy = switch_base_plate_dy + 2*switch_base_thickness + switch_base_tolerance_dy;
  switch_base_dz = switch_base_thickness;


  // This module vars
  base_color = [80/255, 100/255, 200/255];
  base_thickness = switch_base_thickness;
  base_bottom_width = switch_base_bottom_width;
  base_dx = switch_base_dx;
  base_dy = switch_base_dy;

  y_rotation = 50;
  z_rotation = 11;

  bottom_connector_bottom_z = -base_dx * sin(y_rotation);
  bottom_connector_top_z = -(base_dx-base_bottom_width) * sin(y_rotation);
  bottom_connector_dz = bottom_connector_top_z - bottom_connector_bottom_z;
  bottom_connector_front_y = base_dx * cos(y_rotation) * sin(z_rotation);

  snap_hole_rad = 3;
  mcu_connectors_shift_dy = 5 + snap_hole_rad;
  mcu_connectors_dx = 10 + 2*snap_hole_rad;
  mcu_connectors_dy = 34 + 2*snap_hole_rad;

  wedge_mirror() {
    switch_base(x_count=x_count, y_count=y_count, switch_spacing=switch_spacing, base_color=base_color, plate=plates, pcbs=pcbs, keys_and_caps=keys_and_caps);
  }
  color(base_color) {
    // Top connector plate
    hull() {
      wedge_mirror() {
        translate([0, -base_dy, 0]) {
          cube([base_bottom_width, base_dy, e]);
        }
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
          translate([mcu_connectors_dx/2, 0, 0]) sphere(r=3, $fn=20);
          translate([-mcu_connectors_dx/2, 0, 0]) sphere(r=3, $fn=20);
          translate([mcu_connectors_dx/2, -mcu_connectors_dy, 0]) sphere(r=3, $fn=20);
          translate([-mcu_connectors_dx/2, -mcu_connectors_dy, 0]) sphere(r=3, $fn=20);
        }
      }
    }
  }
  translate([0, bottom_connector_front_y, bottom_connector_top_z]) {
    elite_c_mount(mcu=mcu);
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

  module elite_c_mount(mcu=false) {
    pcb_dx = elite_c_pcb_dx;
    pcb_dy = elite_c_pcb_dy;
    pcb_dz = elite_c_pcb_dz;

    usb_dx = elite_c_usb_dx;
    usb_dy = elite_c_usb_dy;
    usb_dz = elite_c_usb_dz;

    usb_connector_space_dz = 7.0;
    mcu_y = -mcu_connectors_shift_dy - snap_hole_rad;
    mcu_z = pcb_dz + usb_dz/2 + usb_connector_space_dz/2;

    under_support_thickness = 0.6;
    under_support_dz = 1.5;

    if (mcu) {
      translate([0, mcu_y, mcu_z]) {
        rotate([180, 0, 0]) {
          elite_c();
        }
      }
    }
    // Under-pcb support
    translate([0, mcu_y, 0]) {
      translate([-pcb_dx/2, -pcb_dy, 0]) {
        difference() {
          cube([pcb_dx, pcb_dy, mcu_z-pcb_dz]);
          hull() {
            translate([under_support_thickness, under_support_thickness, mcu_z-pcb_dz]) {
              cube([pcb_dx-2*under_support_thickness, pcb_dy-2*under_support_thickness, e]);
            }
            translate([under_support_thickness+under_support_dz, under_support_thickness+under_support_dz, under_support_dz]) {
              cube([pcb_dx-2*under_support_thickness-2*under_support_dz, pcb_dy-2*under_support_thickness-2*under_support_dz, e]);
            }
          }
          translate([-e, under_support_thickness+under_support_dz, under_support_dz]) {
            cube([pcb_dx+2*e, pcb_dy-2*under_support_thickness-2*under_support_dz, mcu_z-pcb_dz-under_support_dz+e]);
          }
          translate([pcb_dx/2-usb_dx/2, pcb_dy-under_support_thickness-under_support_dz, mcu_z-pcb_dz-usb_dz]) {
            translate([usb_dz/2, 0, 0]) {
              cube([usb_dx-usb_dz, under_support_thickness+under_support_dz+e, usb_dz+e]);
              translate([0, 0, usb_dz/2]) {
                rotate([-90, 0, 0]) cylinder(d=usb_dz, h=under_support_thickness+under_support_dz+e, $fn=16);
              }
            }
            translate([0, 0, usb_dz/2]) {
              cube([usb_dz/2+e, under_support_thickness+under_support_dz+e, usb_dz/2+e]);
            }
            translate([usb_dx-usb_dz/2, 0, 0]) {
              translate([0, 0, usb_dz/2]) {
                rotate([-90, 0, 0]) cylinder(d=usb_dz, h=under_support_thickness+under_support_dz+e, $fn=16);
              }
              translate([0, 0, usb_dz/2]) {
                cube([usb_dz/2+e, under_support_thickness+under_support_dz+e, usb_dz/2+e]);
              }
            }
          }
        }
      }
    }
  }


  //switch_base(x_count=6, y_count=5, switch_spacing=19, plate=true, pcbs=true);
  module switch_base(x_count=6, y_count=5, switch_spacing=19, base_color="white", plate=false, pcbs=false, keys_and_caps=false) {
    e = 0.01;

    hull_dz = cherrymx_socket_hull_dz;
    pcb_dz = switch_column_plate_pcb_dz;
    pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;

    plate_dz = switch_base_plate_dz;
    plate_dx = switch_base_plate_dx;
    plate_dy = switch_base_plate_dy;

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
    if (plate) {
      translate([base_thickness, -base_thickness, base_dz+2*e]) {
        switch_plate(x_count=x_count, y_count=y_count, switch_spacing=switch_spacing, pcb=pcbs, keys_and_caps=keys_and_caps);
      }
    }

    //switch_plate(x_count=6, y_count=5, switch_spacing=19, pcb=false);
    module switch_plate(x_count, y_count, switch_spacing, pcb=false, keys_and_caps=false) {
      hull_dz = cherrymx_socket_hull_dz;
      pcb_dz = switch_column_plate_pcb_dz;
      pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;

      plate_dz = hull_dz + pcb_dz + pcb_holder_overreach_dz;


      translate([switch_spacing/2, -(y_count-0.5)*switch_spacing, plate_dz]) {
        for (i=[0:x_count-1]) {
          translate([switch_spacing*i, 0, 0]) {
            switch_column_plate(count=y_count, switch_spacing=switch_spacing, pcb=pcb, keys_and_caps=keys_and_caps);
          }
        }
      }

      module switch_column_plate(count, switch_spacing, pcb=false, keys_and_caps=false) {
        e = 0.01;

        pcb_dx = switch_column_plate_pcb_dx;
        pcb_dy = switch_column_plate_pcb_dy;
        pcb_dz = switch_column_plate_pcb_dz;

        hull_dx = cherrymx_socket_hull_dx;
        hull_dy = cherrymx_socket_hull_dy;
        hull_dz = cherrymx_socket_hull_dz;

        plate_dx = cherrymx_socket_plate_dx;
        plate_dy = cherrymx_socket_plate_dy;

        pcb_holder_inset = switch_column_plate_pcb_holder_inset;
        pcb_headroom_dz = switch_column_plate_pcb_headroom_dz;
        pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;
        pcb_holder_dz = switch_column_plate_pcb_holder_dz;

        socket_color = cherrymx_socket_color;

        for (i= [0:count-1]) {
          translate([0, switch_spacing*i, 0]) {
            cherrymx_plate_pcb();
          }
        }
        if (pcb) {
          color("green") {
            translate([-pcb_dx/2, switch_column_plate_pcb_y, -hull_dz-pcb_dz]) {
              cube([pcb_dx, pcb_dy, pcb_dz]);
            }
          }
        }

        module cherrymx_plate_pcb() {
          color(socket_color) {
            difference() {
              union() {
                cherrymx_plate_base();
                translate([-hull_dx/2, -hull_dy/2, -hull_dz-pcb_holder_dz]) {
                  cube([hull_dx, hull_dy, pcb_holder_dz+e]);
                }
              }
              // PCB slot
              translate([-pcb_dx/2, -switch_spacing/2-e, -hull_dz-pcb_dz]) {
                cube([pcb_dx, switch_spacing+2*e, pcb_dz+2*e]);
                // PCB headroom
                translate([pcb_holder_inset, 0, pcb_dz]) {
                  cube([pcb_dx-2*pcb_holder_inset, switch_spacing+2*e, pcb_headroom_dz]);
                }
                // PCB overreach
                hull() {
                  cube([pcb_dx, switch_spacing+2*e, e]);
                  translate([pcb_holder_overreach_dz, 0, -pcb_holder_overreach_dz-e]) {
                    cube([pcb_dx-2*pcb_holder_overreach_dz, switch_spacing+2*e, e]);
                  }
                }
              }
            }
          }
          if (keys_and_caps) {
            cherrymx(pcb_pins=true);
            keycap_1u();
          }
        }
      }
    }
  }
}
