include <commun.scad>

module portico_hinge() {
  translate([portico_hinge_length - tube_diameter / 2 + hinge_delta, 0, tube_diameter / 2]) rotate([0, 90, 0]) tube(portico_hinge_length - hinge_delta * 2, tube_diameter);
  translate([portico_hinge_length * 3 - tube_diameter / 2 + hinge_delta, 0, tube_diameter / 2]) rotate([0, 90, 0]) tube(portico_hinge_length - hinge_delta * 2, tube_diameter);
}

module portico_hinge_mask() {
  translate([- tube_diameter / 2 - hinge_delta, 0, tube_diameter / 2]) rotate([0, 90, 0]) union() {
    cylinder(h = portico_hinge_length + 2 * hinge_delta, d = tube_diameter + hinge_delta * 2, $fn = 100);
    translate([-tube_diameter / 2 - hinge_delta, 0, 0]) cube([tube_diameter + hinge_delta, tube_diameter, portico_hinge_length + 2 * hinge_delta]);
  }
  translate([portico_hinge_length * 2 - tube_diameter / 2 - hinge_delta, 0, tube_diameter / 2]) rotate([0, 90, 0])  union() {
    cylinder(h = portico_hinge_length + 2 * hinge_delta, d = tube_diameter + hinge_delta * 2, $fn = 100);
    translate([-tube_diameter / 2 - hinge_delta, 0, 0]) cube([tube_diameter + hinge_delta, tube_diameter, portico_hinge_length + 2 * hinge_delta]);
  }
  translate([portico_hinge_length * 4 - tube_diameter / 2 - hinge_delta, 0, tube_diameter / 2]) rotate([0, 90, 0]) union() {
    cylinder(h = portico_hinge_length + 2 * hinge_delta, d = tube_diameter + hinge_delta * 2, $fn = 100);
    translate([-tube_diameter / 2 - hinge_delta, 0, 0]) cube([tube_diameter + hinge_delta, tube_diameter, portico_hinge_length + 2 * hinge_delta]);
  };
}

module front_portico() {
  translate([-width / 2, 0, -tube_diameter / 2])
  difference() {
    union() {
      difference() {
        union() {
          difference() {
            union() {
              translate([0, 0, tube_diameter * 3 / 2]) rotate([0, 90, 0]) tube(width, tube_diameter);
              translate([0, -portico_thickness / 2, tube_diameter / 2]) cube([width, portico_thickness, tube_diameter]);
            }
            translate([-tube_diameter, -tube_diameter, 0]) rotate([0, portico_angle, 0]) cube([tube_diameter, tube_diameter * 2, tube_diameter * 4]);;
            translate([width, -tube_diameter, 0]) rotate([0, -portico_angle, 0]) cube([tube_diameter, tube_diameter * 2, tube_diameter * 2]);;
          }
    
          rotate([0, portico_angle, 0]) tube(portico_length, tube_diameter);
          translate([width, 0, 0]) rotate([0, -portico_angle, 0]) tube(portico_length, tube_diameter);
          translate([width / 2, 0, tube_diameter * (3 / 2)]) tube(height - tube_diameter * 3 / 2, tube_diameter);

          translate([width / 2 - plateform_width / 2, 0, height]) rotate([0, 90, 0]) tube(plateform_width, tube_diameter);
          translate([width / 2 - plateform_width / 2, 0, height]) portico_lock_plateform();
          translate([width / 2 + plateform_width / 2, 0, height]) portico_lock_plateform();

          translate([width / 2 - tube_diameter, 0, tube_diameter * 4 / 2]) rotate([0, 90, 0]) tube(tube_diameter * 2, tube_diameter);
          translate([width / 2 - tube_diameter, -portico_thickness / 2, tube_diameter]) cube([tube_diameter * 2, portico_thickness, tube_diameter]);
    
          translate([width / 2 - tube_diameter * 2 / 2, 0, height - tube_diameter]) rotate([0, 90, 0]) tube(tube_diameter * 2, tube_diameter);
          translate([width / 2 - tube_diameter * 2 / 2, -portico_thickness / 2, height - tube_diameter]) cube([tube_diameter * 2, portico_thickness, tube_diameter]);
        }
        translate([-tube_diameter, -tube_diameter, -tube_diameter / 2]) cube([width + tube_diameter * 2, tube_diameter * 2, tube_diameter]);
        translate([width / 2, -tube_diameter, tube_diameter * 3 / 2]) rotate([0, 90, 90]) female_lock(tube_diameter * 2);
        translate([width / 2, -tube_diameter, height - tube_diameter / 2]) rotate([0, 90, 90]) female_lock(tube_diameter * 2);
      }
      portico_hinge();
      translate([width / 2, 0, 0]) mirror([1, 0, 0]) translate([-width / 2, 0, 0]) portico_hinge();
    }
    portico_hinge_mask();
    translate([width / 2, 0, 0]) mirror([1, 0, 0]) translate([-width / 2, 0, 0]) portico_hinge_mask();
    translate([-tube_diameter / 2 - 1, 0, tube_diameter / 2]) rotate([0, 90, 0]) cylinder(d = portico_hinge_diameter, h = width + tube_diameter + 2, $fn = 100);
  }
}
