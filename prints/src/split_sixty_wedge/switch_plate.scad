include <../components/switches.scad>;
include <../components/sockets.scad>;
include <../components/keycaps.scad>;

use <keyboard.scad>;

// switch_plate_pcb attributes
switch_plate_pcb_tolerance = 0.1;
switch_plate_pcb_dx = 121.6 + 2*switch_plate_pcb_tolerance;
switch_plate_pcb_dy = 102.6 + 2*switch_plate_pcb_tolerance;
switch_plate_pcb_dz = 1.6;
switch_plate_pcb_x = -13.3 - switch_plate_pcb_tolerance;
switch_plate_pcb_y = -13.3 - switch_plate_pcb_tolerance;

switch_plate_pcb_holder_inset = 0.5;
switch_plate_pcb_headroom_dz = 0.6;
switch_plate_pcb_outer_headroom_dz = 1.6;
switch_plate_pcb_outer_headroom_dxy = 6;
switch_plate_pcb_holder_overreach_dxy = 1.2;
switch_plate_pcb_holder_overreach_dz = 1;
switch_plate_pcb_holder_dx = (keyboard_x_count-1)*keyboard_switch_spacing + cherrymx_socket_hull_dx;
switch_plate_pcb_holder_dy = (keyboard_y_count-1)*keyboard_switch_spacing + cherrymx_socket_hull_dy;
switch_plate_pcb_holder_dz = switch_plate_pcb_dz + switch_plate_pcb_holder_overreach_dz;
switch_plate_pcb_holder_bridge_dx = 3.0;

switch_plate_dx = switch_plate_pcb_dx + 2*switch_plate_pcb_holder_overreach_dxy;
switch_plate_dy = switch_plate_pcb_dy + 2*switch_plate_pcb_holder_overreach_dxy;
switch_plate_dz = cherrymx_socket_hull_dz + switch_plate_pcb_dz + switch_plate_pcb_holder_overreach_dz;

//switch_plate();
module switch_plate() {
  e = 0.01;

  x_count = keyboard_x_count;
  y_count = keyboard_y_count;
  switch_spacing = keyboard_switch_spacing;

  pcb_dx = switch_plate_pcb_dx;
  pcb_dy = switch_plate_pcb_dy;
  pcb_dz = switch_plate_pcb_dz;
  pcb_x = switch_plate_pcb_x;
  pcb_y = switch_plate_pcb_y;

  hull_dx = cherrymx_socket_hull_dx;
  hull_dy = cherrymx_socket_hull_dy;
  hull_dz = cherrymx_socket_hull_dz;

  plate_dx = cherrymx_socket_plate_dx;
  plate_dy = cherrymx_socket_plate_dy;
  plate_dz = cherrymx_socket_hull_dz + switch_plate_pcb_dz + switch_plate_pcb_holder_overreach_dz;

  pcb_holder_inset = switch_plate_pcb_holder_inset;
  pcb_headroom_dz = switch_plate_pcb_headroom_dz;
  pcb_outer_headroom_dz = switch_plate_pcb_outer_headroom_dz;
  pcb_outer_headroom_dxy = switch_plate_pcb_outer_headroom_dxy;
  pcb_holder_overreach_dxy = switch_plate_pcb_holder_overreach_dxy;
  pcb_holder_overreach_dz = switch_plate_pcb_holder_overreach_dz;
  pcb_holder_dx = switch_plate_pcb_holder_dx;
  pcb_holder_dy = switch_plate_pcb_holder_dy;
  pcb_holder_dz = switch_plate_pcb_holder_dz;
  pcb_holder_bridge_dx = switch_plate_pcb_holder_bridge_dx;

  socket_color = cherrymx_socket_color;


  translate([-pcb_x+pcb_holder_overreach_dxy, -pcb_y-pcb_dy-pcb_holder_overreach_dxy, plate_dz]) {
    if (pcbs) {
      color("green") {
        translate([pcb_x, pcb_y, -hull_dz-pcb_dz]) {
          cube([pcb_dx, pcb_dy, pcb_dz+e]);
        }
      }
    }
    color(socket_color) {
      difference() {
        union() {
          difference() {
            // Main key plate
            grid(x_count, y_count) {
              cherrymx_plate_base();
            }
            translate([pcb_x, pcb_y, -hull_dz-pcb_dz]) {
              // PCB headroom
              translate([pcb_holder_inset, pcb_holder_inset, pcb_dz-e]) {
                cube([pcb_dx-2*pcb_holder_inset, pcb_dy-2*pcb_holder_inset, pcb_headroom_dz+e]);
              }
            }
          }
          translate([0, 0, -hull_dz]) {
            difference() {
              union() {
                // Plate Y bridges
                for (i= [1:x_count-1]) {
                  translate([(i-1/2)*switch_spacing-pcb_holder_bridge_dx/2, -hull_dx/2, 0]) {
                      cube([pcb_holder_bridge_dx, pcb_holder_dy, pcb_headroom_dz+e]);
                  }
                }
                // Plate X bridges
                for (i= [1:y_count-1]) {
                  translate([-hull_dy/2, (i-1/2)*switch_spacing-pcb_holder_bridge_dx/2, 0]) {
                      cube([pcb_holder_dx, pcb_holder_bridge_dx, pcb_headroom_dz+e]);
                  }
                }
              }
              // Skip bridge over headers
              translate([(1/2)*switch_spacing-pcb_holder_bridge_dx/2-e, 3*switch_spacing-hull_dx/2+pcb_holder_bridge_dx/2, -e]) {
                  cube([pcb_holder_bridge_dx+2*e, (y_count-4)*switch_spacing+hull_dy+e, pcb_headroom_dz+3*e]);
              }
              translate([(x_count-3/2)*switch_spacing-pcb_holder_bridge_dx/2-e, 3*switch_spacing-hull_dx/2+pcb_holder_bridge_dx/2, -e]) {
                  cube([pcb_holder_bridge_dx+2*e, (y_count-4)*switch_spacing+hull_dy+e, pcb_headroom_dz+3*e]);
              }
            }
          }
          // Outer edges
          difference() {
            translate([pcb_x-pcb_holder_overreach_dxy, pcb_y-pcb_holder_overreach_dxy, -hull_dz-pcb_dz-pcb_holder_overreach_dz]) {
              cube([pcb_dx+2*pcb_holder_overreach_dxy, pcb_dy+2*pcb_holder_overreach_dxy, hull_dz+pcb_dz+pcb_holder_overreach_dz]);
            }
            // PCB slot
            translate([pcb_x, pcb_y, -hull_dz-pcb_dz-pcb_holder_overreach_dz-e]) {
              cube([pcb_dx, pcb_dy, pcb_holder_overreach_dz+pcb_dz+e]);
            }
            // key plate cut-out
            translate([-hull_dx/2, -hull_dy/2, -hull_dz-e]) {
              cube([pcb_holder_dx, pcb_holder_dy, hull_dz+2*e]);
            }
          }
        }
        // Outer LED headroom
        translate([pcb_x+pcb_holder_inset, pcb_y+pcb_holder_inset, -hull_dz-e]) {
          cube([pcb_outer_headroom_dxy, pcb_dy-2*pcb_holder_inset, pcb_outer_headroom_dz]);
          cube([pcb_dx-2*pcb_holder_inset, pcb_outer_headroom_dxy, pcb_outer_headroom_dz]);
        }
        translate([pcb_x+pcb_holder_inset, pcb_y+pcb_dy-pcb_holder_inset-pcb_outer_headroom_dxy, -hull_dz-e]) {
          cube([pcb_dx-2*pcb_holder_inset, pcb_outer_headroom_dxy, pcb_outer_headroom_dz]);
        }
        translate([pcb_x+pcb_dx-pcb_holder_inset-pcb_outer_headroom_dxy, pcb_y+pcb_holder_inset, -hull_dz-e]) {
          cube([pcb_outer_headroom_dxy, pcb_dy-2*pcb_holder_inset, pcb_outer_headroom_dz]);
        }
      }
    }
    if (keys_and_caps) {
      grid(x_count, y_count) {
        cherrymx(pcb_pins=true);
        keycap_1u();
      }
    }
  }

  module grid(x_count, y_count) {
    for (i= [0:y_count-1]) {
      translate([0, switch_spacing*i, 0]) {
        for (j= [0:x_count-1]) {
          translate([switch_spacing*j, 0, 0]) {
            union() {
              children();
            }
          }
        }
      }
    }
  }
}
