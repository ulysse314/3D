include <commun.scad>

camera_support_height = 40;
camera_cable_width = 20;
camera_cable_thickness = 3.5;

camera_screw_diameter = 2.5;
camera_screw_width = 21;
camera_screw_length = 12;
camera_offset = 17;
camera_angle = 10;

camera_width = plateform_width + 12;
camera_length = plateform_length + 16;

camera_hole = 10;
camera_hole_offset = 5;

camera_screw_foot_height = 1.75;
camera_screw_foot_width = 5;

camera_wall_angle = atan((camera_support_height * cos(camera_angle) - plateforme_thickness + plateforme_thickness * sin(camera_angle)) / (camera_support_height * sin(camera_angle) + camera_length - plateforme_thickness * cos(camera_angle)));

module camera_support_side() {
  difference() {
    union() {
      cube([plateforme_thickness, camera_length, camera_support_height]);
      rotate([camera_angle, 0, 0]) cube([plateforme_thickness, camera_length, camera_support_height]);
    }
  translate([-1, camera_length, plateforme_thickness])
    rotate([-camera_wall_angle, 0, 0]) translate([0, -camera_length - camera_support_height, 0])
      cube([plateforme_thickness + 2, camera_length + camera_support_height + 1, camera_length + camera_support_height + 1]);
  }
}

module camera_screw_foot_hole() {
  rotate([-90, 0, 0]) cylinder(d = camera_screw_diameter, h = plateforme_thickness + camera_screw_foot_height + 2);
}

module camera_screen_foot() {
  difference() {
    translate([-camera_screw_foot_width / 2, 0, -camera_screw_foot_width / 2 - camera_screw_foot_height]) cube([camera_screw_foot_width, camera_screw_foot_height, camera_screw_foot_width + camera_screw_foot_height]);
    translate([-camera_screw_foot_width / 2 - 1, 0, -camera_screw_foot_width / 2 - camera_screw_foot_height]) rotate([-45, 0, 0]) cube([camera_screw_foot_width + 2, camera_screw_foot_height, camera_screw_foot_width * 2]);
  }
}

module camera_support() {
  translate([-plateform_width / 2 - (camera_width - plateform_width) / 2, -(camera_length - plateform_length) / 2, 0])
  union() {
    difference() {
      cube([camera_width, camera_length, plateforme_thickness]);
      translate([camera_width / 2 - camera_cable_width / 2, plateforme_thickness, -1]) cube([camera_cable_width, camera_cable_thickness, plateforme_thickness + 2]);
      
      translate([(camera_width - plateform_width) / 2, (camera_length - plateform_length) / 2, 0]) translate([0, 0, -1]) female_lock(plateforme_thickness + 2);
      translate([(camera_width + plateform_width) / 2, (camera_length - plateform_length) / 2, 0]) translate([0, 0, -1]) female_lock(plateforme_thickness + 2);
      translate([camera_width / 2, (camera_length + plateform_length) / 2, 0]) translate([0, 0, -1]) rotate([0, 0, 90]) female_lock(plateforme_thickness + 2);
      
      translate([camera_width / 2 + portico_thickness / 2, (camera_length - attach_hole_length) / 2, -1]) cube([attach_hole_width, attach_hole_length, plateforme_thickness + 2]);
      translate([camera_width / 2 - portico_thickness / 2 - attach_hole_width, (camera_length - attach_hole_length) / 2, -1]) cube([attach_hole_width, attach_hole_length, plateforme_thickness + 2]);
    }
    rotate([camera_angle, 0, 0]) difference() {
      union() {
        cube([camera_width, plateforme_thickness, camera_support_height]);
        translate([(camera_width - camera_screw_width) / 2, plateforme_thickness, camera_offset]) camera_screen_foot();
        translate([(camera_width + camera_screw_width) / 2, plateforme_thickness, camera_offset]) camera_screen_foot();
        translate([(camera_width - camera_screw_width) / 2, plateforme_thickness, camera_screw_length + camera_offset]) camera_screen_foot();
        translate([(camera_width + camera_screw_width) / 2, plateforme_thickness, camera_screw_length + camera_offset]) camera_screen_foot();
      }
      translate([(camera_width - camera_screw_width) / 2, -1, camera_offset]) camera_screw_foot_hole();
      translate([(camera_width + camera_screw_width) / 2, -1, camera_offset]) camera_screw_foot_hole();
      translate([(camera_width - camera_screw_width) / 2, -1, camera_screw_length + camera_offset]) camera_screw_foot_hole();
      translate([(camera_width + camera_screw_width) / 2, -1, camera_screw_length + camera_offset]) camera_screw_foot_hole();
      translate([camera_width / 2 -camera_hole / 2, -1, camera_offset - camera_hole_offset]) cube([camera_hole, plateforme_thickness + 2, camera_hole]);
    }
    camera_support_side();
    translate([camera_width - plateforme_thickness, 0, 0]) camera_support_side();
  }
}

//camera_support();
