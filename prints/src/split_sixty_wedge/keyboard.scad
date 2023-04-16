// KEYBOARD: Split Sixty Wedge
// First step towards a more functional design: Adding a PCB, reducing space for hand-wires.

// MULTI-MODULE VARS
// General inputs
plates=true;
keys_and_caps=true;
pcbs=true;

mcu=true;

trackball_mount=false;
trackball=true;
sensor=true;
bearings=true;

keyboard_x_count = 6;
keyboard_y_count = 5;
keyboard_switch_spacing = 19;
keyboard_y_rotation = 50;
keyboard_z_rotation = 11;
keyboard_front_plane_x_rotation = atan((cos(keyboard_y_rotation)*sin(keyboard_z_rotation))/sin(keyboard_y_rotation));
keyboard_front_plane_y_rotation = atan((cos(keyboard_y_rotation)*cos(keyboard_z_rotation)*cos(keyboard_front_plane_x_rotation))/sin(keyboard_y_rotation));

include <switch_plate.scad>;

// switch_base attributes
switch_base_thickness = 2;
switch_base_bottom_width = 4;
switch_base_tolerance = 0.2;

switch_base_dx = switch_plate_dx + 2*switch_base_thickness;
switch_base_dy = switch_plate_dy + 2*switch_base_thickness;
switch_base_dz = switch_base_thickness;

// Keyboard attributes
keyboard_base_color = [80/255, 100/255, 200/255];
keyboard_front_tab_dx = 3;

keyboard_top_dx = switch_base_dy*sin(keyboard_z_rotation)*2;
keyboard_top_dy = switch_base_dy*cos(keyboard_z_rotation);
keyboard_top_dz = switch_base_bottom_width * sin(keyboard_y_rotation);

include <../components/connectors.scad>;
include <trackball_mount.scad>;
include <proton_c_mount.scad>;


keyboard();
module keyboard() {
  e = 0.01;

  x_count = keyboard_x_count;
  y_count = keyboard_y_count;
  switch_spacing = keyboard_switch_spacing;

  base_color = keyboard_base_color;
  base_thickness = switch_base_thickness;
  base_bottom_width = switch_base_bottom_width;
  base_dx = switch_base_dx;
  base_dy = switch_base_dy;
  base_tolerance = switch_base_tolerance;
  base_connector_dx = 15;
  base_connector_dy = 10;
  screw_head_dia = 4;

  y_rotation = keyboard_y_rotation;
  z_rotation = keyboard_z_rotation;
  front_plane_x_rotation = keyboard_front_plane_x_rotation;
  front_plane_y_rotation = keyboard_front_plane_y_rotation;

  front_tab_dx = keyboard_front_tab_dx;

  if (plates) {
    wedge_mirror() {
      translate([base_thickness, -base_thickness, base_thickness]) {
        switch_plate();
      }
    }
  }
  difference() {
    union() {
      base_top();
      base_bottom();
      base_front();
      base_rear();
    }
    // Fastiners
    front_top_screw_hole();
    front_bottom_screw_hole();
    mirror([1, 0, 0]) {
      front_bottom_screw_hole();
    }
    rear_top_screw_hole();
    mirror([1, 0, 0]) {
      rear_top_screw_hole();
    }
    rear_bottom_screw_hole();
    mirror([1, 0, 0]) {
      rear_bottom_screw_hole();
    }
  }
  if (mcu) {
    rotate([front_plane_x_rotation, 0, 0]) {
      translate([0, 0, -(base_dx-3*base_thickness)*cos(front_plane_y_rotation)]) {
        rotate([-front_plane_x_rotation, 0, 0]) {
          translate(mcu_mount_mcu_translation) {
            rotate([180, 0, 0]) {
              proton_c();
            }
          }
        }
      }
    }
  }


  module front_top_screw_hole() {
    rotate([front_plane_x_rotation, 0, 0]) {
      translate([0, 0, -screw_head_dia/sin(front_plane_y_rotation)]) {
        rotate([90, 0, 0]) {
          m2_flat_head_screw(l=2*base_thickness+base_connector_dy);
        }
        translate([0, -2*base_thickness, 0]) {
          rotate([90, 0, 0]) {
            m2_nut(l=base_connector_dy);
          }
        }
      }
    }
  }

  module front_bottom_screw_hole() {
    rotate([front_plane_x_rotation, 0, 0]) {
      rotate([0, front_plane_y_rotation, 0]) {
        translate([screw_head_dia, 0, -base_dx+3*base_thickness+(screw_head_dia/tan((90-front_plane_y_rotation)/2))]) {
          rotate([90, 0, 0]) {
            m2_flat_head_screw(l=2*base_thickness+base_connector_dy);
          }
          translate([0, -2*base_thickness, 0]) {
            rotate([90, 0, 0]) {
              m2_nut(l=base_connector_dy-2*base_thickness);
            }
          }
        }
      }
    }
  }

  module rear_top_screw_hole() {
    // We walk through a rotate/translate/unrotate pattern here in order to get our 'origin'
    // translated to the back corner of the plate without having the origin rotated
    wedge_rotate() {
      translate([0, -base_dy, 0]) {
        rotate([0, -y_rotation, 0]) {
          rotate([0, 0, -z_rotation]) {
            rotate([front_plane_x_rotation, 0, 0]) {
              translate([-1.5*screw_head_dia/tan((front_plane_y_rotation+90)/2), 0, -1.5*screw_head_dia]) {
                rotate([-90, 0, 0]) {
                  m2_flat_head_screw(l=10);
                }
                translate([0, base_connector_dy+base_thickness, 0]) {
                  rotate([90, 0, 0]) {
                    m2_nut(l=base_connector_dy-base_thickness);
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  module rear_bottom_screw_hole() {
    wedge_rotate() {
      translate([base_dx-3*base_thickness, -base_dy, 0]) {
        rotate([0, -y_rotation, 0]) {
          rotate([0, 0, -z_rotation]) {
            rotate([front_plane_x_rotation, 0, 0]) {
              translate([-screw_head_dia/tan((90-front_plane_y_rotation)/2), 0, screw_head_dia]) {
                rotate([-90, 0, 0]) {
                  m2_flat_head_screw(l=10);
                }
                translate([0, base_connector_dy+base_thickness, 0]) {
                  rotate([90, 0, 0]) {
                    m2_nut(l=base_connector_dy-base_thickness);
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  module base_top() {
    color("SkyBlue", 1) {
      hull() {
        wedge_mirror() {
          translate([0, -base_dy, 0]) {
            cube([e, base_dy, switch_plate_dz+2*base_thickness]);
          }
        }
      }
      wedge_mirror() {
        translate([0, -base_dy, 0]) {
          cube([base_thickness, base_dy, switch_plate_dz+2*base_thickness]);
        }
        translate([base_thickness-e, -base_dy, 0]) {
          difference() {
            cube([base_thickness+e, base_dy, switch_plate_dz+2*base_thickness]);
            translate([0, base_thickness, base_thickness]) {
              cube([base_thickness+2*e, switch_plate_dy+base_tolerance, switch_plate_dz+base_tolerance]);
            }
          }
        }
      }
      // Front Connector
      hull() {
        wedge_mirror() {
          translate([0, -base_thickness, 0]) {
            translate([0, -base_connector_dy, 0]) {
              cube([e, base_connector_dy, e]);
            }
            cube([base_connector_dx, e, e]);
          }
        }
      }
      // Rear Connector
      hull() {
        wedge_mirror() {
          translate([0, -base_dy+base_thickness, 0]) {
            cube([base_connector_dx, e, e]);
            cube([e, base_connector_dy, e]);
          }
        }
      }
    }
  }
  
  module base_bottom() {
    foot_dia = 13;
    foot_dz = 0.7;

    color("SkyBlue", 1) {
      difference() {
        union() {
          hull() {
            wedge_mirror() {
              translate([switch_plate_dx-base_thickness, -switch_plate_dy-2*base_thickness, 0]) {
                cube([3*base_thickness, base_dy, e]);
              }
            }
          }
          difference() {
            wedge_mirror() {
              translate([switch_plate_dx, -switch_plate_dy-2*base_thickness, 0]) {
                cube([2*base_thickness, base_dy, switch_plate_dz+2*base_thickness]);
              }
            }
            wedge_mirror() {
              translate([switch_plate_dx-e, -switch_plate_dy-base_thickness, base_thickness]) {
                cube([base_thickness+e, switch_plate_dy+base_tolerance, switch_plate_dz+base_tolerance]);
              }
            }
          }
          // Front Connector
          difference() {
            hull() {
              wedge_mirror() {
                translate([switch_plate_dx, -base_thickness, 0]) {
                  translate([-base_connector_dx, 0, 0]) {
                    cube([base_connector_dx, e, e]);
                  }
                  translate([0, -base_connector_dy, 0]) {
                    cube([e, base_connector_dy, e]);
                  }
                }
              }
            }
            // MCU mount cut
            rotate([front_plane_x_rotation, 0, 0]) {
              translate([-mcu_mount_dx/2, 0, -(switch_plate_dx-base_thickness)*cos(front_plane_y_rotation)]) {
                rotate([-front_plane_x_rotation, 0, 0]) {
                  translate([0, -base_connector_dy-base_thickness, 0]) {
                    cube([mcu_mount_dx, base_connector_dy+base_thickness+e, base_connector_dx]);
                  }
                }
              }
            }
          }
          // Rear Connector
          hull() {
            wedge_mirror() {
              translate([switch_plate_dx, -switch_plate_dy-base_thickness, 0]) {
                translate([-base_connector_dx, 0, 0]) {
                  cube([base_connector_dx, e, e]);
                }
                cube([e, base_connector_dy, e]);
              }
            }
          }
          // Accessories
          rotate([front_plane_x_rotation, 0, 0]) {
            translate([0, 0, -(base_dx-3*base_thickness)*cos(front_plane_y_rotation)]) {
              rotate([-front_plane_x_rotation, 0, 0]) {
                mcu_mount();
              }
            }
          }
        }
        // Foot cuts
        translate([0, 0, -e]) {
          wedge_mirror() {
            translate([switch_plate_dx+2*base_thickness, 0, 0]) {
              rotate([0, -y_rotation, 0]) {
                rotate([0, 0, -z_rotation]) {
                  translate([-((3/4)*foot_dia)/tan((90+z_rotation)/2), -(3/4)*foot_dia, 0]) {
                    cylinder(h=foot_dz, d=foot_dia);
                  }
                }
              }
              translate([0, -switch_plate_dy-2*base_thickness, 0]) {
                rotate([0, -y_rotation, 0]) {
                  rotate([0, 0, -z_rotation]) {
                    translate([-((3/4)*foot_dia)/tan((90-z_rotation)/2), (3/4)*foot_dia, 0]) {
                      cylinder(h=foot_dz, d=foot_dia);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  module base_front() {
    color("DeepSkyBlue", 1) {
      difference() {
        union() {
          wedge_mirror() {
            translate([2*base_thickness, -base_thickness, 0]) {
              cube([switch_plate_dx-2*base_thickness, base_thickness, switch_plate_dz+base_thickness]);
            }
          }
          hull() {
            wedge_mirror() {
              translate([0, -base_thickness, 0]) {
                cube([switch_plate_dx-base_thickness, base_thickness, e]);
              }
            }
          }
        }
        rotate([front_plane_x_rotation, 0, 0]) {
          translate([-mcu_mount_dx/2, 0, -(switch_plate_dx-base_thickness)*cos(front_plane_y_rotation)]) {
            rotate([-front_plane_x_rotation, 0, 0]) {
              translate([0, -2*base_thickness, -e]) {
                cube([mcu_mount_dx, 2*base_thickness+e, mcu_mount_dz+e]);
              }
            }
          }
        }
      }
    }
  }

  module base_rear() {
    color("DeepSkyBlue", 1) {
      wedge_mirror() {
        translate([2*base_thickness, -switch_plate_dy-2*base_thickness, 0]) {
          cube([switch_plate_dx-2*base_thickness, base_thickness, switch_plate_dz+base_thickness]);
        }
      }
      hull() {
        wedge_mirror() {
          translate([0, -switch_plate_dy-2*base_thickness, 0]) {
            cube([switch_plate_dx-base_thickness, base_thickness, e]);
          }
        }
      }
    }
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
      children();
    }
  }
}


module m3_flat_head_screw(l) {
  // DIN 965 Flat Head Phillips M3 screw
  e = 0.01;
  color("DarkSlateGrey", 1) {
    // Head
    translate([0, 0, -e]) {
      cylinder(h=1.65+e, d1=5.6, d2=3, $fn=24);
      // Thread
      cylinder(h=l+2*e, d=3, $fn=24);
      }
  }
}

module m2_flat_head_screw(l) {
  e = 0.01;
  color("DarkSlateGrey", 1) {
    // Head
    translate([0, 0, -e]) {
      cylinder(h=1+e, d1=4, d2=2, $fn=24);
      // Thread
      cylinder(h=l+2*e, d=2, $fn=24);
      }
  }
}

module m2_nut(l=1.6) {
  color("DarkSlateGrey", 1) {
    cylinder(h=l, d=4.6, $fn=6);
  }
}
