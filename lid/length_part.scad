include <lid.scad>

projection(cut = true)
  translate([0, 0, -thickness / 2])
  rotate([90, 0, 0])
  length_part();
