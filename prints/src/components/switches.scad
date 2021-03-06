// Switch models for sizing frame sockets, etc.
cherrymx_switch_body_dx = 14;
cherrymx_switch_body_dy = 14;
cherrymx_switch_body_dz = 11.6;
cherrymx_switch_body_lower_dz = 5;
cherrymx_switch_body_upper_dx = 14;
cherrymx_switch_body_upper_dy = 15.4;
cherrymx_switch_body_upper_dz = cherrymx_switch_body_dz - cherrymx_switch_body_lower_dz;

cherrymx_switch_seat_dx = 15.6;
cherrymx_switch_seat_dy = 15.6;
cherrymx_switch_seat_dz = 1;
cherrymx_switch_seat_z = 5;

cherrymx_switch_connector_thickness = 1.17;
cherrymx_switch_connector_width = 4.1;
cherrymx_switch_connector_dz = 3.6;

cherrymx_switch_pin_dz = 3.3;
cherrymx_switch_center_pin_dia = 4;

cherrymx_switch_wire_pin_dia = 1.5;
cherrymx_switch_wire_pin_1_coords = [-3.81, 2.54, 0];
cherrymx_switch_wire_pin_2_coords = [2.54, 5.08, 0];
cherrymx_switch_wire_pin_color = [130/255, 130/255, 130/255];

cherrymx_switch_pcb_pin_dia = 1.7;
cherrymx_switch_pcb_pin_1_coords = [-5.08, 0, 0];
cherrymx_switch_pcb_pin_2_coords = [5.08, 0, 0];

module cherrymx(pcb_pins=false) {
  // Based on dimensions found here: https://www.cherrymx.de/en/dev.html
  // and some rough guesswork, measurements of similar switches
  e = 0.01;

  body_dx = cherrymx_switch_body_dx;
  body_dy = cherrymx_switch_body_dy;
  body_dz = cherrymx_switch_body_dz;
  body_lower_dz = cherrymx_switch_body_lower_dz;
  body_upper_dx = cherrymx_switch_body_upper_dx;
  body_upper_dy = cherrymx_switch_body_upper_dy;
  body_upper_dz = cherrymx_switch_body_upper_dz;

  seat_dx = cherrymx_switch_seat_dx;
  seat_dy = cherrymx_switch_seat_dy;
  seat_dz = cherrymx_switch_seat_dz;
  seat_z = cherrymx_switch_seat_z;

  connector_thickness = cherrymx_switch_connector_thickness;
  connector_width = cherrymx_switch_connector_width;
  connector_dz = cherrymx_switch_connector_dz;

  body_color = [30/255, 30/255, 30/255];
  connector_color = [168/255, 29/255, 10/255];

  translate([0, 0, -seat_z]) {
    color(body_color) {
      difference() {
        union() {
          // Lower body
          translate([-body_dx/2, -body_dy/2, 0]) {
            cube([body_dx, body_dy, body_lower_dz]);
          }
          // Upper body
          translate([0, 0, seat_z]) {
            // Seat
            translate([-seat_dx/2, -seat_dy/2, 0]) {
              cube([seat_dx, seat_dy, seat_dz]);
            }
            // Upper body
            translate([-body_upper_dx/2, -body_upper_dy/2, 0]) {
              cube([body_upper_dx, body_upper_dy, body_upper_dz]);
            }
          }
        }
        // Keycap subtraction
        union() {
          keycap_outset = 7.7;
          keycap_travel_dz = -4;
          keycap_z = -1;
          keycap_lower_inclination = 7.5;
          for (i = [0:90:270]) {
            rotate([0, 0, i]) {
              translate([-body_upper_dx/2-e, keycap_outset, body_dz+keycap_travel_dz+keycap_z]) {
                rotate([keycap_lower_inclination, 0, 0]) {
                  cube([body_upper_dx+2*e, body_upper_dx/2, 2*body_dz]);
                }
                translate([0, -3*tan(keycap_lower_inclination), 3]) {
                  rotate([30, 0, 0]) {
                    cube([body_upper_dx+2*e, body_upper_dx/2, 2*body_dz]);
                  }
                }
              }
            }
          }
        }
      }
    }
    // Top connector
    color(connector_color) {
      translate([0, 0, body_dz]) {
        translate([-connector_width/2, -connector_thickness/2, 0]) {
          cube([connector_width, connector_thickness, connector_dz]);
        }
        translate([-connector_thickness/2, -connector_width/2, 0]) {
          cube([connector_thickness, connector_width, connector_dz]);
        }
        translate([-body_dx/4, -body_dy/4, 0]) {
          cube([body_dx/2, body_dy/2, e]);
        }
      }
    }
    // PINS
    // Center pin
    pin_dz = cherrymx_switch_pin_dz;
    center_pin_dia = cherrymx_switch_center_pin_dia;

    wire_pin_dia = cherrymx_switch_wire_pin_dia;
    wire_pin_1_coords = cherrymx_switch_wire_pin_1_coords;
    wire_pin_2_coords = cherrymx_switch_wire_pin_2_coords;
    wire_pin_color = cherrymx_switch_wire_pin_color;

    pcb_pin_dia = cherrymx_switch_pcb_pin_dia;
    pcb_pin_1_coords = cherrymx_switch_pcb_pin_1_coords;
    pcb_pin_2_coords = cherrymx_switch_pcb_pin_2_coords;
    translate([0, 0, -pin_dz]) {
      color(body_color) cylinder(h=pin_dz, d=center_pin_dia);
      color(wire_pin_color) {
        translate(wire_pin_1_coords) cylinder(h=pin_dz, d=wire_pin_dia);
        translate(wire_pin_2_coords) cylinder(h=pin_dz, d=wire_pin_dia);
      }
      if (pcb_pins) {
        color(body_color) {
          translate(pcb_pin_1_coords) cylinder(h=pin_dz, d=pcb_pin_dia);
          translate(pcb_pin_2_coords) cylinder(h=pin_dz, d=pcb_pin_dia);
        }
      }
    }
  }
}
