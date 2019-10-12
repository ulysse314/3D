include <lid.scad>

projection(cut = true)
  translate([0, 0, thickness / 2])
  rotate([0, 90, 0])
  width_part();
