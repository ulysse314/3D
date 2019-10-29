support_length = 50 + 5 - 13;
support_width = 20;
support_height = 2;

rod_diameter = 3.1;
rod_guide_diameter = 6;
rod_vertical_offset = 1;
rod_open_offset = support_length - 5;
rod_close_offset = rod_open_offset - 15;
rod_opening_size = rod_diameter + 2;

rod_stopper_width = 2;

screw_diameter = 2;

receiver_width = 26;
receiver_length = 6;
receiver_hole_height = 28.5;;

$fn = 75;

module screw() {
  translate([0, 0, -1]) cylinder(h = support_height + 2, d = screw_diameter);
}

module screws() {
  offset = 2;
  back_offset = rod_open_offset - rod_diameter - (rod_open_offset - rod_close_offset - rod_diameter) / 2 + screw_diameter / 2;
  translate([screw_diameter / 2 + offset, screw_diameter / 2 + offset, 0]) screw();
  translate([support_width - screw_diameter / 2 - offset, screw_diameter / 2 + offset, 0]) screw();
  translate([screw_diameter / 2 + offset, back_offset - screw_diameter / 2, 0]) screw();
  translate([support_width - screw_diameter / 2 - offset, back_offset - screw_diameter / 2, 0]) screw();
}

module rode_position() {
  translate([0, -rod_opening_size, 0]) union() {
    rotate([-90, 0, 0]) cylinder(h = rod_opening_size, d = rod_diameter);
    translate([-rod_diameter / 2, 0, 0]) cube([rod_guide_diameter / 2 + rod_diameter / 2, rod_opening_size, rod_guide_diameter]);
  }
}

module rode_stopper() {
  translate([support_width / 2, 0, 0]) cube([support_width / 2, rod_stopper_width, support_height + rod_vertical_offset + rod_guide_diameter / 2 + rod_diameter / 2]);
  translate([support_width / 2, -rod_diameter - rod_stopper_width, 0]) cube([support_width / 2, rod_stopper_width, support_height + rod_vertical_offset + rod_guide_diameter / 2 + rod_diameter / 2]);
}

module rode_bottom() {
  difference() {
    cube([rod_diameter, rod_open_offset, support_height + rod_vertical_offset + rod_diameter / 2]);
    translate([rod_diameter / 2, -1, support_height + rod_diameter / 2 + rod_vertical_offset]) rotate([-90, 0, 0]) cylinder(h = rod_open_offset + 2, d = rod_diameter);
    translate([rod_diameter / 2, rod_close_offset - rod_opening_size, support_height + rod_vertical_offset]) cube([rod_guide_diameter, rod_opening_size, rod_guide_diameter]);
    translate([rod_diameter / 2, rod_open_offset - rod_opening_size, support_height + rod_vertical_offset]) cube([rod_guide_diameter, rod_opening_size, rod_guide_diameter]);
  }
}

module main_part() {
  difference() {
    union() {
      cube([support_width, support_length, support_height]);
      translate([support_width / 2 - rod_guide_diameter / 2, 0, 0]) cube([rod_guide_diameter, support_length, support_height + rod_diameter / 2 + rod_vertical_offset]);
      translate([support_width / 2, 0, support_height + rod_diameter / 2 + rod_vertical_offset]) rotate([-90, 0, 0]) cylinder(h = support_length, d = rod_guide_diameter);
      translate([0, rod_open_offset, 0]) rode_stopper();
      translate([0, rod_close_offset, 0]) rode_stopper();
    }
    translate([support_width / 2, -1, support_height + rod_diameter / 2 + rod_vertical_offset]) rotate([-90, 0, 0]) cylinder(h = rod_open_offset + 1, d = rod_diameter);
    screws();
    translate([support_width / 2, rod_open_offset, support_height + rod_diameter / 2 + rod_vertical_offset]) rode_position();
    translate([support_width / 2, rod_close_offset, support_height + rod_diameter / 2 + rod_vertical_offset]) rode_position();
    translate([support_width / 2 - rod_diameter / 2, rod_close_offset - rod_opening_size, support_height + rod_vertical_offset + rod_diameter / 2]) cube([rod_diameter, rod_open_offset - rod_close_offset + rod_opening_size, rod_guide_diameter]);
    translate([support_width / 2 - rod_diameter / 2, -1, -1]) cube([rod_diameter, rod_open_offset + 1, support_height + rod_vertical_offset + rod_diameter / 2 + 1]);
    translate([support_width / 2, rod_close_offset - rod_opening_size, support_height + rod_vertical_offset]) cube([rod_guide_diameter / 2, rod_opening_size, rod_guide_diameter]);
    translate([support_width / 2, rod_open_offset - rod_opening_size, support_height + rod_vertical_offset]) cube([rod_guide_diameter / 2, rod_opening_size, rod_guide_diameter]);
  }
}

module receiver() {
  difference() {
    union() {
      cube([receiver_width, receiver_length, support_height]);
      translate([receiver_width / 2 - receiver_width / 4, 0, 0]) cube([receiver_width / 2, receiver_length, receiver_hole_height]);
      translate([receiver_width / 2, 0, receiver_hole_height]) rotate([-90, 0, 0]) scale([receiver_width / 2, rod_guide_diameter, 1]) cylinder(h = receiver_length, d = 1);
    }
    translate([receiver_width / 2, -1, receiver_hole_height]) rotate([-90, 0, 0]) cylinder(h = receiver_length + 2, d = rod_diameter);
    translate([receiver_width - receiver_length / 2, receiver_length / 2, -1]) cylinder(h = support_height + 2, d = screw_diameter);
    translate([receiver_length / 2, receiver_length / 2, -1]) cylinder(h = support_height + 2, d = screw_diameter);
  }
}

