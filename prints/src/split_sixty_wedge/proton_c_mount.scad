include <../components/mcus/proton_c.scad>;
include <../components/connectors.scad>;

use <keyboard.scad>;

proton_c_mount_usb_connector_space_dx = 14.0;
proton_c_mount_usb_connector_space_dz = 7.0;

proton_c_mount_support_overhang = 0.6;
proton_c_under_support_dz = 1.5;
proton_c_top_bottom_tolerance = 0.2;

proton_c_mount_mcu_y = -keyboard_mcu_connectors_shift_dy - keyboard_front_tab_dx;
proton_c_mount_mcu_z = proton_c_pcb_dz + proton_c_usb_dz/2 + proton_c_mount_usb_connector_space_dz/2;


// Generic names for external use
mcu_y = proton_c_mount_mcu_y;
mcu_z = proton_c_mount_mcu_z;

module mcu_mount(mcu=false) {
  proton_c_mount_top();
  proton_c_mount_bottom();
  if (mcu) {
    translate([0, mcu_y, mcu_z]) {
      rotate([180, 0, 0]) {
        proton_c();
      }
    }
  }
}

module proton_c_mount_bottom() {
  e = 0.01;

  pcb_dx = proton_c_pcb_dx;
  pcb_dy = proton_c_pcb_dy;
  pcb_dz = proton_c_pcb_dz;
  
  usb_dx = proton_c_usb_dx;
  usb_dy = proton_c_usb_dy;
  usb_dz = proton_c_usb_dz;
  
  usb_connector_space_dx = proton_c_mount_usb_connector_space_dx;
  usb_connector_space_dz = proton_c_mount_usb_connector_space_dz;
  
  support_overhang = proton_c_mount_support_overhang;

  under_support_dz = proton_c_under_support_dz;

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

module proton_c_mount_top() {
  e = 0.01;

  pcb_dx = proton_c_pcb_dx;
  pcb_dy = proton_c_pcb_dy;
  pcb_dz = proton_c_pcb_dz;
  
  usb_dx = proton_c_usb_dx;
  usb_dy = proton_c_usb_dy;
  usb_dz = proton_c_usb_dz;
  
  pin_tab_length = keyboard_mcu_pin_tab_length;

  top_bottom_tolerance = proton_c_top_bottom_tolerance;

  usb_connector_space_dx = proton_c_mount_usb_connector_space_dx;
  usb_connector_space_dz = proton_c_mount_usb_connector_space_dz;

  front_tab_dx = keyboard_front_tab_dx;
  bottom_connector_dz = keyboard_bottom_connector_dz;
  mcu_connectors_shift_dy = keyboard_mcu_connectors_shift_dy;
  mcu_connectors_dx = keyboard_mcu_connectors_dx;
  mcu_connectors_dy = keyboard_mcu_connectors_dy;
  
  support_overhang = proton_c_mount_support_overhang;

  top_cover_thickness = 1.0;
  top_cover_cavity_dz = 1.0;
  top_cover_gap_dz = 3.0;
  under_support_dz = proton_c_under_support_dz;


  // Top-cover
  difference() {
    // Outer shell
    union() {
      hull() {
        // Top block
        translate([0, mcu_y, mcu_z]) {
          translate([-pcb_dx/2-top_cover_thickness, -pcb_dy-top_cover_thickness, 0]) {
            cube([pcb_dx+2*top_cover_thickness, pcb_dy+top_cover_thickness, top_cover_thickness+top_cover_cavity_dz]);
          }
        }
        // Front bottom bar
        translate([-mcu_connectors_dx/2-front_tab_dx, -mcu_connectors_shift_dy, 0]) {
          cube([mcu_connectors_dx+2*front_tab_dx, front_tab_dx, front_tab_dx-bottom_connector_dz/2]);
        }
        // Shape that will mate with corresponding tab slot on base
        translate([mcu_connectors_dx/2, e-mcu_connectors_shift_dy-mcu_connectors_dy-front_tab_dx, 0]) {
          rotate([90, -90, 0]) {
            difference() {
              pin_slot_profile(length=2*e, pin_dy=mcu_connectors_dx, pin_dia=pin_tab_pin_dia, $fn=32);
              translate([-front_tab_dx/2-e, -front_tab_dx-e, -e]) {
                cube([front_tab_dx/2+e, mcu_connectors_dx+2*front_tab_dx+2*e, 4*e]);
              }
            }
          }
        }
      }
      // Pin tab
      translate([mcu_connectors_dx/2, -mcu_connectors_shift_dy-mcu_connectors_dy-front_tab_dx, 0]) {
        rotate([90, -90, 0]) {
          pin_tab(length=pin_tab_length, pin_dy=mcu_connectors_dx, pin_dia=pin_tab_pin_dia, $fn=32);
        }
      }
      // front tabs
      translate([0, -mcu_connectors_shift_dy, 0]) {
        translate([mcu_connectors_dx/2+front_tab_dx, 0, 0]) {
          cylinder(r=front_tab_dx, h=front_tab_dx-bottom_connector_dz/2, $fn=16);
          cube([front_tab_dx, front_tab_dx, front_tab_dx-bottom_connector_dz/2]);
        }
        translate([-mcu_connectors_dx/2-front_tab_dx, 0, 0]) {
          cylinder(r=front_tab_dx, h=front_tab_dx-bottom_connector_dz/2, $fn=16);
          translate([-front_tab_dx, 0, 0]) {
            cube([front_tab_dx, front_tab_dx, front_tab_dx-bottom_connector_dz/2]);
          }
        }
      }
    }
    translate([0, mcu_y, mcu_z]) {
      translate([-pcb_dx/2, -pcb_dy, -pcb_dz-mcu_z]) {
        // PCB body cut
        translate([-top_bottom_tolerance/2, -top_bottom_tolerance/2, -e]) {
          cube([pcb_dx+top_bottom_tolerance, pcb_dy+top_bottom_tolerance, mcu_z+pcb_dz+e]);
        }
        // Over-PCB cavity cut
        translate([support_overhang, support_overhang, mcu_z+pcb_dz-e]) {
          cube([pcb_dx-2*support_overhang, pcb_dy-2*support_overhang, top_cover_cavity_dz]);
        }
      }
    }
    // Sides cut
    translate([-mcu_connectors_dx/2-front_tab_dx-e, mcu_y-pcb_dy+support_overhang+under_support_dz, -e]) {
      cube([mcu_connectors_dx+2*front_tab_dx+2*e, pcb_dy-2*support_overhang-2*under_support_dz, top_cover_gap_dz+e]);
    }
    // USB cut
    translate([-usb_connector_space_dx/2, mcu_y-e, -e]) {
      cube([usb_connector_space_dx, -mcu_y, usb_connector_space_dz+e]);
    }
  }
}

