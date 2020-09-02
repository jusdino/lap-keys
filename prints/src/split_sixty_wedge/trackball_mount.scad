include <../components/PMW3360.scad>;

use <keyboard.scad>;


trackball_mount_color = [32/255, 62/255, 212/255];
trackball_mount_body_rotation_dx = 60;
trackball_mount_ball_dia = 34.0;
trackball_mount_bearing_headroom = 0.8;
trackball_mount_bearing_dia = 2.5;
trackball_mount_contact_dia = 2.0;
trackball_mount_top_contact_dt = 95;
trackball_mount_hole_dia = trackball_mount_ball_dia + 2*trackball_mount_bearing_headroom;
trackball_mount_hole_overreach_dz = trackball_mount_contact_dia/2-(trackball_mount_hole_dia/2 * cos(trackball_mount_top_contact_dt));

trackball_mount_assembly_cavity_dz = 10.0;

trackball_mount_outer_dr = 2.0;
trackball_mount_outer_dia = trackball_mount_hole_dia + 2*trackball_mount_outer_dr;
trackball_mount_outer_dz = trackball_mount_assembly_cavity_dz+trackball_mount_hole_dia/2 + trackball_mount_hole_overreach_dz;
trackball_mount_outer_extension_dz = 1.0;
trackball_mount_dy = sqrt(pow(trackball_mount_outer_dia/2, 2) - pow(keyboard_top_dx/2, 2));

//trackball_mount();
module trackball_mount() {
  e = 0.01;

  body_rotation_dx = trackball_mount_body_rotation_dx; 
  ball_dia = trackball_mount_ball_dia;
  bearing_headroom = trackball_mount_bearing_headroom;
  bearing_dia = trackball_mount_bearing_dia;
  contact_dia = trackball_mount_contact_dia;
  top_contact_dt = trackball_mount_top_contact_dt;
  hole_dia = trackball_mount_hole_dia;
  hole_overreach_dz = trackball_mount_hole_overreach_dz;

  assembly_cavity_dz = trackball_mount_assembly_cavity_dz;

  outer_dr = trackball_mount_outer_dr;
  outer_dia = trackball_mount_outer_dia;
  outer_dz = trackball_mount_outer_dz;
  outer_extension_dz = trackball_mount_outer_extension_dz;
  mount_dy = trackball_mount_dy;

  bearing_contact_dphi = 80;
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

  difference() {
    rotate([body_rotation_dx, 0, 0]) {
      translate([0, -mount_dy, 0]) {
        rotate([0, 0, -90]) {
          translate([0, 0, outer_extension_dz-hole_overreach_dz]) {
            if (trackball) {
              color(trackball_mount_color/3) sphere(d=ball_dia, $fa=1);
            }
            translate([0, 0, -hole_dia/2]) {
              if(sensor) {
                PMW3360_assembly();
              }
              color(trackball_mount_color) {
                // Main body
                difference() {
                  translate([0, 0, -assembly_cavity_dz]) {
                    cylinder(d=outer_dia, h=outer_dz);
                  }
                  // Trackball hole
                  translate([0, 0, hole_dia/2]) {
                    sphere(d=hole_dia, $fa=1);
                  }
                  // Bearing holes
                  bearings(bearing_dia, bearing_contact_dphi, $fn=20);
                  // Sensor cavity
                  translate([-board_cavity_dx/2, -board_cavity_offset_dy, -assembly_cavity_dz-e]) {
                    cube([board_cavity_dx, board_cavity_dy, board_cavity_dz+e]);
                  }
                  translate([-lens_cavity_dx/2, -lens_cavity_dy/2, -assembly_cavity_dz+board_cavity_dz-e]) {
                    cube([lens_cavity_dx, lens_cavity_dy, lens_cavity_dz+2*e]);
                  }
                  hull() {
                    translate([-hole_dia/2-outer_dr-e, -wire_cavity_dy/2, -assembly_cavity_dz-e]) {
                      cube([e, wire_cavity_dy, wire_cavity_outer_dz+e]);
                    }
                    translate([-board_cavity_dx/2, -wire_cavity_dy/2, -assembly_cavity_dz-e]) {
                      cube([wire_cavity_outer_dz, wire_cavity_dy, wire_cavity_inner_dz+e]);
                    }
                  }
                  // Optics cavity
                  translate([-optics_cavity_dx/2, -optics_cavity_dy/2, -cavity_offset_dz-e]) {
                    cube([optics_cavity_dx, optics_cavity_dy, optics_cavity_dz]);
                  }
                }
                // Ball contacts
                translate([0, 0, hole_dia/2]) {
                  for (i = [1, -1]) {
                    rotate([i*asin((optics_cavity_dy/2+contact_dia/2)/(hole_dia/2)), 0, 0]) {
                      translate([0, 0, -(ball_dia/2+contact_dia/2)]) {
                        sphere(d=contact_dia, $fn=10);
                      }
                    }
                  }
                }
                // Top contacts
                bearings(contact_dia, top_contact_dt);
              }
              // Bearing contacts
              if (bearings) {
                bearings(bearing_dia, bearing_contact_dphi);
              }
            }
          }
        }
      }
    }
    trackball_mount_slot_cutout();
  }

  module bearings(bearing_dia, phi, $fn=10) {
    translate([0, 0, hole_dia/2]) {
      for (i = [90:120:359]) {
        rotate([phi, 0, i]) {
          translate([0, 0, -(ball_dia/2+bearing_dia/2)]) {
            sphere(d=bearing_dia, $fn=$fn);
          }
        }
      }
    }
  }
}


module trackball_mount_cutout() {
  e = 0.01;
  body_rotation_dx = trackball_mount_body_rotation_dx;
  hole_dia = trackball_mount_hole_dia;
  hole_overreach_dz = trackball_mount_hole_overreach_dz;
  mount_dy = trackball_mount_dy;

  assembly_cavity_dz = trackball_mount_assembly_cavity_dz;

  outer_dz = trackball_mount_outer_dz;
  outer_dia = trackball_mount_outer_dia;
  outer_dr = trackball_mount_outer_dr;

  corner_grip_dz = 2.0;
  corner_grip_dr = outer_dr/2;

  rotate([body_rotation_dx, 0, 0]) {
    translate([0, -mount_dy, 0]) {
      translate([0, 0, -hole_dia/2-hole_overreach_dz]) {
        // Main body
        difference() {
          translate([0, 0, -assembly_cavity_dz]) {
            translate([0, 0, -corner_grip_dz]) {
              cylinder(d=outer_dia-outer_dr, h=outer_dz);
            }
            cylinder(d=outer_dia-outer_dr-corner_grip_dr, h=outer_dz+e);
          }
        }
      }
    }
  }
}

module trackball_mount_slot_cutout() {
  e = 0.01;

  keyboard_top_dz = keyboard_top_dz;

  outer_dz = trackball_mount_outer_dz;
  outer_dia = trackball_mount_outer_dia;
  outer_dr = trackball_mount_outer_dr;

  difference() {
    translate([-outer_dia/2, 0, -keyboard_top_dz]) {
      cube([outer_dia, sqrt(pow(outer_dz, 2) + pow(outer_dia, 2)), keyboard_top_dz]);
    }
    trackball_mount_cutout();
  }
}
