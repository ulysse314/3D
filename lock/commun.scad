support_length = 50 + 5 - 3;
support_width = 25;
support_height = 2;
//support_height = 10;

rod_diameter = 3.1;
rod_guide_diameter = 7;
rod_vertical_offset = 1;
rod_open_offset = support_length - 5;
rod_close_offset = rod_open_offset - 15;
rod_opening_size = rod_diameter + 3;

rod_stopper_width = 2;

screw_diameter = 2;
front_screw_offset = 12;
back_screw_offset = rod_open_offset - rod_diameter - (rod_open_offset - rod_close_offset - rod_diameter) / 2 + screw_diameter / 2;
side_screw_offset = 3;
screw_guide_height = 6;

receiver_width = 33;
receiver_tower_width = 13;
//receiver_tower_width = 5;
receiver_length = 15;
receiver_base_length = receiver_length * 1.5;
receiver_hole_height = 28.5;
receiver_hole_width_distance = 20;
receiver_hole_length_margin = 10;

receiver_distance = 121;
corner_radius = 3;

washer_thickness = 1;
bolt_diameter = 4.55;
bolt_height = 1.8;
bolt_holder_diameter = bolt_diameter * 1.75;

locker_receiver_space = 6.5;

$fn = 75;

module screw(higher = false) {
  height = higher ? screw_guide_height + support_height : support_height;
  translate([0, 0, -1]) cylinder(h = height + 2, d = screw_diameter);
}

module screws(higher = false) {
  translate([screw_diameter / 2 + side_screw_offset, screw_diameter / 2 + front_screw_offset, 0]) screw(higher);
  translate([support_width - screw_diameter / 2 - side_screw_offset, screw_diameter / 2 + front_screw_offset, 0]) screw(higher);
  translate([screw_diameter / 2 + side_screw_offset, back_screw_offset - screw_diameter / 2, 0]) screw(higher);
  translate([support_width - screw_diameter / 2 - side_screw_offset, back_screw_offset - screw_diameter / 2, 0]) screw(higher);
}

module bolt_holder() {
  difference() {
    cylinder(h = bolt_height, d = bolt_holder_diameter);
    cylinder(h = bolt_height + 1, d = bolt_diameter, $fn = 6);
  }
}

module rode_position() {
  size = rod_opening_size;
  translate([0, -size, 0]) union() {
    union() {
      rotate([-90, 0, 0]) cylinder(h = size, d = rod_diameter);
      translate([size - rod_diameter / 2, 0, 0])
        rotate_extrude(angle = -90, convexity = 10)
          translate([-size + rod_diameter / 2, 0, 0])
            union() {
              circle(d = rod_diameter);
              translate([-rod_diameter / 2, 0, 0]) square(size = [rod_diameter, rod_guide_diameter]);
            }
    }
  }
}

module rode_stopper() {
  translate([support_width / 2, 0, 0]) cube([support_width / 2, rod_stopper_width, support_height + rod_vertical_offset + rod_guide_diameter / 2 + rod_diameter / 2]);
  translate([support_width / 2, -rod_diameter - rod_stopper_width, 0]) cube([support_width / 2, rod_stopper_width, support_height + rod_vertical_offset + rod_guide_diameter / 2 + rod_diameter / 2]);
}

module rode_bottom() {
  translate([-support_width / 2, 0, 0]) difference() {
    cube([rod_diameter, rod_open_offset, support_height + rod_vertical_offset + rod_diameter / 2]);
    translate([rod_diameter / 2, -1, support_height + rod_diameter / 2 + rod_vertical_offset]) rotate([-90, 0, 0]) cylinder(h = rod_open_offset + 2, d = rod_diameter);
    translate([rod_diameter / 2, rod_open_offset, support_height + rod_diameter / 2 + rod_vertical_offset]) rode_position();
    translate([rod_diameter / 2, rod_close_offset, support_height + rod_diameter / 2 + rod_vertical_offset]) rode_position();
  }
}

module locker(spacer = false) {
  translate([-support_width / 2, 0, 0]) difference() {
    union() {
      cube([support_width, support_length , support_height]);
      translate([support_width / 2 - rod_guide_diameter / 2, 0, 0]) cube([rod_guide_diameter, rod_open_offset + rod_stopper_width, support_height + rod_diameter / 2 + rod_vertical_offset]);
      translate([support_width / 2, 0, support_height + rod_diameter / 2 + rod_vertical_offset]) rotate([-90, 0, 0]) cylinder(h = rod_open_offset + rod_stopper_width, d = rod_guide_diameter);
      translate([0, rod_open_offset, 0]) rode_stopper();
      translate([0, rod_close_offset, 0]) rode_stopper();
      if (spacer) {
        translate([(support_width - rod_diameter * 3) / 2, -locker_receiver_space, 0]) cube([rod_diameter * 3, locker_receiver_space, support_height]);
        translate([screw_diameter / 2 + side_screw_offset, screw_diameter / 2 + front_screw_offset, support_height]) cylinder(d = screw_diameter * 3, h = screw_guide_height);
        translate([support_width - screw_diameter / 2 - side_screw_offset, screw_diameter / 2 + front_screw_offset, support_height]) cylinder(d = screw_diameter * 3, h = screw_guide_height);
        translate([screw_diameter / 2 + side_screw_offset, back_screw_offset - screw_diameter / 2, support_height]) cylinder(d = screw_diameter * 3, h = screw_guide_height);
        translate([support_width - screw_diameter / 2 - side_screw_offset, back_screw_offset - screw_diameter / 2, support_height]) cylinder(d = screw_diameter * 3, h = screw_guide_height);
      }
    }
    translate([support_width / 2, -1, support_height + rod_diameter / 2 + rod_vertical_offset]) rotate([-90, 0, 0]) cylinder(h = rod_open_offset + 1, d = rod_diameter);
    screws(spacer);
    translate([support_width / 2, rod_open_offset, support_height + rod_diameter / 2 + rod_vertical_offset]) rode_position();
    translate([support_width / 2, rod_close_offset, support_height + rod_diameter / 2 + rod_vertical_offset]) rode_position();
    translate([support_width / 2 - rod_diameter / 2, rod_close_offset - rod_opening_size, support_height + rod_vertical_offset + rod_diameter / 2]) cube([rod_diameter, rod_open_offset - rod_close_offset + rod_opening_size, rod_guide_diameter]);
    translate([support_width / 2 - rod_diameter / 2, -1, -1]) cube([rod_diameter, rod_open_offset + 1, support_height + rod_vertical_offset + rod_diameter / 2 + 1]);

    translate([0, support_length - corner_radius, 0]) difference() {
      translate([-1, 0, -1]) cube([corner_radius + 1, corner_radius + 1, support_height + 2]);
      translate([corner_radius, 0, -2]) cylinder(r = corner_radius, h = support_height +4);
    }
    translate([support_width - corner_radius, support_length - corner_radius, 0]) difference() {
      translate([0, 0, -1]) cube([corner_radius + 1, corner_radius + 1, support_height + 2]);
      translate([0, 0, -2]) cylinder(r = corner_radius, h = support_height +4);
    }
  }
}

module locker_washer() {
  difference() {
    hull() {
      translate([-support_width / 2 + screw_diameter / 2 + side_screw_offset, screw_diameter / 2 + front_screw_offset, 0]) cylinder(h = washer_thickness, d = bolt_holder_diameter);
      translate([support_width / 2 - screw_diameter / 2 - side_screw_offset, screw_diameter / 2 + front_screw_offset, 0]) cylinder(h = washer_thickness, d = bolt_holder_diameter);
      translate([-support_width / 2 + screw_diameter / 2 + side_screw_offset, back_screw_offset - screw_diameter / 2, 0]) cylinder(h = washer_thickness, d = bolt_holder_diameter);
      translate([support_width / 2 - screw_diameter / 2 - side_screw_offset, back_screw_offset - screw_diameter / 2, 0]) cylinder(h = washer_thickness, d = bolt_holder_diameter);
    }
    translate([-support_width / 2, 0, 0]) screws();
  }
  translate([-support_width / 2 + screw_diameter / 2 + side_screw_offset, screw_diameter / 2 + front_screw_offset, washer_thickness]) bolt_holder();
  translate([support_width / 2 - screw_diameter / 2 - side_screw_offset, screw_diameter / 2 + front_screw_offset, washer_thickness]) bolt_holder();
  translate([-support_width / 2 + screw_diameter / 2 + side_screw_offset, back_screw_offset - screw_diameter / 2, washer_thickness]) bolt_holder();
  translate([support_width / 2 - screw_diameter / 2 - side_screw_offset, back_screw_offset - screw_diameter / 2, washer_thickness]) bolt_holder();
}

module receiver_washer() {
  translate([-receiver_width / 2, 0, 0]) union() {
    difference() {
      hull() {
      translate([receiver_width - (receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, 0]) cylinder(h = washer_thickness, d = bolt_holder_diameter);
      translate([(receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, 0]) cylinder(h = washer_thickness, d = bolt_holder_diameter);
      }
      translate([receiver_width - (receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, -1]) cylinder(h = washer_thickness + 2, d = screw_diameter);
      translate([(receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, -1]) cylinder(h = washer_thickness + 2, d = screw_diameter);
    }
    translate([receiver_width - (receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, washer_thickness]) bolt_holder();
    translate([(receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, washer_thickness]) bolt_holder();
  }
}

module receiver() {
  extra_base_length = receiver_base_length - receiver_length;
  translate([-receiver_width / 2, 0, 0]) difference() {
    union() {
      translate([0, -extra_base_length, 0]) cube([receiver_width, receiver_base_length, support_height]);
      translate([receiver_width / 2 - receiver_tower_width / 2, 0, 0]) cube([receiver_tower_width, receiver_length, receiver_hole_height]);
      translate([receiver_width / 2, 0, receiver_hole_height]) rotate([-90, 0, 0]) scale([receiver_tower_width, rod_guide_diameter, 1]) cylinder(h = receiver_length, d = 1);
      difference() {
        union() {
          translate([receiver_width / 2 - receiver_tower_width / 2, -extra_base_length, 0]) cube([support_height, receiver_base_length - receiver_length + 1, receiver_hole_height]);
          translate([receiver_width / 2 + receiver_tower_width / 2 - support_height, -extra_base_length, 0]) cube([support_height, receiver_base_length - receiver_length + 1, receiver_hole_height]);
        }
        translate([0, -extra_base_length, support_height]) rotate([-atan(extra_base_length / (receiver_hole_height - support_height)), 0, 0]) translate([0, -500, 0]) cube([receiver_width, 500, 500]);
      }
    }
    translate([receiver_width / 2, -1, receiver_hole_height]) rotate([-90, 0, 0]) cylinder(h = receiver_length + 2, d = rod_diameter);
    translate([receiver_width - (receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, -1]) cylinder(h = support_height + 2, d = screw_diameter);
    translate([(receiver_width - receiver_hole_width_distance) / 2, receiver_hole_length_margin, -1]) cylinder(h = support_height + 2, d = screw_diameter);
    translate([0, receiver_length - receiver_base_length, 0]) difference() {
      translate([-1, -1, -1]) cube([corner_radius + 1, corner_radius + 1, support_height + 2]);
      translate([corner_radius, corner_radius, -2]) cylinder(r = corner_radius, h = support_height +4);
    }
    translate([receiver_width - corner_radius, receiver_length - receiver_base_length, 0]) difference() {
      translate([0, -1, -1]) cube([corner_radius + 1, corner_radius + 1, support_height + 2]);
      translate([0, corner_radius, -2]) cylinder(r = corner_radius, h = support_height +4);
    }
  }
}
