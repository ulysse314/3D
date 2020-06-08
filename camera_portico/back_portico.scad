include <commun.scad>

module back_portico2() {
  translate([0, 0, portico_thickness / 2]) rotate([0, 0, fn_angle]) tube(width, tube_diameter);
  translate([0, 0, tube_diameter / 2 + portico_thickness / 2]) rotate([90, 0, 0]) difference() {
    rotate([0, 0, fn_angle]) tube(height, tube_diameter);
  }
  translate([0, -tube_diameter, -portico_thickness]) rotate([0, 0, fn_angle]) tube(portico_thickness * 2, tube_diameter);
  translate([0, -height + tube_diameter, -portico_thickness]) rotate([0, 0, fn_angle]) tube(portico_thickness * 2, tube_diameter);
  translate([2, -height + tube_diameter + 2, tube_diameter / 2 + portico_thickness / 2]) rotate([0, 0, fn_angle]) translate([0, 0, 0]) tube(plateform_length, tube_diameter);
}

cos_length = height - tube_diameter / 2;
delta_sin = plateform_length;
sin_length = width + portico_thickness / 2 - delta_sin - tube_diameter / 2;
longueur = sqrt(sin_length * sin_length + cos_length * cos_length);
angle = atan(sin_length / cos_length );

module back_portico() {
  translate([0, 0, portico_thickness / 2]) tube(width, tube_diameter);
  translate([0, 0, portico_thickness / 2 + tube_diameter / 2]) rotate([0, 90, 0]) tube(height - tube_diameter / 2 + portico_thickness / 2, tube_diameter);
  translate([tube_diameter, 0, -portico_thickness]) male_lock(portico_thickness * 3 / 2 + tube_diameter / 2);
  translate([height - tube_diameter, 0, -portico_thickness]) male_lock(portico_thickness * 3 / 2 + tube_diameter / 2);
  translate([height - tube_diameter / 2, 0, tube_diameter / 2 + portico_thickness / 2]) tube(plateform_length - portico_thickness / 2 - tube_diameter / 2, tube_diameter);
  rotate([0, 90, 0])  translate([-plateform_length, 0, height - tube_diameter / 2]) portico_lock_plateform();
  translate([0, 0, delta_sin + sin_length]) rotate([0, 90 + angle, 0]) tube(longueur, tube_diameter);
}
