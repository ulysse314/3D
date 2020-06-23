$fn = 100;

delta = 0.4;
delta_y = 0.1;
delta_x = 0.4;
hinge_delta = 0.25;

height = 200;
width = 150;
tube_diameter = 5;

plateform_width = 20;
plateform_length = 20;
plateforme_thickness = 1;

portico_hinge_length = width / 15;
hinge_length = 10;

portico_hinge_diameter = 2.1;
lock_plateform_diameter = 2;

screw_diameter = 2;

attach_hole_width = 2;
attach_hole_length = 4;

fn = 4;
//fn_angle = 360 / fn / 2;
fn_angle = 0;
portico_thickness = tube_diameter * cos(45);

portico_angle = atan((width / 2 - plateform_width / 2) / height);
portico_length = sqrt((width / 2 - plateform_width / 2) * (width / 2 - plateform_width / 2) + height * height);

module tube(length, diameter) {
  if (false) {
    linear_extrude(height = length, convexity = 10, twist = 0)
    circle(d = diameter, $fn = fn);
  } else {
    x = cos(45) * diameter;
    translate([-x / 2, -x / 2, 0]) cube([x, x, length]);
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
