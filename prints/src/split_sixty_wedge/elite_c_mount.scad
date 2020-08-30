include <../components/mcus.scad>;

use <keyboard.scad>;

elite_c_mount_usb_connector_space_dx = 14.0;
elite_c_mount_usb_connector_space_dz = 7.0;

elite_c_mount_support_overhang = 0.6;

elite_c_mount_mcu_y = -keyboard_mcu_connectors_shift_dy - keyboard_snap_hole_rad;
elite_c_mount_mcu_z = elite_c_pcb_dz + elite_c_usb_dz/2 + elite_c_mount_usb_connector_space_dz/2;
  
module elite_c_mount(mcu=false) {
  mcu_y = elite_c_mount_mcu_y;
  mcu_z = elite_c_mount_mcu_z;

  elite_c_mount_top();
  elite_c_mount_bottom();
  if (mcu) {
    translate([0, mcu_y, mcu_z]) {
      rotate([180, 0, 0]) {
        elite_c();
      }
    }
  }
}

module elite_c_mount_bottom() {
  e = 0.01;

  pcb_dx = elite_c_pcb_dx;
  pcb_dy = elite_c_pcb_dy;
  pcb_dz = elite_c_pcb_dz;
  
  usb_dx = elite_c_usb_dx;
  usb_dy = elite_c_usb_dy;
  usb_dz = elite_c_usb_dz;
  
  mcu_y = elite_c_mount_mcu_y;
  mcu_z = elite_c_mount_mcu_z;

  usb_connector_space_dx = elite_c_mount_usb_connector_space_dx;
  usb_connector_space_dz = elite_c_mount_usb_connector_space_dz;
  
  support_overhang = elite_c_mount_support_overhang;

  under_support_dz = 1.5;

  // Under-pcb support
  translate([0, mcu_y, 0]) {
    translate([-pcb_dx/2, -pcb_dy, 0]) {
      difference() {
        cube([pcb_dx, pcb_dy, mcu_z-pcb_dz]);
        hull() {
          translate([support_overhang, support_overhang, mcu_z-pcb_dz]) {
            cube([pcb_dx-2*support_overhang, pcb_dy-2*support_overhang, e]);
          }
          translate([support_overhang+under_support_dz, support_overhang+under_support_dz, under_support_dz]) {
            cube([pcb_dx-2*support_overhang-2*under_support_dz, pcb_dy-2*support_overhang-2*under_support_dz, e]);
          }
        }
        translate([-e, support_overhang+under_support_dz, under_support_dz]) {
          cube([pcb_dx+2*e, pcb_dy-2*support_overhang-2*under_support_dz, mcu_z-pcb_dz-under_support_dz+e]);
        }
        translate([pcb_dx/2-usb_dx/2, pcb_dy-support_overhang-under_support_dz, mcu_z-pcb_dz-usb_dz]) {
          translate([usb_dz/2, 0, 0]) {
            cube([usb_dx-usb_dz, support_overhang+under_support_dz+e, usb_dz+e]);
            translate([0, 0, usb_dz/2]) {
              rotate([-90, 0, 0]) cylinder(d=usb_dz, h=support_overhang+under_support_dz+e, $fn=16);
            }
          }
          translate([0, 0, usb_dz/2]) {
            cube([usb_dz/2+e, support_overhang+under_support_dz+e, usb_dz/2+e]);
          }
          translate([usb_dx-usb_dz/2, 0, 0]) {
            translate([0, 0, usb_dz/2]) {
              rotate([-90, 0, 0]) cylinder(d=usb_dz, h=support_overhang+under_support_dz+e, $fn=16);
            }
            translate([0, 0, usb_dz/2]) {
              cube([usb_dz/2+e, support_overhang+under_support_dz+e, usb_dz/2+e]);
            }
          }
        }
      }
    }
  }
}

module elite_c_mount_top() {
  e = 0.01;

  pcb_dx = elite_c_pcb_dx;
  pcb_dy = elite_c_pcb_dy;
  pcb_dz = elite_c_pcb_dz;
  
  usb_dx = elite_c_usb_dx;
  usb_dy = elite_c_usb_dy;
  usb_dz = elite_c_usb_dz;
  
  mcu_y = elite_c_mount_mcu_y;
  mcu_z = elite_c_mount_mcu_z;

  usb_connector_space_dx = elite_c_mount_usb_connector_space_dx;
  usb_connector_space_dz = elite_c_mount_usb_connector_space_dz;

  snap_hole_rad = keyboard_snap_hole_rad;
  bottom_connector_dz = keyboard_bottom_connector_dz;
  mcu_connectors_shift_dy = keyboard_mcu_connectors_shift_dy;
  mcu_connectors_dx = keyboard_mcu_connectors_dx;
  mcu_connectors_dy = keyboard_mcu_connectors_dy;
  
  support_overhang = elite_c_mount_support_overhang;

  top_cover_thickness = 1.0;
  top_cover_cavity_dz = 1.0;
  top_cover_gap_dz = 3.0;

  // Top-cover
  difference() {
    // Outer shell
    hull() {
      translate([0, mcu_y, mcu_z]) {
        translate([-pcb_dx/2-top_cover_thickness, -pcb_dy-top_cover_thickness, 0]) {
          cube([pcb_dx+2*top_cover_thickness, pcb_dy+top_cover_thickness, top_cover_thickness+top_cover_cavity_dz]);
        }
      }
      translate([0, -mcu_connectors_shift_dy, 0]) {
        translate([mcu_connectors_dx/2, 0, 0]) cylinder(r=snap_hole_rad, h=e, $fn=16);
        translate([-mcu_connectors_dx/2, 0, 0]) cylinder(r=snap_hole_rad, h=e, $fn=16);
        translate([mcu_connectors_dx/2, -mcu_connectors_dy, 0]) cylinder(r=snap_hole_rad, h=e, $fn=16);
        translate([-mcu_connectors_dx/2, -mcu_connectors_dy, 0]) cylinder(r=snap_hole_rad, h=e, $fn=16);
      }
    }
    translate([0, mcu_y, mcu_z]) {
      translate([-pcb_dx/2, -pcb_dy, -pcb_dz-mcu_z]) {
        // PCB body cut
        translate([0, 0, -e]) {
          cube([pcb_dx, pcb_dy, mcu_z+pcb_dz+e]);
        }
        // Over-PCB cavity cut
        translate([support_overhang, support_overhang, mcu_z+pcb_dz-e]) {
          cube([pcb_dx-2*support_overhang, pcb_dy-2*support_overhang, top_cover_cavity_dz]);
        }
      }
    }
    // Sides cut
    translate([-mcu_connectors_dx/2-snap_hole_rad-e, mcu_y-pcb_dy+top_cover_thickness, -e]) {
      cube([mcu_connectors_dx+2*snap_hole_rad+2*e, pcb_dy-2*top_cover_thickness, top_cover_gap_dz+e]);
    }
    // USB cut
    translate([-usb_connector_space_dx/2, mcu_y-e, -e]) {
      cube([usb_connector_space_dx, -mcu_y, usb_connector_space_dz+e]);
    }
  }
  // Connectors
  difference() {
    translate([0, 0, -bottom_connector_dz/2]) {
      translate([0, -mcu_connectors_shift_dy, 0]) {
        translate([mcu_connectors_dx/2, 0, 0]) sphere(r=snap_hole_rad, $fn=20);
        translate([-mcu_connectors_dx/2, 0, 0]) sphere(r=snap_hole_rad, $fn=20);
        translate([mcu_connectors_dx/2, -mcu_connectors_dy, 0]) sphere(r=snap_hole_rad, $fn=20);
        translate([-mcu_connectors_dx/2, -mcu_connectors_dy, 0]) sphere(r=snap_hole_rad, $fn=20);
      }
    }
    translate([-mcu_connectors_dx/2-snap_hole_rad, mcu_y-mcu_connectors_dy, -bottom_connector_dz-snap_hole_rad]) {
      cube([mcu_connectors_dx+2*snap_hole_rad, mcu_connectors_dy+2*snap_hole_rad, snap_hole_rad]);
    }
  }
}

