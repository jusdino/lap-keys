include <switches.scad>;
include <sockets.scad>;
include <keycaps.scad>;
include <map.scad>;
include <misc.scad>;

basic_rectilinear_right(pcb_pins=true);
*basic_tilted_right(pcb_pins=true);
// cherrymx(pcb_pins=true);
// cherrymx_socket(pcb_pins=true);
// difference() {
//   cherrymx_base_positive();
//   cherrymx_base_negative();
// }
// keycap_1u();

module basic_rectilinear_right(pcb_pins=false) {
  spacing = 17.5;
  coords = [
    [0, 0, 0], [1, 0, 0], [0, 1, 0],
    [1, 1, 0], [2, 1, 0], [3, 1, 0], [4, 1, 0], [5, 1, 0], [6, 1, 0],
    [1, 2, 0], [2, 2, 0], [3, 2, 0], [4, 2, 0], [5, 2, 0], [6, 2, 0],
    [1, 3, 0], [2, 3, 0], [3, 3, 0], [4, 3, 0], [5, 3, 0], [6, 3, 0],
    [1, 4, 0], [2, 4, 0], [3, 4, 0], [4, 4, 0], [5, 4, 0], [6, 4, 0],
  ];

  dimensions = spacing * coords;

  map_over_xyz(dimensions) {
    cherrymx(pcb_pins);
    cherrymx_socket(pcb_pins);
  }
  difference() {
    map_over_xyz(dimensions) {
      cherrymx_base_positive();
    }
    map_over_xyz(dimensions) {
      cherrymx_base_negative();
    }
  }
}

module basic_tilted_right(pcb_pins=false) {
  key_spacing = 20;
  curve_x_rad = 150;
  arc_length = key_spacing;
  dphi = (360*arc_length)/(2*PI*curve_x_rad);
  function y_from_phi(phi) = sin(phi)*curve_x_rad;
  function z_from_phi(phi) = curve_x_rad * (1 - cos(phi));
  function dx_from_phi(phi) = 2*phi/dphi;
  theta = atan(2/key_spacing);
  coords = [
  // X                                  Y                   Z                   PHI,    THETA
    [0,                                 -key_spacing,       0,                  0,      0    ],
    [key_spacing,                       -key_spacing,       0,                  0,      0    ],
    [0*key_spacing,                     0,                  0,                  0,      0    ],
    [1*key_spacing,                     y_from_phi(0),      z_from_phi(0),      0,      theta],
    [2*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [3*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [4*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [5*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [6*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [1*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [2*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [3*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [4*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [5*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [6*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [1*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [2*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [3*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [4*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [5*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [6*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [1*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
    [2*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
    [3*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
    [4*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
    [5*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
    [6*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
  ];

  map_over_xyzpt(coords) {
    keycap_1u();
    cherrymx(pcb_pins);
    cherrymx_socket(pcb_pins);
  }
  difference() {
    map_over_xyzpt(coords) {
      cherrymx_base_positive();
    }
    map_over_xyzpt(coords) {
      cherrymx_base_negative();
    }
  }
}
