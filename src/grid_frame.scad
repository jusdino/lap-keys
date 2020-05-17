include <switches.scad>;
include <sockets.scad>;
include <map.scad>;

*basic_rectilinear_right(pcb_pins=true);
basic_tilted_right(pcb_pins=true);

module basic_rectilinear_right(pcb_pins=false) {
  spacing = 17.5;
  coords = [
    [0, 0, 0], [1, 0, 0], [0, 1, 0],
    [1, 1, 0], [2, 1, 0], [3, 1, 0], [4, 1, 0], [5, 1, 0],
    [1, 2, 0], [2, 2, 0], [3, 2, 0], [4, 2, 0], [5, 2, 0],
    [1, 3, 0], [2, 3, 0], [3, 3, 0], [4, 3, 0], [5, 3, 0],
    [1, 4, 0], [2, 4, 0], [3, 4, 0], [4, 4, 0], [5, 4, 0],
  ];

  dimensions = spacing * coords;

  map_over_xyz(dimensions) {
    cherrymx(pcb_pins);
    cherrymx_socket(pcb_pins);
  }
}

module basic_tilted_right(pcb_pins=false) {
  coords = [
    [0, 0, 0, 0, 0], [18, 0, 0, 0, 0], [0, 18, 0, 0, 0],
    [18, 18, 0, 0, 4], [36, 18, 0, 0, 4], [54, 18, 0, 0, 4], [72, 18, 0, 0, 4], [90, 18, 0, 0, 4],
    [16, 36, 1.8, 5, 4], [34, 36, 1.8, 5, 4], [52, 36, 1.8, 5, 4], [70, 36, 1.8, 5, 4], [88, 36, 1.8, 5, 4],
    [14, 54, 3.6, 10, 4], [32, 54, 3.6, 10, 4], [50, 54, 3.6, 10, 4], [68, 54, 3.6, 10, 4], [86, 54, 3.6, 10, 4],
    [12, 72, 6.3, 15, 4], [30, 72, 6.3, 15, 4], [48, 72, 6.3, 15, 4], [66, 72, 6.3, 15, 4], [84, 72, 6.3, 15, 4],
  ];

  map_over_xyzpt(coords) {
    cherrymx(pcb_pins);
    cherrymx_socket(pcb_pins);
  }
}
