e=0.01;
PART_GAP=0.1;

PIN_DIA=3;
PIN_DY=20;

BUMP_DX=0.6;
BUMP_DIA=3;

module pin_tab_tester(length=9) {
  PIN_DIA=PIN_DIA;
  PIN_DY=PIN_DY;
  TAB_DZ=length;
  TAB_DX=PIN_DIA/2;

  BACKING_THICKNESS=2*PIN_DIA;

  pin_tab(length=length);
  translate([-TAB_DX, -PIN_DIA, -BACKING_THICKNESS*2]) {
    cube([BACKING_THICKNESS, PIN_DY+2*PIN_DIA, BACKING_THICKNESS*2]);
  }
}

module pin_slot_tester(length) {
  BOX_DX=2*PIN_DIA;
  BOX_BACK_DZ=1;
  BOX_DZ=TAB_DZ+BOX_BACK_DZ+PART_GAP;

  pin_slot(length=length);
  translate([-BOX_DX, -BOX_DX/2, -BOX_DX]) {
    cube([BOX_DX*2, PIN_DY+BOX_DX, BOX_DX]);
  }
}

module pin_tab_base(length, subtractive=false) {
  PIN_DIA=PIN_DIA;
  PIN_DY=PIN_DY;
  TAB_DZ=subtractive ? length+PART_GAP+e : length;
  TAB_DX=PIN_DIA/2;
  translate([-TAB_DX, -PIN_DIA/2, 0]) {
    cube([TAB_DX, PIN_DY+PIN_DIA, TAB_DZ]);
  }
  cylinder(h=TAB_DZ, d=PIN_DIA);
  translate([0, PIN_DY, 0]) {
    cylinder(h=TAB_DZ, d=PIN_DIA);
  }
}

module pin_tab(length) {
  PIN_DIA=PIN_DIA;
  PIN_DY=PIN_DY;
  TAB_DZ=length;
  TAB_DX=PIN_DIA/2;

  difference() {
    pin_tab_base(length);
    translate([0, PIN_DY/2, TAB_DZ-BUMP_DIA]) {
      rotate([0, 0, 180]) {
        bump(h=BUMP_DX, d=BUMP_DIA);
      }
    }
  }
}

module pin_slot(length) {
  BOX_BACK_DZ=1;

  difference() {
    pin_slot_profile(length=length+BOX_BACK_DZ+PART_GAP);
    translate([0, 0, BOX_BACK_DZ]) {
      pin_tab_base(subtractive=true);
    }
  }
  translate([0, PIN_DY/2, BUMP_DIA]) {
    rotate([0, 0, 180]) {
      bump(h=BUMP_DX, d=BUMP_DIA);
    }
  }
}

module pin_slot_profile(length) {
  BOX_DX=2*PIN_DIA;
  BOX_DZ=length;
  union() {
    cylinder(h=BOX_DZ, d=BOX_DX);
    translate([0, PIN_DY, 0]) {
      cylinder(h=BOX_DZ, d=BOX_DX);
    }
    translate([-PIN_DIA, 0, 0]) {
      cube([BOX_DX, PIN_DY, BOX_DZ]);
      translate([0, -BOX_DX/2, 0]) {
        cube([BOX_DX/2, PIN_DY+BOX_DX, BOX_DZ]);
      }
    }
  }
}

module bump(h, d) {
  DIA=(pow(d/2, 2) + pow(h, 2))/(2*h)*2;
  INSET=DIA/2-h;
  difference() {
    translate([-INSET, 0, 0]) {
      sphere(d=DIA);
    }
    translate([-DIA-e, -DIA/2, -DIA/2]) {
      cube([DIA, DIA, DIA]);
    }
  }
}
