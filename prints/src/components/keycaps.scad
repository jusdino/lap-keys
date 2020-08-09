// Keycap geometries. Locations are estimated height above the switch plate

module keycap_1u() {
  e = 0.01;
  base_dx = 18;
  base_dy = 18;
  top_dx = 13;
  top_dy = 13;
  body_dz = 8.6;

  plate_dz = 7;

  translate([0, 0, plate_dz]) {
    hull() {
      translate([-base_dx/2, -base_dy/2, 0]) {
        cube([base_dx, base_dy, e]);
      }
      translate([-top_dx/2, -top_dy/2, body_dz]) {
        cube([top_dx, top_dy, e]);
      }
    }
  }
}
