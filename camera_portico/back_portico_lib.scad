include <commun.scad>

cos_length = height - tube_diameter_new / 2 - 2;
delta_sin = plateform_length;
sin_length = width - plateform_length;
longueur = sqrt(sin_length * sin_length + cos_length * cos_length);
angle = atan(sin_length / cos_length );

module back_portico() {
  translate([tube_diameter_new / 2, (tube_diameter_new - tube_width_delta) / 2, 0]) tube2(width + tube_width_delta, true);
  translate([-tube_width_delta / 2, tube_diameter_new, 0]) rotate([0, 90, 0]) tube2(height + tube_width_delta, false);
  translate([(tube_diameter_new ) / 2, delta_sin + sin_length, 0]) rotate([0, 90, -angle]) tube2(longueur, false);

  translate([height - tube_diameter_new - tube_diameter_new / 2, tube_diameter_new, 0]) rotate([0, 0, 180]) tube2(tube_diameter_new * 2 + tube_width_delta, true);
  translate([hinge_height_new + tube_diameter_new, tube_diameter_new, 0]) rotate([0, 0, 180]) tube2(tube_diameter_new * 2 + tube_width_delta, true);

  translate([height - tube_diameter_new / 2, tube_diameter_new, 0]) tube2(plateform_length - tube_diameter_new, true);
  translate([height - tube_diameter_new - tube_width_delta / 2, plateform_length, 0]) rotate([0, 90, 0]) tube2(tube_diameter_new * 3 / 2, false);
}
