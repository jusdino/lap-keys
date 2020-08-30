include <../components/switches.scad>;
include <../components/sockets.scad>;
include <../components/keycaps.scad>;

use <keyboard.scad>;

// switch_column attributes
switch_column_plate_pcb_dx = 16.5;
switch_column_plate_pcb_dy = 99.7;
switch_column_plate_pcb_dz = 1.6;
switch_column_plate_pcb_y = -7.8;

switch_column_plate_pcb_holder_inset = 1;
switch_column_plate_pcb_headroom_dz = 2;
switch_column_plate_pcb_holder_overreach_dz = 1;
switch_column_plate_pcb_holder_dz = switch_column_plate_pcb_dz + switch_column_plate_pcb_holder_overreach_dz;

switch_plate_dx = keyboard_switch_spacing * keyboard_x_count;
switch_plate_dy = keyboard_switch_spacing * keyboard_y_count;
switch_plate_dz = cherrymx_socket_hull_dz + switch_column_plate_pcb_dz + switch_column_plate_pcb_holder_overreach_dz;

//switch_plate(x_count=6, y_count=5, switch_spacing=19, pcb=false);
module switch_plate(x_count, y_count, switch_spacing, pcb=false, keys_and_caps=false) {
  plate_dz = cherrymx_socket_hull_dz + switch_column_plate_pcb_dz + switch_column_plate_pcb_holder_overreach_dz;


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
      hull_dz = cherrymx_socket_hull_dz;

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
