module PMW3360_assembly() {
  // Mock-up of a PCB with mounted PMW3360 sensor and LM19-LSI lens for fitting
  // https://www.tindie.com/products/jkicklighter/pmw3360-motion-sensor/

  e = 0.01;

  board_dx = 21.1;
  board_dy = 28.3;
  board_dz = 1.6;

  hole_dia = 2.4;
  hole_coords = [[board_dx/2, hole_dia/2+1.0, 0],
                 [board_dx/2, board_dy-(hole_dia/2+0.7), 0]];

  lens_dx = 18.9;
  lens_dy = 21.3;
  lens_dz = 3.5;
  lens_corner_rad = 7.0;
  lens_center = [board_dx/2, 13.6, 0];
  lens_wedge_dz = 1.0;
  lens_wedge_dx = 4.0;
  lens_wedge_offset_dz = 3.5;

  chip_dx = 10.0;
  chip_dy = 15.6;
  chip_dz = 2.5;
  chip_offset_dy = 5.6;

  translate([0, 0, -board_dz-lens_dz-lens_wedge_dz]) {
    // PCB
    color("DarkGreen") translate(-lens_center) difference() {
      cube([board_dx, board_dy, board_dz]);
      for(coords = hole_coords) {
        translate(coords) translate([0, 0, -e]) cylinder(d=hole_dia, h=board_dz+2*e);
      }
    }
    // Lens (LM19-LSI)
    color("LightBlue") {
      translate([-lens_dx/2, -lens_dy/2, board_dz-e]) {
        difference() {
          cube([lens_dx, lens_dy, lens_dz+e]);
          for(i = [[0, [0, 0, 0]],
                   [90, [lens_dx, 0, 0]],
                   [180, [lens_dx, lens_dy, 0]],
                   [270, [0, lens_dy, 0]]]) {
            translate(i[1]) rotate([0, 0, i[0]]) {
              translate([-e, -e, -e]) difference() {
              cube([lens_corner_rad+e, lens_corner_rad+e, lens_dz+3*e]);
                translate([lens_corner_rad, lens_corner_rad, -e]) {
                  cylinder(r=lens_corner_rad, h=lens_dz+4*e);
                }
              }
            }
          }
        }
      }
      translate([-lens_wedge_dx/2, 0, board_dz+lens_dz-e]) {
        cube([lens_wedge_dx, lens_wedge_offset_dz+lens_wedge_dz/2, lens_wedge_dz+e]);
      }
    }
    // Chip (PMW3360)
    color("DimGray") translate([-chip_dx/2, chip_offset_dy-board_dy/2, -chip_dz]) {
      cube([chip_dx, chip_dy, chip_dz]);
    }
  }
}

