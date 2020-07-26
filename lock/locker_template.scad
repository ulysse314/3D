include <commun.scad>

difference() {
  union() {
    mirror([1, 0, 0]) locker(true);
    translate([receiver_distance, 0, 0]) locker(true);
    translate([support_width / 2 - 1, 0, 0]) cube([receiver_distance - support_width + 2, support_length, support_height]);
    translate([support_width / 2 - 1 - corner_radius, support_length - support_height, 0]) cube([receiver_distance - support_width + 2 + corner_radius * 2, support_height, support_height]);
  }
}
