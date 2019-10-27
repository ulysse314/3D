include <lock.scad>

main_part();
translate([(support_width - rod_diameter) / 2, 0, -support_height - rod_diameter]) rode_bottom();
