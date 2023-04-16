include <../components/mcus/proton_c.scad>;
include <../components/connectors.scad>;

use <keyboard.scad>;

proton_c_mount_usb_connector_space_dx = 14.0;
proton_c_mount_usb_connector_space_dz = 7.0;

proton_c_mount_support_overhang = 0.6;
proton_c_under_support_dz = 1.5;
proton_c_top_bottom_tolerance = 0.2;

proton_c_mount_mcu_dz = proton_c_pcb_dz + proton_c_usb_dz/2 + proton_c_mount_usb_connector_space_dz/2;
proton_c_top_cover_thickness = 1.0;


// Generic names for external use
mcu_mount_dx = proton_c_pcb_dx;
mcu_mount_dz = proton_c_mount_mcu_dz;
mcu_mount_mcu_translation = [0, -1-mcu_mount_dz*sin(keyboard_front_plane_x_rotation), mcu_mount_dz];
  

module mcu_mount(mcu=false) {
  thickness = proton_c_top_cover_thickness;
  mcu_dz = proton_c_mount_mcu_dz;
  front_plane_x_rotation = keyboard_front_plane_x_rotation;
  front_plane_y_rotation = keyboard_front_plane_y_rotation;
  translate([0, -thickness-mcu_dz*sin(front_plane_x_rotation), 0]) {
    proton_c_mount();
    if (mcu) {
      translate([0, 0, mcu_dz]) {
        rotate([180, 0, 0]) {
          *proton_c();
        }
      }
    }
  }
}

module proton_c_mount() {
  e = 0.01;

  pcb_dy = proton_c_pcb_dy;
  pcb_dz = proton_c_pcb_dz;

  usb_dx = proton_c_usb_dx;
  usb_dy = proton_c_usb_dy;
  usb_dz = proton_c_usb_dz;
  
  usb_connector_space_dx = proton_c_mount_usb_connector_space_dx;
  usb_connector_space_dz = proton_c_mount_usb_connector_space_dz;
  
  thickness = proton_c_top_cover_thickness;
  front_plane_x_rotation = keyboard_front_plane_x_rotation;
  support_overhang = proton_c_mount_support_overhang;

  under_support_dz = proton_c_under_support_dz;

  // Under-pcb support
  translate([-mcu_mount_dx/2, -pcb_dy, -e]) {
    difference() {
      union() {
        // Main block
        cube([mcu_mount_dx, pcb_dy, mcu_mount_dz-pcb_dz]);
        // Front wedge
        hull() {
          translate([0, pcb_dy-e, 0]) {
            cube([mcu_mount_dx, thickness+mcu_mount_dz*sin(front_plane_x_rotation)+e, e]);
            translate([0, 0, mcu_mount_dz]) {
              cube([mcu_mount_dx, thickness+mcu_mount_dz*(sin(front_plane_x_rotation)-tan(front_plane_x_rotation))+e, e]);
            }
          }
        }
      }
      // Sloped interior hollow
      hull() {
        translate([support_overhang, support_overhang, mcu_mount_dz-pcb_dz]) {
          cube([mcu_mount_dx-2*support_overhang, pcb_dy-2*support_overhang, e]);
        }
        translate([support_overhang+under_support_dz, support_overhang+under_support_dz, under_support_dz]) {
          cube([mcu_mount_dx-2*support_overhang-2*under_support_dz, pcb_dy-2*support_overhang-2*under_support_dz, e]);
        }
      }
      // Side cut
      translate([-e, support_overhang+under_support_dz, under_support_dz]) {
        cube([mcu_mount_dx+2*e, pcb_dy-2*support_overhang-2*under_support_dz, mcu_mount_dz-pcb_dz-under_support_dz+e]);
      }
      // USB cut
      translate([mcu_mount_dx/2-usb_dx/2, pcb_dy-support_overhang-under_support_dz, mcu_mount_dz-pcb_dz-usb_dz]) {
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
      // USB box cut
      translate([mcu_mount_dx/2-usb_connector_space_dx/2, pcb_dy-2*e, -e]) {
        cube([usb_connector_space_dx, 10, usb_connector_space_dz+e]);
      }
    }
    // MCU rear support
    translate([0, -thickness, 0]) {
      cube([mcu_mount_dx, thickness+e, mcu_mount_dz+thickness]);
    }
    translate([0, -e, mcu_mount_dz]) {
      cube([mcu_mount_dx, support_overhang, thickness]);
    }
  }
}

