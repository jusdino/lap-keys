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
  cavity_dz = shelf_z - cavity_z;

  translate([-socket_pocket_dx/2, -socket_pocket_dy/2, -socket_dz]) {
    cube([socket_pocket_dx, socket_pocket_dy, socket_dz]);
  }
  translate([-shelf_dx/2, -shelf_dy/2, shelf_z-e]) {
    cube([shelf_dx, shelf_dy, shelf_dz+2*e]);
  }
  translate([-base_dx/2-e, -shelf_dy/2, cavity_z]) {
    cube([base_dx+2*e, shelf_dy, cavity_dz]);
  }
  translate([-shelf_dx/2, -base_dy/2-e, cavity_z]) {
    cube([shelf_dx, base_dy+2*e, cavity_dz]);
  }
}

