include <commun.scad>

module hinge_hinge() {
  union() {
    translate([0, 0, portico_thickness / 2]) rotate([fn_angle, 0, 0]) rotate([0, 90, 0])
    union() {
      translate([0, 0, -tube_diameter / 2]) union() tube(portico_hinge_length - hinge_delta, tube_diameter);
      translate([0, 0, -tube_diameter / 2 + portico_hinge_length * 2 + hinge_delta]) tube(portico_hinge_length - hinge_delta * 2, tube_diameter);
      translate([0, 0, -tube_diameter / 2 + portico_hinge_length * 4 + hinge_delta]) tube(portico_hinge_length - hinge_delta * 2, tube_diameter);
    }
      translate([-tube_diameter / 2, 0, 0]) union() cube([portico_hinge_length - hinge_delta, tube_diameter, portico_thickness]);
      translate([-tube_diameter / 2 + portico_hinge_length * 2 + hinge_delta, 0, 0]) cube([portico_hinge_length - hinge_delta * 2, tube_diameter, portico_thickness]);
      translate([-tube_diameter / 2 + portico_hinge_length * 4 + hinge_delta, 0, 0]) cube([portico_hinge_length - hinge_delta * 2, tube_diameter, portico_thickness]);
  }
}

module hinge() {
  translate([-width / 2, 0, -portico_thickness / 2])
  difference() {
    union() {
      difference() {
        translate([-tube_diameter / 2, 0, 0]) cube([width + tube_diameter, hinge_length + tube_diameter / 2 + hinge_delta, portico_thickness]);
        translate([0, 0, tube_diameter / 2]) rotate([0, 90, 0]) cylinder(d = tube_diameter + hinge_delta * 2, h = width + tube_diameter);
        translate([0, 0, tube_diameter / 2]) cube([width + tube_diameter, tube_diameter / 2 + hinge_delta, portico_thickness]);
      }
      hinge_hinge();
      translate([width / 2, 0, 0]) mirror([1, 0, 0]) translate([-width / 2, 0, 0]) hinge_hinge();
    }
    translate([-tube_diameter / 2 - 1, 0, portico_thickness / 2]) rotate([0, 90, 0]) cylinder(d = portico_hinge_diameter, h = width + tube_diameter + 2, $fn = 100);
    translate([portico_hinge_length * 5 / 2 - tube_diameter / 2, hinge_length / 2 + tube_diameter / 2, -1]) cylinder(d = screw_diameter, h = tube_diameter + 2);
    translate([width + tube_diameter - portico_hinge_length * 5 / 2 - tube_diameter / 2, hinge_length / 2 + tube_diameter / 2, -1]) cylinder(d = screw_diameter, h = tube_diameter + 2);
  }
}
