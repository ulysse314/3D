include <antenna_gps_support.scad>

height = 10;

difference() {
  main_body(height);
  translate([width / 2, length / 2, -1]) cylinder(d = cable_path_size, h = height + 2);
  both_screws();
}