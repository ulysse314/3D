include <antenna_gps_support.scad>

difference () {
  union() {
    main_body(height_2);
    translate([width /2, length / 2, -tube_length]) cylinder(d = cable_path_size, h = tube_length);
  }
  lower_part();
  cable_path();
  both_screws();
}
