// Utility module to quickly map a module over coordinates or some other pre-defined abstractions
//
// map_over_coordinates([[0, 0, 0], [20, 20, 20]]) {
//   cherrymx();
// }

include <components/switches.scad>;
include <components/sockets.scad>;
include <components/keycaps.scad>;

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
