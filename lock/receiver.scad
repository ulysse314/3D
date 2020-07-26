include <commun.scad>

difference() {
  union() {
    receiver();
/*    translate([receiver_distance, 0, 0]) receiver();
    translate([receiver_width / 2 - 1, receiver_length - receiver_base_length, 0]) cube([receiver_distance - receiver_width + 2, receiver_base_length, support_height]);*/
  }
}
