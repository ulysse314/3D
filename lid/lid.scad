length = 350;
width = 200;
height = 15;
thickness = 5;

width_cut_count = 12;
length_cut_count = 21;

cut_length = width / (width_cut_count * 2 + 1);
cut_width = length / (length_cut_count * 2 + 1);

echo(cut_length);
echo(cut_width);

module width_cut(offset, extra, outter) {
  if (outter) {
    translate([offset, -1, -1]) cube([thickness + extra, cut_length * 2 + 1, thickness + 2]);
    translate([offset, width - cut_length * 2, -1]) cube([thickness + extra, cut_length * 2 + 1, thickness + 2]);
  }
  for (i = [1:width_cut_count - (outter ? 2 : 1)]) {
    translate([offset, cut_length * (i * 2 + (outter ? 1 : 0)), -1]) cube([thickness + extra, cut_length, thickness + 2]);
  }
}

module length_cut(offset, extra, outter) {
  if (outter) {
    translate([-1, offset, -1]) cube([cut_width * 2 + 1, thickness + extra, thickness + 2]);
    translate([length - cut_width * 2, offset, -1]) cube([cut_width * 2 + 1, thickness + extra, thickness + 2]);
  }
  for (i = [1:length_cut_count - (outter ? 2 : 1)]) {
    translate([cut_width * (i * 2 + (outter ? 1 : 0)), offset, -1]) cube([cut_width, thickness + extra, thickness + 2]);
  }
}

module main_part() {
  difference() {
    cube([length, width, thickness]);
    width_cut(-1, 1, true);
    width_cut(length - thickness, 1, true);
    length_cut(-1, 1, true);
    length_cut(width - thickness, 1, true);
  }
}

module length_part() {
  difference() {
    cube([length, thickness, height + thickness]);
    length_cut(-1, 2, false);
    translate([-1, -1, -1]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 + 1]);
    translate([-1, -1, (height + thickness) * 2 / 3]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 + 1]);
    translate([length - thickness, -1, -1]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 + 1]);
    translate([length - thickness, -1, (height + thickness) * 2 / 3]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 + 1]);
  }
}

module width_part() {
  difference() {
    translate([0, 0, 0]) cube([thickness, width, height + thickness]);
    width_cut(-1, 2, false);
    translate([-1, -1, (height + thickness) / 3]) cube([thickness + 2, thickness + 1, (height + thickness) / 3]);
    translate([-1, width - thickness, (height + thickness) / 3]) cube([thickness + 2, thickness + 1, (height + thickness) / 3]);
  }
}
