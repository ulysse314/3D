include <commun.scad>

hinge_screw_distance = 125;

module hinge_hinge() {
  for (i = [ 1, 3, 5 ]) {
    translate([width / 2 - portico_hinge_length * i - tube_width_delta / 2, 0, 0]) union() {
      translate([0, 0, hinge_height_new / 2]) rotate([0, 90, 0]) cylinder(h = portico_hinge_length + tube_width_delta, d = hinge_height_new, $fn = 100);
      cube([portico_hinge_length + tube_width_delta, tube_diameter_new, hinge_height_new]);
      translate([0, -hinge_height_new / 2, 0]) cube([portico_hinge_length + tube_width_delta, tube_diameter_new, hinge_height_new / 2]);
    }
  }
}

module hinge() {
  translate([0, 0, -portico_thickness / 2])
  difference() {
    union() {
      difference() {
        translate([-(width + tube_width_delta) / 2, tube_diameter_new, 0]) cube([width + tube_width_delta, hinge_length + tube_diameter / 2 + hinge_delta - tube_diameter_new, hinge_height_new]);
        translate([-width / 2 - 1, 0, hinge_height / 2]) rotate([0, 90, 0]) cylinder(d = tube_diameter + hinge_delta * 2, h = width + 2);
      }
      hinge_hinge();
      mirror([1, 0, 0]) hinge_hinge();
    }
    translate([-tube_diameter / 2 - 1-(width + tube_width_delta) / 2, 0, hinge_height_new / 2]) rotate([0, 90, 0]) cylinder(d = portico_hinge_diameter, h = width + tube_diameter + 2, $fn = 100);
    echo (portico_hinge_length * 5 / 2 - tube_diameter / 2-(width + tube_width_delta) / 2);
    translate([-hinge_screw_distance / 2, hinge_length / 2 + tube_diameter / 2, -1]) cylinder(d = screw_diameter, h = tube_diameter + 2);
    echo (width + tube_diameter - portico_hinge_length * 5 / 2 - tube_diameter / 2-(width + tube_width_delta) / 2);
    translate([hinge_screw_distance / 2, hinge_length / 2 + tube_diameter / 2, -1]) cylinder(d = screw_diameter, h = tube_diameter + 2);
  }
}

module hinge_under() {
    translate([0, -bolt_holder_diameter / 2, 0]) union() {
      translate([-(hinge_screw_distance + bolt_holder_diameter) / 2, 0, 0]) cube([hinge_screw_distance + bolt_holder_diameter, bolt_holder_diameter, under_thickness]);
      translate([hinge_screw_distance / 2, bolt_holder_diameter / 2, under_thickness]) bolt_holder();
      translate([-hinge_screw_distance / 2, bolt_holder_diameter / 2, under_thickness]) bolt_holder();
    }
}
