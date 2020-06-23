include <hinge.scad>
include <front_portico.scad>
include <back_portico.scad>
include <camera_support.scad>
include <attach.scad>

if (true) {
  rotate([-90, 0, 180])
    rotate([0, 0, -90])
      back_portico();
  difference() {
    union() {
      rotate([0, 0, 0]) front_portico();
      hinge();
      rotate([-90, 0, 180])
        translate([0, -height + plateforme_thickness / 2, 0])
          rotate([90, 0, 0])
            camera_support();
    }
  }
  translate([0, -130, -portico_thickness / 2]) attach();
} else if (false) {
  rotate([90, 0, 0]) back_portico();
} else if (false) {
  rotate([90, 0, 90]) front_portico();
} else if (false) {
  hinge();
} else if (true) {
  rotate([0, 0, 90]) camera_support();
}
