length = 350;
width = 200;
height = 15;
thickness = 5;

width_cut_count = 5;
length_cut_count = 8;

module width_cut(offset, extra, outter) {
  cut_length = width / (width_cut_count * 2 + 1);
  for (i = [0:width_cut_count - (outter ? 1 : 0)]) {
    translate([offset, cut_length * (i * 2 + (outter ? 1 : 0)), -1]) cube([thickness + extra, cut_length, thickness + 2]);
  }
}

module length_cut(offset, extra, outter) {
  cut_width = length / (length_cut_count * 2 + 1);
  for (i = [0:length_cut_count - (outter ? 1 : 0)]) {
    translate([cut_width * (i * 2 + (outter ? 1 : 0)), offset, -1]) cube([cut_width, thickness + extra, thickness + 2]);
  }
}

module main_part() {
  difference() {
    cube([length, width, thickness]);
    width_cut(-1, 1, false);
    width_cut(length - thickness, 1, false);
    length_cut(-1, 1, true);
    length_cut(width - thickness, 1, true);
  }
}

module length_part() {
  difference() {
    cube([length, thickness, height + thickness]);
    length_cut(-1, 2, false);
    translate([-1, -1, -1]) cube([thickness + 1, thickness + 2, (height + thickness) / 2 + 1]);
    translate([length - thickness, -1, -1]) cube([thickness + 1, thickness + 2, (height + thickness) / 2 + 1]);
  }
}

module width_part() {
  difference() {
    translate([0, 0, 0]) cube([thickness, width, height + thickness]);
    width_cut(-1, 2, true);
    translate([-1, -1, (height + thickness) / 2]) cube([thickness + 2, thickness + 1, (height + thickness) / 2 + 1]);
    translate([-1, width - thickness, (height + thickness) / 2]) cube([thickness + 2, thickness + 1, (height + thickness) / 2 + 1]);
  }
}
