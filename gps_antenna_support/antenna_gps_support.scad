$fn = 200;

length = 46;
width = 40;
height_1 = 5;
height_2 = 10;

cable_diameter = 3.1;
cable_path_size = 9.3;
tube_length = 2;

screw_diameter = 3.3;
screw_head_diameter = 6;
screw_head_height = 3.5;

radius_corner = 4;

module lower_part() {
  union() {
    difference() {
      hull() {
        translate([radius_corner, radius_corner, 0]) cylinder(r = radius_corner, h = height_1);
        translate([width - radius_corner, radius_corner, 0]) cylinder(r = radius_corner, h = height_1);
        translate([0, length * 3 / 4 - radius_corner, 0]) cube([width, radius_corner, height_1]);
      }
      translate([width / 2 - cable_path_size / 2, length / 2 - height_1, -1]) cube([cable_path_size, length / 4 + height_1 + 1, height_1 + 2]);
    }
    translate([width / 2 - cable_path_size / 2 - 1, 0, 0]) cube([cable_path_size + 2, length / 2 - height_1, height_1]);
    translate([0, length / 2 - height_1, 0]) rotate([0, 90, 0]) difference() {
      cylinder(r = height_1, h = width);
      translate([0, -height_1, -1]) cube([height_1, height_1 * 2, width + 2]);
    }
    difference() {
      translate([width /2, length / 2, -tube_length]) cylinder(d = cable_path_size, h = tube_length);
      translate([width / 2 - cable_path_size / 2 - 1, length / 2, -tube_length - 1]) cube([cable_path_size + 2, cable_path_size + 1, tube_length + 1]);
    }
  }
}

module cable_path() {
  translate([width / 2, -1, height_1]) rotate([-90, 0, 0]) cylinder(d = cable_diameter, h = length / 2 - height_1 + 1);
  translate([width / 2, length / 2 - height_1, 0])
    rotate([0, -90, 0])
      rotate_extrude(convexity = 10, angle = 90)
        translate([height_1, 0, 0])
          circle(d = cable_diameter);
  translate([width /2, length / 2, -tube_length - 1]) cylinder(d = cable_diameter, h = tube_length + 1);
}

module screw() {
  translate([0, 0, -1]) cylinder(d = screw_diameter, h = height_2 + 2);
  translate([0, 0, height_2 - screw_head_height]) cylinder(d = screw_head_diameter, h = screw_head_height + 1);
}

module both_screws() {
  translate([(width - cable_path_size) * 3 / 4 + cable_path_size, length / 2, 0]) screw();
  translate([(width - cable_path_size) / 4, length / 2, 0]) screw();
}

module main_body(height) {
  hull() {
    translate([radius_corner, radius_corner, 0]) cylinder(r = radius_corner, h = height);
    translate([width - radius_corner, radius_corner, 0]) cylinder(r = radius_corner, h = height);
    translate([radius_corner, length - radius_corner, 0]) cylinder(r = radius_corner, h = height);
    translate([width - radius_corner, length - radius_corner, 0]) cylinder(r = radius_corner, h = height);
  }
}
