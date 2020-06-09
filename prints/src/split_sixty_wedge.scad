include <switches.scad>;
include <sockets.scad>;
include <keycaps.scad>;
include <abstractions.scad>;
include <bases.scad>;

split_sixty_wedge(keys_and_caps=false, sockets=false, pcb_pins=true);

module split_sixty_wedge(keys_and_caps=false, sockets=false, pcb_pins=false) {
  e = 0.01;
  x_count = 6;
  y_count = 5;
  spacing = 19;
  coords = [for (x=0;x<x_count;x=x+1) for (y=0;y<y_count;y=y+1) [x, y, 0]] * spacing;
  corners = [[0, 0, 0], [0, y_count-1, 0], [x_count-1, y_count-1, 0], [x_count-1, 0, 0]] * spacing;

  bottom_dx = spacing*(x_count-1);
  bottom_dy = spacing*(y_count-1);

  y_rotation = 50;
  z_rotation = 11;

  wall_thickness = 2;

  plus_x_dx = wall_thickness*tan(y_rotation);
  minus_x_dx = wall_thickness*(1/tan(y_rotation) + 1/sin(y_rotation));
  subtraction_corners = [
    [plus_x_dx, -e, -wall_thickness],
    [plus_x_dx, (y_count-1)*spacing+1, -wall_thickness],
    [(x_count-1)*spacing-minus_x_dx, (y_count-1)*spacing+1, -wall_thickness],
    [(x_count-1)*spacing-minus_x_dx, -e, -wall_thickness]];

  color(cherrymx_base_color) {
    difference() {
      hull() {
        wedge_mirror() {
          map_over_xyz(corners) {
            cherrymx_base_bottom();
          }
        }
      }
      hull() {
        wedge_mirror() {
          map_over_xyz(subtraction_corners) {
            cherrymx_base_bottom();
          }
        }
      }
    }
    wedge_mirror() {
      flat_ortho_grid(
        x_count,
        y_count,
        spacing=spacing,
        keys_and_caps=false,
        sockets=false,
        base=true,
        pcb_pins=pcb_pins
      );
    }
  }
  wedge_mirror() {
    flat_ortho_grid(
      x_count,
      y_count,
      spacing=spacing,
      keys_and_caps=keys_and_caps,
      sockets=sockets,
      base=false,
      pcb_pins=pcb_pins
    );
  }
  
  module wedge_mirror() {
    wedge_rotate() {
      children();
    }
    mirror([1, 0, 0]) {
      wedge_rotate() {
        children();
      }
    }
  }

  module wedge_rotate() {
    rotate([0, y_rotation, z_rotation]) {
      translate([cherrymx_base_base_dx/2, -bottom_dy-cherrymx_base_base_dy/2, -cherrymx_base_base_z]) {
        children();
      }
    }
  }
}

