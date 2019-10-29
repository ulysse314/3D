include <lock.scad>

main_part();
translate([(support_width - rod_diameter) / 2, 0, -support_height - rod_diameter]) rode_bottom();
translate([support_width / 2 - receiver_width / 2, -receiver_length - 5, 0]) receiver();
