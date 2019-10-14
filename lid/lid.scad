inner_length = 350;
inner_width = 200;
inner_height = 15;
thickness = 5;
cut_margin = 0.25;

test_version = false;

length_cut_count = 21;
width_cut_count = 12;

length = inner_length + thickness * 2;
width = inner_width + thickness * 2;
height = inner_height + thickness;
cut_length = width / (width_cut_count * 2 + 1);
cut_width = (length - thickness * 2) / (length_cut_count * 2 + 1);

echo(cut_length);
echo(cut_width);

module length_cut(offset, extra, outter) {
  if (!outter) {
    translate([0, offset, -1]) cube([thickness + cut_width - cut_margin, thickness + extra, thickness + 2]);
    translate([length - thickness - cut_width + cut_margin, offset, -1]) cube([thickness + cut_width - cut_margin, thickness + extra, thickness + 2]);
  }
  for (i = [0:length_cut_count - (outter ? 1 : 0)]) {
    translate([thickness + cut_width * (i * 2 + (outter ? 1 : 0)) + cut_margin, offset, -1]) cube([cut_width - cut_margin * 2, thickness + extra, thickness + 2]);
  }
}

module width_cut(offset, extra, outter) {
  if (outter) {
    translate([offset, -1, -1]) cube([thickness + extra, cut_length * 2 - cut_margin + 1, thickness + 2]);
    translate([offset, width - cut_length * 2 + cut_margin, -1]) cube([thickness + extra, cut_length * 2 + 1, thickness + 2]);
  }
  for (i = [1:width_cut_count - (outter ? 2 : 1)]) {
    translate([offset, cut_length * (i * 2 + (outter ? 1 : 0)) + cut_margin, -1]) cube([thickness + extra, cut_length - cut_margin * 2, thickness + 2]);
  }
}

module cut_for_test() {
  if (test_version) {
    length_count = 5;
    width_count = 4;
    translate([-thickness * 2, cut_length * length_count - cut_margin, -1]) cube([length * 2, width * 2, height * 2]);
    translate([thickness + cut_width * width_count - cut_margin, -thickness * 2, -1]) cube([length * 2, width * 2, height * 2]);
  }
}

module main_part() {
  difference() {
    cube([length, width, thickness]);
    width_cut(-1, 1 - cut_margin, true);
    width_cut(length - thickness + cut_margin, 1 - cut_margin, true);
    length_cut(-1, 1 - cut_margin, false);
    length_cut(width - thickness + cut_margin, 1 - cut_margin, false);
    cut_for_test();
  }
}

module length_part() {
  difference() {
    cube([length, thickness, height]);
    length_cut(-1, 2, true);
    translate([-1, -1, -1]) cube([thickness + 1, thickness + 2, height / 3 - cut_margin + 1]);
    translate([-1, -1, height * 2 / 3 + cut_margin]) cube([thickness + 1, thickness + 2, height / 3 - cut_margin + 1]);
    translate([length - thickness, -1, -1]) cube([thickness + 1, thickness + 2, height / 3 - cut_margin + 1]);
    translate([length - thickness, -1, height * 2 / 3 + cut_margin]) cube([thickness + 1, thickness + 2, height / 3 - cut_margin + 1]);
    cut_for_test();
  }
}

module width_part() {
  difference() {
    translate([0, 0, 0]) cube([thickness, width, height]);
    width_cut(-1, 2, false);
    translate([-1, -1, height / 3 + cut_margin]) cube([thickness + 2, thickness + 1, height / 3 - cut_margin * 2]);
    translate([-1, width - thickness, height / 3 + cut_margin]) cube([thickness + 2, thickness + 1, height / 3 - cut_margin * 2]);
    cut_for_test();
  }
}
