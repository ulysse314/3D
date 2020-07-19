include <commun.scad>

module portico_hinge() {
  for (i = [ 2, 4 ]) {
    translate([hinge_height_new / 2, width / 2 - portico_hinge_length * i - tube_width_delta / 2, 0])
      rotate([-90, 0, 0]) cylinder(h = portico_hinge_length + tube_width_delta, d = tube_diameter_new);
  }
}

module portico_hinge_mask() {
  for (i = [ 1, 3, 5 ]) {
    translate([0, width / 2 - portico_hinge_length * i + tube_width_delta / 2, 0]) union() {
      translate([0, 0, -tube_diameter_new]) cube([hinge_height_new - tube_width_delta, portico_hinge_length - tube_width_delta, tube_diameter_new * 2]);
    }
  }
}

module front_portico() {
  sin_length = (width - plateform_width - tube_diameter_new) / 2;
  cos_length = height - hinge_height_new - tube_diameter_new / 2;
  portico_angle = atan(sin_length / cos_length);
  portico_length = sqrt(sin_length * sin_length + cos_length * cos_length);
  translate([-hinge_height / 2, 0, 0]) difference() {
    union() {
      difference() {
        union() {
          translate([hinge_height_new / 2, -(width + tube_width_delta) / 2, -tube_diameter_new / 2]) cube([hinge_height_new, width + tube_width_delta, tube_diameter_new]);
          translate([hinge_height_new * 3 / 2, -(width + tube_width_delta) / 2, 0]) tube2(width + tube_width_delta, true);
          translate([hinge_height_new + tube_diameter_new - (tube_diameter_new * 3 + tube_width_delta) / 2, -(tube_diameter_new * 3 + tube_width_delta) / 2, -tube_diameter_new / 2]) cube([tube_diameter_new * 3 + tube_width_delta, tube_diameter_new * 3 + tube_width_delta, tube_diameter_new]);
        }
        translate([hinge_height_new / 2 + tube_diameter_new / 2, (width + tube_width_delta) / 2, -tube_diameter]) rotate([0, 0, -portico_angle]) cube([tube_diameter * 4, tube_diameter, tube_diameter * 2]);
        translate([hinge_height_new / 2 + tube_diameter_new / 2, -(width + tube_width_delta) / 2, -tube_diameter]) rotate([0, 0, portico_angle]) translate([0, -tube_diameter, 0]) cube([tube_diameter * 4, tube_diameter, tube_diameter * 2]);

        translate([hinge_height_new + tube_diameter_new - (tube_diameter_new - tube_width_delta) / 2, -(tube_diameter_new - tube_width_delta) / 2, -tube_diameter_new / 2 - 1]) cube([tube_diameter_new - tube_width_delta, tube_diameter_new - tube_width_delta, tube_diameter_new + 2]);
      }
      translate([hinge_height_new + tube_diameter_new * 2, 0, 0]) rotate([0, 0, -90]) tube2(height - hinge_height_new - tube_diameter_new * 3 + tube_width_delta * 3 / 2 - tube_diameter_new, true);
      translate([hinge_height_new / 2 + tube_diameter_new / 2, (width - tube_diameter_new) / 2, 0]) rotate([0, 0, -portico_angle - 90]) tube2(portico_length, true);
      translate([hinge_height_new / 2 + tube_diameter_new / 2, -(width - tube_diameter_new) / 2, 0]) rotate([0, 0, portico_angle - 90]) tube2(portico_length, true);

      translate([height + tube_width_delta - tube_width_delta / 2, tube_diameter_new, 0]) rotate([0, 0, 90]) tube2(tube_diameter_new * 3 + tube_width_delta, true);
      translate([height + tube_width_delta - tube_width_delta / 2, -tube_diameter_new, 0]) rotate([0, 0, 90]) tube2(tube_diameter_new * 3 + tube_width_delta, true);
      translate([height - tube_diameter_new * 2.5, -tube_diameter_new * 3 / 2 - tube_width_delta / 2, 0]) tube2(tube_diameter_new * 3 + tube_width_delta, true);

      translate([height - tube_diameter_new / 2, -(plateform_width + tube_diameter_new + tube_width_delta) / 2]) tube2(plateform_width + tube_diameter_new + tube_width_delta, true);

      translate([height - tube_diameter_new - tube_width_delta / 2, plateform_width / 2, 0]) rotate([0, 90, 0]) tube2(tube_diameter_new * 3 / 2, false);
      translate([height - tube_diameter_new - tube_width_delta / 2, -plateform_width / 2, 0]) rotate([0, 90, 0]) tube2(tube_diameter_new * 3 / 2, false);

      portico_hinge();
      mirror([0, 1, 0]) portico_hinge();

    }
    portico_hinge_mask();
    mirror([0, 1, 0])  portico_hinge_mask();
    translate([hinge_height_new / 2, -width / 2 - 1, 0]) rotate([-90, 0, 0]) cylinder(d = portico_hinge_diameter, h = width + 2, $fn = 100);
  }
}
