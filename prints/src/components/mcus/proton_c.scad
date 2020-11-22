proton_c_pcb_dx = 18.0;
proton_c_pcb_dy = 51.6;
proton_c_pcb_dz = 1.6;

proton_c_usb_dx = 9.0;
proton_c_usb_dy = 7.4;
proton_c_usb_dz = 3.2;
proton_c_usb_overhang_dy = 0.8;

module proton_c() {
  e = 0.01;

  pcb_dx = proton_c_pcb_dx;
  pcb_dy = proton_c_pcb_dy;
  pcb_dz = proton_c_pcb_dz;
  pcb_color = [30/255, 60/255, 30/255];

  contact_width = 2.5;
  contact_color = [200/255, 170/255, 80/255];

  usb_dx = proton_c_usb_dx;
  usb_dy = proton_c_usb_dy;
  usb_dz = proton_c_usb_dz;
  usb_overhang_dy = proton_c_usb_overhang_dy;
  usb_color = [128/255, 128/255, 128/255];

  cpu_dxy = 6.9;
  cpu_dz = 1.5;

  // pcb
  translate([-pcb_dx/2, 0, 0]) {
    color(pcb_color) cube([pcb_dx, pcb_dy, pcb_dz]);
    translate([-e, -e, -e]) {
      color(contact_color) cube([contact_width, pcb_dy+2*e, pcb_dz+2*e]);
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
  // Processor
  color([40/255, 40/255, 40/255]) translate([0, 27.5, pcb_dz+cpu_dz/2]) {
    rotate([0, 0, 45]) {
      cube(center=true, [cpu_dxy, cpu_dxy, cpu_dz]);
    }
  }
}
