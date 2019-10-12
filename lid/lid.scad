length = 350;
width = 200;
height = 15;
thickness = 5;

width_cut_count = 12;
length_cut_count = 20;

cut_length = width / (width_cut_count * 2 + 1);
cut_width = (length - thickness * 2) / (length_cut_count * 2 + 1);

margin = 0;

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
  if (!outter) {
    translate([0, offset, -1]) cube([thickness + cut_width - margin, thickness + extra, thickness + 2]);
    translate([length - thickness - cut_width + margin, offset, -1]) cube([thickness + cut_width - margin, thickness + extra, thickness + 2]);
  }
  for (i = [0:length_cut_count - (outter ? 1 : 0)]) {
    translate([thickness + cut_width * (i * 2 + (outter ? 1 : 0)) + margin, offset, -1]) cube([cut_width - margin * 2, thickness + extra, thickness + 2]);
  }
}

module main_part() {
  difference() {
    cube([length, width, thickness]);
    width_cut(-1, 1, true);
    width_cut(length - thickness, 1, true);
    length_cut(-1, 1, false);
    length_cut(width - thickness, 1, false);
  }
}

module length_part() {
  difference() {
    cube([length, thickness, height + thickness]);
    length_cut(-1, 2, true);
    translate([-1, -1, -1]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 - margin + 1]);
    translate([-1, -1, (height + thickness) * 2 / 3 + margin]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 - margin + 1]);
    translate([length - thickness, -1, -1]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 - margin + 1]);
    translate([length - thickness, -1, (height + thickness) * 2 / 3 + margin]) cube([thickness + 1, thickness + 2, (height + thickness) / 3 - margin + 1]);
  }
}

module width_part() {
  difference() {
    translate([0, 0, 0]) cube([thickness, width, height + thickness]);
    width_cut(-1, 2, false);
    translate([-1, -1, (height + thickness) / 3 + margin]) cube([thickness + 2, thickness + 1, (height + thickness) / 3 - margin * 2]);
    translate([-1, width - thickness, (height + thickness) / 3 + margin]) cube([thickness + 2, thickness + 1, (height + thickness) / 3 - margin * 2]);
  }
}
