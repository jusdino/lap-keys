include <switches.scad>;
include <sockets.scad>;
include <keycaps.scad>;
include <map.scad>;
include <misc.scad>;

basic_tilted_right();

module sixty_percent(pcb_pins=false) {
  flat_ortho_grid(12, 5, pcb_pins);
}

module split_sixty_percent(pcb_pins=false) {
  flat_ortho_grid(6, 5, pcb_pins);
}

module three_by_three(pcb_pins=false) {
  flat_ortho_grid(3, 3, pcb_pins);
}

module flat_ortho_grid(x_count, y_count, pcb_pins=false) {
  spacing = 20;
  coords = [for (x=0;x<x_count;x=x+1) for (y=0;y<y_count;y=y+1) [x, y, 0]] * spacing;
  corners = [[0, 0, 0], [0, y_count-1, 0], [x_count-1, y_count-1, 0], [x_count-1, 0, 0]] * spacing;

  map_over_xyz(coords) {
    keycap_1u();
    cherrymx(pcb_pins);
    cherrymx_socket(pcb_pins);
  }
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

module basic_rectilinear_right(pcb_pins=false) {
  spacing = 20;
  coords = [
    [0, 0, 0], [1, 0, 0], [2, 0, 0], [0, 1, 0], [0, 2, 0], [0, 3, 0], [0, 4, 0],
    [1, 1, 0], [2, 1, 0], [3, 1, 0], [4, 1, 0], [5, 1, 0], [6, 1, 0],
    [1, 2, 0], [2, 2, 0], [3, 2, 0], [4, 2, 0], [5, 2, 0], [6, 2, 0],
    [1, 3, 0], [2, 3, 0], [3, 3, 0], [4, 3, 0], [5, 3, 0], [6, 3, 0],
    [1, 4, 0], [2, 4, 0], [3, 4, 0], [4, 4, 0], [5, 4, 0], [6, 4, 0],
  ];

  dimensions = spacing * coords;

  map_over_xyz(dimensions) {
    keycap_1u();
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
    [0,                                 -key_spacing,       0,                  0,      theta],
    [key_spacing,                       -key_spacing,       0,                  0,      theta],
    [0*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [1*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [2*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [3*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [4*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [5*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [6*key_spacing-dx_from_phi(0),      y_from_phi(0),      z_from_phi(0),      0,      theta],
    [0*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [1*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [2*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [3*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [4*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [5*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [6*key_spacing-dx_from_phi(1*dphi), y_from_phi(1*dphi), z_from_phi(1*dphi), 1*dphi, theta],
    [0*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [1*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [2*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [3*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [4*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [5*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [6*key_spacing-dx_from_phi(2*dphi), y_from_phi(2*dphi), z_from_phi(2*dphi), 2*dphi, theta],
    [0*key_spacing-dx_from_phi(3*dphi), y_from_phi(3*dphi), z_from_phi(3*dphi), 3*dphi, theta],
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
