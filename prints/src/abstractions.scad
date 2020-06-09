// Utility module to quickly map a module over coordinates or some other pre-defined abstractions
//
// map_over_coordinates([[0, 0, 0], [20, 20, 20]]) {
//   cherrymx();
// }

include <switches.scad>;
include <sockets.scad>;
include <keycaps.scad>;
include <bases.scad>;

module map_over_xyz(coordinates) {
  for (i=coordinates) {
    translate(i) {
      children();
    }
  }
}

module map_over_xyzpt(coordinates) {
  for (i=coordinates) {
    translate([i[0], i[1], i[2]]) {
      rotate([i[3], 0, 0]) {
        rotate([0, 0, i[4]]) {
          children();
        }
      }
    }
  }
}

module flat_ortho_grid(
  x_count,
  y_count,
  spacing=20,
  keys_and_caps=false,
  sockets=false,
  base=false,
  pcb_pins=false
) {
  coords = [for (x=0;x<x_count;x=x+1) for (y=0;y<y_count;y=y+1) [x, y, 0]] * spacing;
  corners = [[0, 0, 0], [0, y_count-1, 0], [x_count-1, y_count-1, 0], [x_count-1, 0, 0]] * spacing;

  map_over_xyz(coords) {
    if (keys_and_caps) {
      keycap_1u();
      cherrymx(pcb_pins);
    }
    if (sockets) {
      cherrymx_socket(pcb_pins);
    }
  }
  if (base) {
    difference() {
      union() {
        map_over_xyz(coords) {
          cherrymx_base_positive();
        }
        translate(corners[0]) cherrymx_base_corner_clip(minus_x_minus_y=true);
        translate(corners[1]) cherrymx_base_corner_clip(minus_x_plus_y=true);
        translate(corners[2]) cherrymx_base_corner_clip(plus_x_plus_y=true);
        translate(corners[3]) cherrymx_base_corner_clip(plus_x_minus_y=true);
      }
      map_over_xyz(coords) {
        cherrymx_base_negative();
      }
    }
  }
}

