$fn = 150;

height_support = 5;
bord_height = 2;

// 31.75 too big
width = 30.5;
// 43 too small
length = 43.5;
height = height_support + bord_height;

diameter = 28.3;

// 1.25 too big
wall_left_right = 4;
// 1 almost prefect
wall_back = 0.8;
wall_front = 1.9;

hole_width_position = 11.5;
hole_length_position = 12.5;
// 11.5 too small
middle_hole_length_position = 12;
// 1.8 ?
screw_diameter = 1.75;
screw_length = 11;
screw_body_diameter = 2.7;
screw_head_diameter = 4.5;

plug_hole_width = 12;
plug_hole_length = 7;
plug_hole_length_position = 0.25;

width_support = width + wall_left_right * 2;
length_support = length + wall_back + wall_front;

camera_size = 32.25;

camera_holder_height = camera_size + 4;
// 14.5
camera_diameter1 = 14.4;
camera_diameter1_length = 5;
camera_diameter2 = 15.5;
camera_diameter2_length = 7;
camera_front_space = 27;
camera_front_square_depth = 4.5;
camera_plate = 1.6;
camera_front_depth = camera_front_square_depth + camera_diameter2_length + camera_diameter1_length + camera_plate;
front_pilar_diameter = 3.5;

camera_support_extra_space = 8;
camera_support_height = camera_size + camera_support_extra_space * 2;

camera_cover_extra_space = 5;
camera_cover = camera_size + camera_cover_extra_space * 2;
camera_cover_height = camera_support_extra_space - camera_cover_extra_space;

angle = 64;

cover_depth = cos(angle)*camera_cover/sin(angle);

module support() {
  difference() {
    union() {
      cube([width_support, length_support, height]);
      translate([width_support / 2, 0, height]) rotate([-90, 0, 0]) difference() {
        cylinder(d = diameter, h = wall_front);
        translate([-diameter * 1.5, 0, -1]) cube([diameter * 3, diameter, wall_front + 2]);
        //translate([-diameter * 1.5, -35, -1]) cube([diameter * 3, diameter, wall_front + 2]);
      }
    }
    translate([wall_left_right, wall_front, height_support]) difference () {
      cube([width, length, height]);
      translate([0, length, bord_height]) rotate([-135, 0, 0]) cube([width, length, length]);
    }
    translate([width_support / 2 - hole_width_position, length_support / 2 - hole_length_position, -1]) cylinder(d = screw_diameter, h = 10);
    translate([width_support / 2 + hole_width_position, length_support / 2 - hole_length_position, -1]) cylinder(d = screw_diameter, h = 10);
    translate([width_support / 2, length_support / 2 + middle_hole_length_position, -1]) cylinder(d = screw_diameter, h = height);
    translate([width_support / 2 - plug_hole_width / 2, length_support / 2 - plug_hole_length / 2 - plug_hole_length_position, -1]) cube([plug_hole_width, plug_hole_length, height + 2]);
  }
}

module camera_front() {
  difference() {
    translate([-width_support / 2, -camera_support_height / 2, -length_support]) cube([width_support, camera_support_height, length_support]);
    translate([0, 0, -camera_diameter1_length - 1]) cylinder(d = camera_diameter1, h = camera_diameter1_length + 2);
    translate([0, 0, -camera_diameter1_length - camera_diameter2_length - 1]) cylinder(d = camera_diameter2, h = camera_diameter2_length + 1);
    translate([-camera_front_space / 2, -camera_front_space / 2, -camera_diameter1_length - camera_diameter2_length - camera_front_square_depth - 1]) cube([camera_front_space, camera_front_space, camera_front_square_depth + 1]);
    translate([-camera_size / 2, -camera_size / 2, -length_support - camera_diameter1_length - camera_diameter2_length - camera_front_square_depth]) cube([camera_size, camera_size, length_support]);
    translate([-plug_hole_width / 2, -(height + 80), -(length_support / 2 + plug_hole_length / 2 - plug_hole_length_position)]) cube([plug_hole_width, height + 80, plug_hole_length]);
    translate([-camera_size / 2, -camera_cover / 2, -50 - camera_front_depth])  cube([camera_size, camera_cover, 50]);
    translate([-width_support / 2- 1, -camera_support_height / 2, -length_support]) rotate([-angle, 0, 0]) cube([width_support + 2, camera_support_height, 500]);
    translate([camera_size * 0.4, camera_size / 2 + 2, -camera_front_depth - 1]) cylinder(d = screw_diameter, h = screw_length + 1);
    translate([-camera_size * 0.4, camera_size / 2 + 2, -camera_front_depth - 1]) cylinder(d = screw_diameter, h = screw_length + 1);
    translate([camera_size * 0.4, -camera_size / 2 - 2, -camera_front_depth - 1]) cylinder(d = screw_diameter, h = screw_length + 1);
    translate([-camera_size * 0.4, -camera_size / 2 - 2, -camera_front_depth - 1]) cylinder(d = screw_diameter, h = screw_length + 1);
  }
}

module cover() {
  feet = 4.3;
  space_for_screw = 3;
  translate([0, cover_depth, 0]) difference() {
    rotate([90 - angle, 0, 0]) translate([0, -30, -5]) cube([camera_size, camera_cover_height + 30, camera_cover + 50]);
    translate([-50, -50, -100]) cube([100, 100, 100]);
    translate([-50, -50, camera_cover]) cube([100, 100, 100]);
    translate([-50, -100 - cover_depth, -50]) cube([100, 100, 150]);
    translate([(camera_size - plug_hole_width) / 2, -cover_depth - 1, -1]) cube([plug_hole_width, plug_hole_length + 3, camera_cover_extra_space + 2]);
    translate([camera_size * 0.9, -cover_depth + space_for_screw, camera_cover / 2 - camera_size / 2 - 2]) rotate([-90, 0, 0]) cylinder(d = screw_head_diameter, h = 50);
    translate([camera_size * 0.1, -cover_depth + space_for_screw, camera_cover / 2 - camera_size / 2 - 2]) rotate([-90, 0, 0]) cylinder(d = screw_head_diameter, h = 50);
    translate([camera_size * 0.9, -cover_depth + space_for_screw, camera_cover / 2 + camera_size / 2 + 2]) rotate([-90, 0, 0]) cylinder(d = screw_head_diameter, h = 50);
    translate([camera_size * 0.1, -cover_depth + space_for_screw, camera_cover / 2 + camera_size / 2 + 2]) rotate([-90, 0, 0]) cylinder(d = screw_head_diameter, h = 50);
    translate([camera_size * 0.9, -cover_depth - 1, camera_cover / 2 - camera_size / 2 - 2]) rotate([-90, 0, 0]) cylinder(d = screw_body_diameter, h = 50);
    translate([camera_size * 0.1, -cover_depth - 1, camera_cover / 2 - camera_size / 2 - 2]) rotate([-90, 0, 0]) cylinder(d = screw_body_diameter, h = 50);
    translate([camera_size * 0.9, -cover_depth - 1, camera_cover / 2 + camera_size / 2 + 2]) rotate([-90, 0, 0]) cylinder(d = screw_body_diameter, h = 50);
    translate([camera_size * 0.1, -cover_depth - 1, camera_cover / 2 + camera_size / 2 + 2]) rotate([-90, 0, 0]) cylinder(d = screw_body_diameter, h = 50);
    difference() {
      translate([0.75, -cover_depth - 1, camera_cover_extra_space]) cube([camera_size - 1.5, 20, camera_size]);
      rotate([90 - angle, 0, 0]) translate([0, -1, 0]) cube([camera_size, camera_cover_height + 2, camera_cover + 50]);
      translate([0, -cover_depth - 1, camera_cover_extra_space])  cube([feet, 50, feet]);
      translate([0, -cover_depth - 1, camera_cover_extra_space])  cube([feet, 50, feet]);
      translate([0, -cover_depth - 1, camera_cover_extra_space + camera_size - feet])  cube([feet, 50, feet]);
      translate([camera_size - feet, -cover_depth - 1, camera_cover_extra_space])  cube([feet, 50, feet]);
      translate([camera_size - feet, -cover_depth - 1, camera_cover_extra_space + camera_size - feet])  cube([feet, 50, feet]);
    }
  }
}

difference() {
  union() {
    translate([width_support / 2, 0, 0]) rotate([0, 180, 0]) support();
    translate([0, 0, camera_support_height / 2]) rotate([90, 0, 0]) camera_front();
    translate([-camera_size / 2, camera_front_depth + 30, camera_cover_height]) cover();
  }
  //translate([0, -50, 0]) cube([100, 100, 100]);
}