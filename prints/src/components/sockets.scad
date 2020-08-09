// Key switch sockets
include <switches.scad>;

cherrymx_socket_tolerance = 0.1;
cherrymx_socket_socket_dz = cherrymx_switch_body_lower_dz;

cherrymx_socket_plate_dx = cherrymx_switch_body_dx + cherrymx_socket_tolerance;
cherrymx_socket_plate_dy = cherrymx_switch_body_dy + cherrymx_socket_tolerance;
cherrymx_socket_plate_dz = 1.3;
cherrymx_socket_body_outset = 0.5;
cherrymx_socket_base_dz = 1;

cherrymx_socket_hull_dx = 19; // cherrymx_socket_body_dx + 2*cherrymx_socket_wall_thickness;
cherrymx_socket_hull_dy = 19; // cherrymx_socket_body_dy + 2*cherrymx_socket_wall_thickness;
cherrymx_socket_hull_dz = cherrymx_socket_socket_dz; // + cherrymx_socket_base_dz;

cherrymx_socket_body_dx = cherrymx_socket_plate_dx + cherrymx_socket_body_outset;
cherrymx_socket_body_dy = cherrymx_socket_plate_dy + cherrymx_socket_body_outset;
cherrymx_socket_body_dz = cherrymx_socket_socket_dz - cherrymx_socket_plate_dz;
cherrymx_socket_wall_thickness = cherrymx_socket_hull_dx - cherrymx_socket_body_dx; // 4.5;

cherrymx_socket_center_pin_dia = 4 + cherrymx_socket_tolerance;

// Widen to allow a diode to pass through;
cherrymx_socket_wire_pin_dia = cherrymx_switch_wire_pin_dia + 2*cherrymx_socket_tolerance + 0.5;cherrymx_socket_wire_pin_1_coords = cherrymx_switch_wire_pin_1_coords;
cherrymx_socket_wire_pin_2_coords = cherrymx_switch_wire_pin_2_coords;

cherrymx_socket_pcb_pin_dia = cherrymx_switch_pcb_pin_dia;
cherrymx_socket_pcb_pin_1_coords = cherrymx_switch_pcb_pin_1_coords;
cherrymx_socket_pcb_pin_2_coords = cherrymx_switch_pcb_pin_2_coords;

cherrymx_socket_color = [32/255, 62/255, 212/255];

module cherrymx_socket(pcb_pins=false) {
  e = 0.01;
  $fs = 0.1;

  socket_dz = cherrymx_socket_socket_dz;

  plate_dx = cherrymx_socket_plate_dx;
  plate_dy = cherrymx_socket_plate_dy;
  plate_dz = cherrymx_socket_plate_dz;

  body_dx = cherrymx_socket_body_dx;
  body_dy = cherrymx_socket_body_dy;
  body_dz = cherrymx_socket_body_dz;
  base_dz = cherrymx_socket_base_dz;

  hull_dx = cherrymx_socket_hull_dx;
  hull_dy = cherrymx_socket_hull_dy;
  hull_dz = cherrymx_socket_hull_dz;

  center_pin_dia = cherrymx_socket_center_pin_dia;

  wire_pin_dia = cherrymx_socket_wire_pin_dia;
  wire_pin_1_coords = cherrymx_socket_wire_pin_1_coords;
  wire_pin_2_coords = cherrymx_socket_wire_pin_2_coords;

  pcb_pin_dia = cherrymx_socket_pcb_pin_dia;
  pcb_pin_1_coords = cherrymx_socket_pcb_pin_1_coords;
  pcb_pin_2_coords = cherrymx_socket_pcb_pin_2_coords;

  socket_color = cherrymx_socket_color;

  color(socket_color) {
    difference() {
      union() {
        cherrymx_plate_base();
        translate([-hull_dx/2, -hull_dy/2, -hull_dz-base_dz]) {
          cube([hull_dx, hull_dy, base_dz]);
        }
      }
      // PINS
      translate([0, 0, -hull_dz-base_dz-e]) {
        cylinder(h=base_dz+2*e, d=center_pin_dia);
        translate(wire_pin_1_coords) cylinder(h=base_dz+2*e, d=wire_pin_dia);
        translate(wire_pin_2_coords) cylinder(h=base_dz+2*e, d=wire_pin_dia);
        if (pcb_pins) {
          translate(pcb_pin_1_coords) cylinder(h=base_dz+2*e, d=pcb_pin_dia);
          translate(pcb_pin_2_coords) cylinder(h=base_dz+2*e, d=pcb_pin_dia);
        }
      }
    }
  }
}

module cherrymx_plate_base() {
  e = 0.01;

  socket_dz = cherrymx_socket_socket_dz;

  plate_dx = cherrymx_socket_plate_dx;
  plate_dy = cherrymx_socket_plate_dy;
  plate_dz = cherrymx_socket_plate_dz;

  body_dx = cherrymx_socket_body_dx;
  body_dy = cherrymx_socket_body_dy;
  body_dz = cherrymx_socket_body_dz;

  hull_dx = cherrymx_socket_hull_dx;
  hull_dy = cherrymx_socket_hull_dy;
  hull_dz = cherrymx_socket_socket_dz;

  socket_color = cherrymx_socket_color;

  color(socket_color) {
    difference() {
      translate([-hull_dx/2, -hull_dy/2, -hull_dz]) {
        cube([hull_dx, hull_dy, hull_dz]);
      }
      translate([-plate_dx/2, -plate_dy/2, -plate_dz-e]) {
        cube([plate_dx, plate_dy, plate_dz+2*e]);
      }
      translate([-body_dx/2, -body_dy/2, -socket_dz-e]) {
        cube([body_dx, body_dy, body_dz+2*e]);
      }
    }
  }
}
