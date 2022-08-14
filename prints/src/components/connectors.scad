pin_tab_part_gap=0.1;

pin_tab_pin_dia=3.0;
pin_tab_pin_dy=20.0;

pin_tab_bump_dx=0.6;
pin_tab_bump_dia=3.0;

//pin_tab(9);
module pin_tab(length, pin_dy=pin_tab_pin_dy, pin_dia=pin_tab_pin_dia) {
  e=0.01;

  bump_dx=pin_tab_bump_dx;
  bump_dia=pin_tab_bump_dia;

  tab_dz=length;

  difference() {
    pin_tab_base(length=length, pin_dy=pin_dy, pin_dia=pin_dia);
    translate([pin_dia/2, pin_dy/2, tab_dz-bump_dia]) {
      rotate([0, 0, 180]) {
        bump(h=bump_dx, d=bump_dia);
      }
    }
  }
}

//pin_slot(9);
module pin_slot(length, pin_dy=pin_tab_pin_dy, pin_dia=pin_tab_pin_dia) {
  e=0.01;

  part_gap=pin_tab_part_gap;

  bump_dx=pin_tab_bump_dx;
  bump_dia=pin_tab_bump_dia;

  box_back_dz=1;

  translate([0, 0, -length-box_back_dz-part_gap]) {
    difference() {
      pin_slot_profile(length=length+box_back_dz+part_gap, pin_dy=pin_dy, pin_dia=pin_dia);
      translate([0, 0, box_back_dz]) {
        pin_tab_base(length, pin_dy, subtractive=true);
      }
    }
    translate([pin_dia/2, pin_dy/2, bump_dia]) {
      rotate([0, 0, 180]) {
        bump(h=bump_dx, d=bump_dia);
      }
    }
    hull() {
      pin_slot_profile(length=e, pin_dy=pin_dy, pin_dia=pin_dia);
      translate([-pin_dia/2, 0, 0]) {
        rotate([0, 90, 0]) {
          translate([pin_dia/2, 0, 0]) {
            pin_slot_profile(length=pin_dia/2, pin_dy=pin_dy, pin_dia=pin_dia);
          }
        }
      }
    }
  }

}

module pin_slot_profile(length, pin_dy=pin_tab_pin_dy, pin_dia=pin_tab_pin_dia) {
  e=0.01;

  box_dx=2*pin_dia;
  box_dz=length;
  translate([pin_dia/2, 0, 0]) {
    union() {
      cylinder(h=box_dz, d=box_dx);
      translate([0, pin_dy, 0]) {
        cylinder(h=box_dz, d=box_dx);
      }
      translate([-pin_dia, 0, 0]) {
        cube([box_dx, pin_dy, box_dz]);
        translate([0, -box_dx/2, 0]) {
          cube([box_dx/2, pin_dy+box_dx, box_dz]);
        }
      }
    }
  }
}

//pin_tab_base(9);
module pin_tab_base(length, pin_dy, pin_dia=pin_tab_pin_dia, subtractive=false) {
  e=0.01;

  part_gap=pin_tab_part_gap;

  tab_dz=subtractive ? length+part_gap+e : length;
  tab_dx=pin_dia/2;
  translate([0, -pin_dia/2, 0]) {
    cube([tab_dx, pin_dy+pin_dia, tab_dz]);
  }
  translate([tab_dx, 0, 0]) {
    cylinder(h=tab_dz, d=pin_dia);
    translate([0, pin_dy, 0]) {
      cylinder(h=tab_dz, d=pin_dia);
    }
  }
}


//bump(1, 3);
module bump(h, d) {
  e=0.01;

  dia=(pow(d/2, 2) + pow(h, 2))/(2*h)*2;
  inset=dia/2-h;
  difference() {
    translate([-inset, 0, 0]) {
      sphere(d=dia);
    }
    translate([-dia-e, -dia/2, -dia/2]) {
      cube([dia, dia, dia]);
    }
  }
}

//pin_tab_tester(9);
module pin_tab_tester(length=9) {
  pin_dia=pin_tab_pin_dia;
  pin_dy=pin_tab_pin_dy;

  tab_dx=pin_dia/2;

  backing_thickness=2*pin_dia;

  pin_tab(length=length);
  translate([-tab_dx, -pin_dia, -backing_thickness*2]) {
    cube([backing_thickness, pin_dy+2*pin_dia, backing_thickness*2]);
  }
}

//pin_slot_tester(9);
module pin_slot_tester(length) {
  e=0.01;

  pin_dia=pin_tab_pin_dia;
  pin_dy=pin_tab_pin_dy;

  box_dx=2*pin_dia;
  box_back_dz=1.0;

  pin_slot(length=length);
  translate([-box_dx, -box_dx/2, -box_dx]) {
    cube([box_dx*2, pin_dy+box_dx, box_dx]);
  }
}
