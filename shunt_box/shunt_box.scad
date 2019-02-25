inside_width = 26;
inside_length = 121.5;
inside_height = 22;
inside_lid_height = 17;

wall = 2;
rounded_radius = 3;
box_margin = 0.15;

power_hole_width = 12;
power_hole_height = 6;
power_hole_vertical_offset = 16;

wire_hole_width = 7;
wire_hole_height = 2;

clip_width = wall / 2;
//clip_width = 0;
clip_width_margin = 0.1;
clip_height = 4;
clip_height_margin = 0.5;

$fn = 100;

module rounded_cube(width, length, height, radius) {
  hull() {
    translate([radius, radius, 0]) cylinder(r = radius, h = height);
    translate([width - radius, radius, 0]) cylinder(r = radius, h = height);
    translate([radius, length - radius, 0]) cylinder(r = radius, h = height);
    translate([width - radius, length - radius, 0]) cylinder(r = radius, h = height);
  }
}

// box
union() {
  difference() {
    rounded_cube(inside_width + 2 * wall, inside_length + 2 * wall, inside_height + wall, rounded_radius + wall);
    translate([wall, wall, wall]) rounded_cube(inside_width, inside_length, inside_height + wall, rounded_radius);
    // power holes
    translate([(inside_width + 2 * wall) / 2 - power_hole_width / 2, -1, power_hole_vertical_offset + wall]) cube([power_hole_width, wall + 2, power_hole_height + 1]);
    translate([(inside_width + 2 * wall) / 2 - power_hole_width / 2, inside_length + wall - 1, power_hole_vertical_offset + wall]) cube([power_hole_width, wall + 2, power_hole_height + 1]);
    // wire hole
    translate([-1, wall + (inside_length - wire_hole_width) / 2, inside_height + wall - wire_hole_height]) cube([wall + 2, wire_hole_width, wire_hole_height + 1]);
    // clip space
    translate([clip_width - clip_width_margin, clip_width - clip_width_margin, clip_width * 2 + inside_height - clip_height - clip_height_margin]) rounded_cube(inside_width + clip_width * 2 + clip_width_margin * 2, inside_length + clip_width * 2 + clip_width_margin * 2, clip_height + clip_height_margin + 1, rounded_radius + clip_width + clip_width_margin);
  }
}

// lid
translate([inside_width + 2 * wall + 5, 0, 0]) union() {
  difference() {
    rounded_cube(inside_width + 2 * wall, inside_length + 2 * wall, inside_lid_height + wall, rounded_radius + wall);
    translate([wall, wall, wall]) rounded_cube(inside_width, inside_length, inside_lid_height + wall, rounded_radius);
    // power holes
    translate([(inside_width + 2 * wall) / 2 - power_hole_width / 2, -1, inside_lid_height + wall - clip_height]) cube([power_hole_width, wall + 2, clip_height + 1]);
    translate([(inside_width + 2 * wall) / 2 - power_hole_width / 2, inside_length + wall - 1, inside_lid_height + wall - clip_height]) cube([power_hole_width, wall + 2, clip_height + 1]);
    // wire hole
    translate([-1, wall + (inside_length - wire_hole_width) / 2, inside_lid_height + wall - clip_height]) cube([wall + 2, wire_hole_width, clip_height + 1]);
    // clip space
    translate([0, 0, inside_lid_height + wall - clip_height]) difference() {
      translate([-1, -1, 0]) cube([inside_width + 2 * wall + 2, inside_length + 2 * wall + 2, clip_height + 2]);
      translate([wall - clip_width + clip_width_margin, wall - clip_width + clip_width_margin, 0]) rounded_cube(inside_width + clip_width * 2 - clip_width_margin * 2, inside_length + clip_width * 2 - clip_width_margin * 2, clip_height + 1, rounded_radius + clip_width - clip_width_margin);
    }
  }
}
