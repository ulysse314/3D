board_width = 76.7;
board_length = 85;
board_thickness = 1.7;
board_pin_height = 12;

board_rail_depth = 3;

thickness = 1;
wall = 1;

module board_holder_rail() {
  translate([-board_width / 2 - wall, wall, thickness]) cube([board_rail_depth + wall, board_length, board_pin_height]);
  translate([-board_width / 2 - wall, wall, thickness + board_pin_height]) cube([wall, board_length, board_thickness]);
  translate([-board_width / 2 - wall, wall, thickness + board_pin_height + board_thickness]) cube([board_rail_depth + wall, board_length, wall]);
}

module board_holder() {
  translate([-board_width / 2 - wall, 0, 0]) cube([board_width + wall * 2, board_length  + wall, thickness]);
  translate([-board_width / 2 - wall, 0, 0]) cube([board_width + wall * 2, wall, thickness + board_pin_height + board_thickness + wall]);
  board_holder_rail();
  mirror([1, 0, 0]) board_holder_rail();
}
