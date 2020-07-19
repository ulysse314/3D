$fn = 100;

delta = 0.4;
delta_y = 0.1;
delta_x = 0.4;
hinge_delta = 0.25;

height = 200;
width = 185;
tube_diameter = 5;
hinge_height = 5;
tube_diameter_new = cos(45) * tube_diameter;
//tube_width_delta = -tube_diameter_new + 0.01;
tube_width_delta = -.3;
hinge_height_new = tube_diameter_new + 1;
//tube_diameter_new = 5;

plateform_width = 20;
plateform_length = 20;
plateforme_thickness = 1;

portico_hinge_length = width / 15;
hinge_length = 10;

portico_hinge_diameter = 2.1;
lock_plateform_diameter = 2;

screw_diameter = 2;

attach_hole_width = 2.5;
attach_hole_length = 4;

under_thickness = 1;
bolt_diameter = 4.55;
bolt_height = 1.8;
bolt_holder_diameter = bolt_diameter * 1.75;

fn = 4;
//fn_angle = 360 / fn / 2;
fn_angle = 0;
portico_thickness = tube_diameter * cos(45);

module tube(length, diameter) {
  x = cos(45) * diameter;
//  h = tube_diameter;
//  w = tube_diameter - 0.3;
  h = x;
  w = x;
  echo(x);
  translate([-h / 2, -w / 2, 0]) cube([h, w, length]);
}

module tube2(length, direction) {
  h = tube_diameter_new;
  w = tube_diameter_new + tube_width_delta;
  if (direction) {
    translate([-w / 2, 0, -h / 2]) cube([w, length, h]);
  } else {
    translate([-h / 2, -w / 2, 0]) cube([h, w, length]);
  }
}

module portico_lock_plateform() {
//  tube(tube_diameter / 2 + plateforme_thickness * 2, tube_diameter);
  male_lock(tube_diameter / 2 + plateforme_thickness * 2);
}

module male_lock(length) {
  translate([-(portico_thickness) / 2, -(portico_thickness) / 2, 0]) cube([portico_thickness, portico_thickness, length]);
}

module female_lock(length) {
  translate([-portico_thickness / 2 - delta_x, -portico_thickness / 2 - delta_y, 0]) cube([portico_thickness + delta_x * 2, portico_thickness + delta_y * 2, length]);
}

module bolt_holder() {
  difference() {
    cylinder(h = bolt_height, d = bolt_holder_diameter);
    cylinder(h = bolt_height + 1, d = bolt_diameter, $fn = 6);
  }
}
