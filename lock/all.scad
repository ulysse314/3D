include <commun.scad>

locker();
translate([(support_width - rod_diameter) / 2, 0, -support_height - rod_diameter]) rode_bottom();
translate([receiver_width / 2 - receiver_width / 2, -receiver_length - 5, 0]) receiver();
translate([0, 0, -15]) mirror([0, 0, 1]) locker_washer();
translate([0, -receiver_length - 5, -15]) mirror([0, 0, 1]) receiver_washer();
