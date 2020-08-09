// KEYBOARD: Split Sixty Wedge
// First step towards a more functional design: Adding a PCB, reducing space for hand-wires.

include <components/switches.scad>;
include <components/sockets.scad>;
include <components/keycaps.scad>;
include <abstractions.scad>;


switch_column_plate_pcb_dx = 16.5;
switch_column_plate_pcb_dy = 99.7;
switch_column_plate_pcb_dz = 1.6;
switch_column_plate_pcb_y = -7.8;

switch_column_plate_pcb_holder_inset = 1;
switch_column_plate_pcb_headroom_dz = 2;
switch_column_plate_pcb_holder_overreach_dz = 1;
switch_column_plate_pcb_holder_dz = switch_column_plate_pcb_dz + switch_column_plate_pcb_holder_overreach_dz;


split_sixty_wedge(pcbs=true);
module split_sixty_wedge(keys_and_caps=false, sockets=false, pcbs=false, pcb_pins=false) {
  e = 0.01;

  x_count = 6;
  y_count = 5;
  spacing = 19;
  coords = [for (x=0;x<x_count;x=x+1) for (y=0;y<y_count;y=y+1) [x, y, 0]] * spacing;
  corners = [[0, 0, 0], [0, y_count-1, 0], [x_count-1, y_count-1, 0], [x_count-1, 0, 0]] * spacing;

  bottom_dx = spacing*(x_count-1);
  bottom_dy = spacing*(y_count-1);

  y_rotation = 50;
  z_rotation = 11;

  wall_thickness = 2;

  plus_x_dx = wall_thickness*tan(y_rotation);
  minus_x_dx = wall_thickness*(1/tan(y_rotation) + 1/sin(y_rotation));
  subtraction_corners = [
    [plus_x_dx, -e, -wall_thickness],
    [plus_x_dx, (y_count-1)*spacing+1, -wall_thickness],
    [(x_count-1)*spacing-minus_x_dx, (y_count-1)*spacing+1, -wall_thickness],
    [(x_count-1)*spacing-minus_x_dx, -e, -wall_thickness]];

  wedge_mirror() {
    switch_plate(x_count, y_count, spacing, pcbs);
  }
  
  module wedge_mirror() {
    wedge_rotate() {
      children();
    }
    mirror([1, 0, 0]) {
      wedge_rotate() {
        children();
      }
    }
  }

  module wedge_rotate() {
    rotate([0, y_rotation, z_rotation]) {
      //translate([cherrymx_base_base_dx/2, -bottom_dy-cherrymx_base_base_dy/2, -cherrymx_base_base_z]) {
        children();
      //}
    }
  }
}


//switch_plate(pcb=true);
module switch_plate(x_count=6, y_count=5, spacing=19, pcb=false) {
  hull_dz = cherrymx_socket_hull_dz;
  pcb_dz = switch_column_plate_pcb_dz;
  pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;

  plate_dz = hull_dz + pcb_dz + pcb_holder_overreach_dz;


  translate([spacing/2, -(y_count-0.5)*spacing, plate_dz]) {
    for (i=[0:x_count-1]) {
      translate([spacing*i, 0, 0]) {
        switch_column_plate(count=y_count, spacing=spacing, pcb=pcb);
      }
    }
  }
}

module switch_column_plate(count=5, spacing=19, pcb=false) {
  e = 0.01;

  pcb_dx = switch_column_plate_pcb_dx;
  pcb_dy = switch_column_plate_pcb_dy;
  pcb_dz = switch_column_plate_pcb_dz;

  hull_dx = cherrymx_socket_hull_dx;
  hull_dy = cherrymx_socket_hull_dy;
  hull_dz = cherrymx_socket_hull_dz;

  plate_dx = cherrymx_socket_plate_dx;
  plate_dy = cherrymx_socket_plate_dy;

  pcb_holder_inset = switch_column_plate_pcb_holder_inset;
  pcb_headroom_dz = switch_column_plate_pcb_headroom_dz;
  pcb_holder_overreach_dz = switch_column_plate_pcb_holder_overreach_dz;
  pcb_holder_dz = switch_column_plate_pcb_holder_dz;

  socket_color = cherrymx_socket_color;

  for (i= [0:count-1]) {
    translate([0, spacing*i, 0]) {
      cherrymx_plate_pcb();
    }
  }
  if (pcb) {
    color("green") {
      translate([-pcb_dx/2, switch_column_plate_pcb_y, -hull_dz-pcb_dz]) {
        cube([pcb_dx, pcb_dy, pcb_dz]);
      }
    }
  }

  module cherrymx_plate_pcb() {
    color(socket_color) {
      difference() {
        union() {
          cherrymx_plate_base();
          translate([-hull_dx/2, -hull_dy/2, -hull_dz-pcb_holder_dz]) {
            cube([hull_dx, hull_dy, pcb_holder_dz+e]);
          }
        }
        // PCB slot
        translate([-pcb_dx/2, -spacing/2-e, -hull_dz-pcb_dz]) {
          cube([pcb_dx, spacing+2*e, pcb_dz+2*e]);
          // PCB headroom
          translate([pcb_holder_inset, 0, pcb_dz]) {
            cube([pcb_dx-2*pcb_holder_inset, spacing+2*e, pcb_headroom_dz]);
          }
          // PCB overreach
          hull() {
            cube([pcb_dx, spacing+2*e, e]);
            translate([pcb_holder_overreach_dz, 0, -pcb_holder_overreach_dz-e]) {
              cube([pcb_dx-2*pcb_holder_overreach_dz, spacing+2*e, e]);
            }
          }
        }
      }
    }
  }
}
