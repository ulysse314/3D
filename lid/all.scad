include <lid.scad>

main_part();

translate([0, -thickness, thickness]) color("red") length_part();
translate([0, width, thickness]) color("red") length_part();

translate([-thickness, 0, thickness]) color("green") width_part();
translate([length, 0, thickness]) color("green") width_part();
