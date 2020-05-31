// Key plate base


module cherrymx_base_positive() {
  socket_tolerance = 0.2;

  socket_dx = 23.6 + socket_tolerance;
  socket_dy = 23.6 + socket_tolerance;
  socket_dz = 6;

  top_dz = 4;

  wall_thickness = 1;

  base_dx = socket_dx + 2*wall_thickness;
  base_dy = socket_dy + 2*wall_thickness;
  base_dz = 6 + socket_dz - top_dz;
  base_z = -top_dz - base_dz;

  socket_color = [26/255, 50/255, 170/255];

  color(socket_color) translate([-base_dx/2, -base_dy/2, base_z]) {
    cube([base_dx, base_dy, base_dz]);
  }
}

module cherrymx_base_negative() {
  e = 0.01;

  socket_tolerance = 0.2;
  socket_dx = 23.6 + socket_tolerance;
  socket_dy = 23.6 + socket_tolerance;
  socket_dz = 6;

  top_dz = 4;
  wall_thickness = 1;

  shelf_dx = 14.1;
  shelf_dy = 14.1;
  shelf_dz = 1;
  shelf_z = -shelf_dz-socket_dz;

  base_dx = socket_dx + 2*wall_thickness;
  base_dy = socket_dy + 2*wall_thickness;
  base_dz = 6 + socket_dz - top_dz;
  base_z = -top_dz - base_dz;

  socket_pocket_dx = socket_dx + socket_tolerance;
  socket_pocket_dy = socket_dy + socket_tolerance;

  cavity_z = base_z + wall_thickness;
  cavity_dz = socket_dz-wall_thickness;

  translate([-socket_pocket_dx/2, -socket_pocket_dy/2, -socket_dz]) {
    cube([socket_pocket_dx, socket_pocket_dy, socket_dz]);
  }
  translate([-base_dx/2-e, -shelf_dy/2, cavity_z]) {
    cube([base_dx+2*e, shelf_dy, cavity_dz+e]);
  }
  translate([-shelf_dx/2, -base_dy/2-e, cavity_z]) {
    cube([shelf_dx, base_dy+2*e, cavity_dz+e]);
  }
}

module cherrymx_base_corner_clip(
  minus_x_minus_y=false,
  minus_x_plus_y=false,
  plus_x_minus_y=false,
  plus_x_plus_y=false
) {
  e = 0.01;
  corners = [minus_x_minus_y, minus_x_plus_y, plus_x_plus_y, plus_x_minus_y];

  socket = 0;
  socket_tolerance = 0.2;

  socket_dx = 23.6 + socket_tolerance;
  socket_dy = 23.6 + socket_tolerance;
  socket_dz = 6;

  top_dz = 4;

  wall_thickness = 1;

  base_dx = socket_dx + 2*wall_thickness;
  base_dy = socket_dy + 2*wall_thickness;
  base_dz = 6 + socket_dz - top_dz;
  base_z = -top_dz - base_dz;

  clip_overreach_dz = 1;
  clip_overreach = 0.5;

  clip_cut = wall_thickness + clip_overreach;

  socket_color = [26/255, 50/255, 170/255];

  color(socket_color) for (i=[0:1:3]) {
    if (corners[i]) {
      rotate([0, 0, -i*90]) {
        translate([-base_dx/2, -base_dy/2, -top_dz]) {
          difference() {
            translate([0, 0, -e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+e]);
            }
            translate([clip_cut, clip_cut, -e]) {
              cube([socket_dz, socket_dz, top_dz+clip_overreach_dz+2*e]);
            }
          }
        }
      }
    }
  }
}
