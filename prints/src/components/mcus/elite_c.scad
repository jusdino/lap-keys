elite_c_pcb_dx = 18.5;
elite_c_pcb_dy = 33.2;
elite_c_pcb_dz = 1.1;

elite_c_usb_dx = 9.0;
elite_c_usb_dy = 7.4;
elite_c_usb_dz = 3.2;
elite_c_usb_overhang_dy = 0.8;

module elite_c() {
  e = 0.01;

  pcb_dx = elite_c_pcb_dx;
  pcb_dy = elite_c_pcb_dy;
  pcb_dz = elite_c_pcb_dz;
  pcb_color = [30/255, 30/255, 30/255];

  contact_width = 2.5;
  contact_color = [200/255, 170/255, 80/255];

  usb_dx = elite_c_usb_dx;
  usb_dy = elite_c_usb_dy;
  usb_dz = elite_c_usb_dz;
  usb_overhang_dy = elite_c_usb_overhang_dy;
  usb_color = [128/255, 128/255, 128/255];

  reset_box_dx = 4.0;
  reset_box_dy = 3.0;
  reset_box_dz = 1.5;
  reset_box_x = 6.2-(pcb_dx/2);
  reset_box_y = 28;

  reset_button_dia = 1.8;
  reset_button_dz = 0.5;


  // pcb
  translate([-pcb_dx/2, 0, 0]) {
    color(pcb_color) cube([pcb_dx, pcb_dy, pcb_dz]);
    translate([-e, -e, -e]) {
      color(contact_color) cube([contact_width, pcb_dy+2*e, pcb_dz+2*e]);
    }
    translate([-e, pcb_dy-contact_width, -e]) {
      color(contact_color) cube([pcb_dx+2*e, contact_width+e, pcb_dz+2*e]);
    }
    translate([pcb_dx-contact_width+e, -e, -e]) {
      color(contact_color) cube([contact_width, pcb_dy+2*e, pcb_dz+2*e]);
    }
  }
  // usb connector
  color(usb_color) {
    translate([-usb_dx/2, -usb_overhang_dy, pcb_dz]) {
      translate([usb_dz/2, 0, 0]) {
        cube([usb_dx-usb_dz, usb_dy, usb_dz]);
        translate([0, 0, usb_dz/2]) {
          rotate([-90, 0, 0]) {
            cylinder(d=usb_dz, h=usb_dy, $fn=16);
          }
        }
      }
      translate([usb_dx-usb_dz/2, 0, usb_dz/2]) {
        rotate([-90, 0, 0]) {
          cylinder(d=usb_dz, h=usb_dy, $fn=16);
        }
      }
    }
  }
  // reset button
  translate([reset_box_x, reset_box_y, pcb_dz]) {
    color(usb_color) translate([0, 0, reset_box_dz/2]) cube([reset_box_dx, reset_box_dy, reset_box_dz], center=true);
    color([40/255, 40/255, 40/255]) translate([0, 0, reset_box_dz]) cylinder(d=reset_button_dia, h=reset_button_dz, $fn=16);
  }
}

