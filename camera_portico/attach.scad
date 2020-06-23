include <commun.scad>

module attach() {
  attach_thickness = portico_thickness / 2;
  attach_width = 10;
  attach_length = 50;
  attach_height = 15;
  attache_opening = portico_thickness;
  opening_vertical_offset = 0.2;
  triangle_size = 20;
  hole_offset = attach_height * 0.8;

  translate([-attach_length / 2, -attach_width / 2, 0]) difference() {
    union() {
      cube([attach_length, attach_width, attach_thickness]);
      translate([attach_length / 2, 0, 0]) rotate([0, 45, 0]) translate([-triangle_size / 2, 0, -triangle_size / 2]) cube([triangle_size, attach_width, triangle_size]);
      translate([(attach_length - attache_opening) / 2 - attach_thickness, 0, 0]) cube([attach_thickness, attach_width, attach_height]);
      translate([(attach_length + attache_opening) / 2, 0, 0]) cube([attach_thickness, attach_width, attach_height]);
    }
    translate([(attach_length - attache_opening) / 2, -1, opening_vertical_offset]) cube([attache_opening, attach_width + 2, 500]);
    translate([-1, -1, -500]) cube([attach_length + 2, attach_width + 2, 500]);
    translate([0, (attach_width - attach_hole_length) / 2, hole_offset - attach_hole_width / 2]) cube([attach_length, attach_hole_length, attach_hole_width]);
    translate([attach_width / 2, attach_width / 2, -1]) cylinder(d = screw_diameter, h = attach_thickness + 2);
    translate([attach_length - attach_width / 2, attach_width / 2, -1]) cylinder(d = screw_diameter, h = attach_thickness + 2);
  }
}

attach();