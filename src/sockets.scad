// Key switch sockets

module cherrymx_socket(pcb_pins=false) {
  e = 0.01;
  $fs = 0.1;

  socket_tolerance = 0.1;
  socket_dz = 5;

  plate_dx = 14 + socket_tolerance;
  plate_dy = 14 + socket_tolerance;
  plate_dz = 1.5;
  body_outset = 0.5;

  body_dx = plate_dx + body_outset;
  body_dy = plate_dy + body_outset;
  body_dz = socket_dz - plate_dz;
  base_dz = 1.5;
  wall_thickness = 2;

  hull_dx = body_dx + 2*wall_thickness;
  hull_dy = body_dy + 2*wall_thickness;
  hull_dz = socket_dz + base_dz;

  difference() {
    translate([-hull_dx/2, -hull_dy/2, -hull_dz]) {
      cube([hull_dx, hull_dy, hull_dz]);
    }
    translate([-plate_dx/2, -plate_dy/2, -plate_dz-e]) {
      cube([plate_dx, plate_dy, plate_dz+2*e]);
    }
    translate([-body_dx/2, -body_dy/2, -socket_dz]) {
      cube([body_dx, body_dy, body_dz+e]);
    }
    // PINS
    center_pin_dia = 4;

    wire_pin_dia = 1.5;
    wire_pin_1_coords = [-3.81, 2.54, 0];
    wire_pin_2_coords = [2.54, 5.08, 0];

    pcb_pin_dia = 1.7;
    pcb_pin_1_coords = [-5.08, 0, 0];
    pcb_pin_2_coords = [5.08, 0, 0];

    translate([0, 0, -hull_dz-e]) {
      cylinder(h=base_dz+2*e, d=center_pin_dia+socket_tolerance);
      translate(wire_pin_1_coords) cylinder(h=base_dz+2*e, d=wire_pin_dia+socket_tolerance);
      translate(wire_pin_2_coords) cylinder(h=base_dz+2*e, d=wire_pin_dia+socket_tolerance);
      if (pcb_pins) {
        translate(pcb_pin_1_coords) cylinder(h=base_dz+2*e, d=pcb_pin_dia+socket_tolerance);
        translate(pcb_pin_2_coords) cylinder(h=base_dz+2*e, d=pcb_pin_dia+socket_tolerance);
      }
    }
    
  }
}

