// Base for key plate
include <sockets.scad>;

cherrymx_base_socket_tolerance = 0.2;
cherrymx_base_socket_dx = cherrymx_socket_hull_dx + cherrymx_base_socket_tolerance;
cherrymx_base_socket_dy = cherrymx_socket_hull_dy + cherrymx_base_socket_tolerance;
cherrymx_base_socket_dz = cherrymx_socket_hull_dz;

cherrymx_base_top_dz = 4;
cherrymx_base_wall_thickness = 1;

cherrymx_base_shelf_dx = 14.1;
cherrymx_base_shelf_dy = 14.1;
cherrymx_base_shelf_dz = 1;
cherrymx_base_shelf_z = -cherrymx_base_shelf_dz-cherrymx_base_socket_dz;

cherrymx_base_base_dx = cherrymx_base_socket_dx + 2*cherrymx_base_wall_thickness;
cherrymx_base_base_dy = cherrymx_base_socket_dy + 2*cherrymx_base_wall_thickness;
cherrymx_base_base_dz = 6 + cherrymx_base_socket_dz - cherrymx_base_top_dz;
cherrymx_base_base_z = -cherrymx_base_top_dz - cherrymx_base_base_dz;

cherrymx_base_socket_pocket_dx = cherrymx_base_socket_dx + cherrymx_base_socket_tolerance;
cherrymx_base_socket_pocket_dy = cherrymx_base_socket_dy + cherrymx_base_socket_tolerance;

cherrymx_base_cavity_z = cherrymx_base_base_z + cherrymx_base_wall_thickness;
cherrymx_base_cavity_dz = cherrymx_base_socket_dz-cherrymx_base_wall_thickness;
cherrymx_base_color = [26/255, 50/255, 170/255]; 


module cherrymx_base_positive() {
  base_dx = cherrymx_base_base_dx;
  base_dy = cherrymx_base_base_dy;
  base_dz = cherrymx_base_base_dz;
  base_z = cherrymx_base_base_z;

  base_color = cherrymx_base_color;

  color(base_color) translate([-base_dx/2, -base_dy/2, base_z]) {
    cube([base_dx, base_dy, base_dz]);
  }
}

module cherrymx_base_negative() {
  e = 0.01;

  socket_dz = cherrymx_base_socket_dz;

  shelf_dx = cherrymx_base_shelf_dx;
  shelf_dy = cherrymx_base_shelf_dy;

  base_dx = cherrymx_base_base_dx;
  base_dy = cherrymx_base_base_dy;

  socket_pocket_dx = cherrymx_base_socket_pocket_dx;
  socket_pocket_dy = cherrymx_base_socket_pocket_dy;

  cavity_z = cherrymx_base_cavity_z;

  // Socket pocket
  translate([-socket_pocket_dx/2, -socket_pocket_dy/2, -socket_dz]) {
    cube([socket_pocket_dx, socket_pocket_dy, socket_dz]);
  }
  // Cavity X-axis
  translate([-base_dx/2-e, -shelf_dy/2, cavity_z]) {
    cube([base_dx+2*e, shelf_dy, -cavity_z+e]);
  }
  // Cavity Y-axis
  translate([-shelf_dx/2, -base_dy/2-e, cavity_z]) {
    cube([shelf_dx, base_dy+2*e, -cavity_z+e]);
  }
}

module cherrymx_base_bottom() {
  e = 0.01;
  
  base_dx = cherrymx_base_base_dx;
  base_dy = cherrymx_base_base_dy;
  bottom_dz = cherrymx_base_cavity_z - cherrymx_base_base_z;
  base_z = cherrymx_base_base_z;

  base_color = cherrymx_base_color;

  color(base_color) translate([-base_dx/2, -base_dy/2, base_z]) {
    cube([base_dx, base_dy, bottom_dz]);
  }
}

module cherrymx_base_corner_clip(
  minus_x_minus_y=false,
  minus_x_plus_y=false,
  plus_x_minus_y=false,
  plus_x_plus_y=false
) {
  e = 0.01;

  socket_dz = cherrymx_base_socket_dz;
  top_dz = cherrymx_base_top_dz;
  wall_thickness = cherrymx_base_wall_thickness;

  base_dx = cherrymx_base_base_dx;
  base_dy = cherrymx_base_base_dy;

  clip_overreach_dz = 1;
  clip_overreach = 0.5;

  clip_cut = wall_thickness + clip_overreach;

  base_color = cherrymx_base_color;

  color(base_color) {
    if (minus_x_minus_y) {
      translate([-base_dx/2, -base_dy/2, -top_dz]) {
        difference() {
          translate([0, 0, -e]) {
            cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+e]);
          }
          translate([clip_cut, clip_cut, -2*e]) {
            cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+3*e]);
          }
        }
      }
    }
    if (minus_x_plus_y) {
      translate([-base_dx/2, base_dy/2, -top_dz]) {
        rotate([0, 0, -90]) {
          difference() {
            translate([0, 0, -e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+e]);
            }
            translate([clip_cut, clip_cut, -2*e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+3*e]);
            }
          }
        }
      }
    }
    if (plus_x_minus_y) {
      translate([base_dx/2, -base_dy/2, -top_dz]) {
        rotate([0, 0, 90]) {
          difference() {
            translate([0, 0, -e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+e]);
            }
            translate([clip_cut, clip_cut, -2*e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+3*e]);
            }
          }
        }
      }
    }
    if (plus_x_plus_y) {
      translate([base_dx/2, base_dy/2, -top_dz]) {
        rotate([0, 0, 180]) {
          difference() {
            translate([0, 0, -e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+e]);
            }
            translate([clip_cut, clip_cut, -2*e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+3*e]);
            }
          }
        }
      }
    }
  }
}
