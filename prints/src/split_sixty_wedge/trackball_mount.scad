include <../components/PMW3360.scad>;

trackball_mount(trackball=false, sensor=false, bearings=false);
module trackball_mount(trackball=false, sensor=false, bearings=false) {
  e = 0.01;

	ball_dia = 34.0;
  bearing_headroom = 0.8;
  bearing_dia = 2.0;
  bearing_contact_dphi = 80;
  top_contact_dt = 95;
  hole_dia = ball_dia + 2*bearing_headroom;
  //hole_overreach_dr = 0.25;
  //hole_overreach_dz = sqrt(pow(hole_dia/2, 2) - pow((ball_dia/2)-hole_overreach_dr, 2));
  hole_overreach_dz = bearing_dia/2-(hole_dia/2 * cos(top_contact_dt));
  outer_dia = hole_dia + 2*bearing_dia;

  assembly_cavity_dz = 10.0;
  cavity_offset_dz = 1.0;
  lens_cavity_dx = 19.4;
  lens_cavity_dy = 21.8;
  lens_cavity_dz = 3.5;
  board_cavity_dx = 22.0;
  board_cavity_dy = 29.0;
  board_cavity_dz = assembly_cavity_dz - lens_cavity_dz - cavity_offset_dz;
  board_cavity_offset_dy = 13.9;
  wire_cavity_dy = 20.0;
  wire_cavity_outer_dz = 2.0;
  wire_cavity_inner_dz = board_cavity_dz + 2.0;

  optics_cavity_dx = 5.0;
  optics_cavity_dy = 9.0;
  optics_cavity_dz = hole_dia/2;

  if (trackball) {
    translate([0, 0, hole_dia/2]) {
      color("DarkRed") sphere(d=ball_dia, $fa=1);
    }
  }
  if(sensor) {
    PMW3360_assembly();
  }
  translate([-hole_dia/2, -hole_dia/2, 0]) {
    color("MediumBlue") {
      // Main body
      difference() {
        translate([hole_dia/2, hole_dia/2, -assembly_cavity_dz]) {
          //cube([hole_dia, hole_dia, assembly_cavity_dz+hole_dia/2 + hole_overreach_dz]);
          cylinder(d=outer_dia, h=assembly_cavity_dz+hole_dia/2 + hole_overreach_dz);
        }
        // Trackball hole
        translate([hole_dia/2, hole_dia/2, hole_dia/2]) {
          sphere(d=hole_dia, $fa=1);
        }
        // Bearing holes
        bearings(bearing_contact_dphi);
        // Sensor cavity
        translate([hole_dia/2-board_cavity_dx/2, hole_dia/2-board_cavity_offset_dy, -assembly_cavity_dz-e]) {
          cube([board_cavity_dx, board_cavity_dy, board_cavity_dz+e]);
        }
        translate([hole_dia/2-lens_cavity_dx/2, hole_dia/2-lens_cavity_dy/2, -assembly_cavity_dz+board_cavity_dz-e]) {
          cube([lens_cavity_dx, lens_cavity_dy, lens_cavity_dz+2*e]);
        }
        hull() {
          translate([-bearing_dia-e, hole_dia/2-wire_cavity_dy/2, -assembly_cavity_dz-e]) {
            cube([e, wire_cavity_dy, wire_cavity_outer_dz+e]);
          }
          translate([hole_dia/2-board_cavity_dx/2, hole_dia/2-wire_cavity_dy/2, -assembly_cavity_dz-e]) {
            cube([wire_cavity_outer_dz, wire_cavity_dy, wire_cavity_inner_dz+e]);
          }
        }
        // Optics cavity
        translate([hole_dia/2-optics_cavity_dx/2, hole_dia/2-optics_cavity_dy/2, -cavity_offset_dz-e]) {
          cube([optics_cavity_dx, optics_cavity_dy, optics_cavity_dz]);
        }
      }
      // Ball contacts
      translate([hole_dia/2, hole_dia/2, hole_dia/2]) {
        for (i = [1, -1]) {
          rotate([i*asin((optics_cavity_dy/2+bearing_dia/2)/(hole_dia/2)), 0, 0]) {
            translate([0, 0, -(ball_dia/2+bearing_dia/2)]) {
              sphere(d=bearing_dia, $fn=10);
            }
          }
        }
      }
      // Top contacts
      bearings(top_contact_dt);
    }
    if (bearings) {
      bearings(bearing_contact_dphi);
    }
  }

  module bearings(phi) {
    translate([hole_dia/2, hole_dia/2, hole_dia/2]) {
      for (i = [30:120:359]) {
        rotate([phi, 0, i]) {
          translate([0, 0, -(ball_dia/2+bearing_dia/2)]) {
            sphere(d=bearing_dia, $fn=10);
          }
        }
      }
    }
  }
}

