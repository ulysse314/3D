include <attach_lib.scad>
include <back_portico_lib.scad>
include <camera_support_lib.scad>
include <front_portico_lib.scad>
include <hinge_lib.scad>

rotate([180, -90, 0]) back_portico();
translate([0, 0, hinge_height / 2]) rotate([0, -90, 90]) front_portico();
translate([0, 0, portico_thickness / 2]) hinge();
rotate([-90, 0, 180])
  translate([0, -height + plateforme_thickness / 2, 0])
    rotate([90, 0, 0])
      camera_support();
translate([0, -130, 0]) attach();
translate([0, -130, -5]) rotate([180, 0, 0]) attach_under();
translate([0, 0, -5]) rotate([180, 0, 0]) hinge_under();