cube_width        = 4.3; // measured: 4.5
cube_height       = 2.4; // measured: 2.4
base_dia          = 7.0; // measured: 7.0
base_height       = 3.6; // measured: 0.6
bottom_hole_dia   = 3.3; // measured: 3.1
bottom_hole_depth = 2.0; // measured: 2.0
hole_dia          = 2.0; // measured: 1.8
screw_head_dia    = 2.7; // measured: 2.5
screw_head_depth  = 3.0; // measured: 3.0

$fn = 60;

difference() {
union() {
translate([-cube_width/2, -cube_width/2, base_height])
cube([cube_width, cube_width, cube_height]);

cylinder(d=base_dia, h=base_height);
}

translate([0, 0, -bottom_hole_depth])
cylinder(d=bottom_hole_dia, h=2*bottom_hole_depth);

cylinder(d=hole_dia, h=10);

translate([0, 0, screw_head_depth])
cylinder(d=screw_head_dia, h=10);
}
