/*
 * Tenting leg for crkbd_trackpoint_case
 */
include <Chamfers-for-OpenSCAD/Chamfer.scad>;

// Leg thickness (height)
thickness=10;

// Leg length (from screw center to bottom, including pad)
length=42.5;

// Diameter of screw hole
screw_dia=3.2;

// Diameter of screw head inset
screw_head_dia=5.6;

// Depth of screw head inset
screw_head_inset=thickness - 6.8;

// Diameter of anti-slip pad
pad_dia=8;

// Depth of inset for anti-slip pad
pad_depth=1;

// Chamfer
ch = 1;

$fn=360;

difference() {
    r = max(screw_head_dia/2 + 2, thickness/2);
    d = sqrt(2)*thickness;
    chamfers = [[1, 1, 1, 1], [0, 0, 0, 0], [0, 0, 0, 0]];
    union() {
        chamferCylinder(h=thickness, r=r, ch=ch);
        translate([0, -thickness/2, 0])
            chamferCube([length-thickness/2, thickness, thickness], chamfers, ch);

        translate([length-d/2, 0, thickness/2])
        intersection() {
            sphere(d=d);
            translate([0, -thickness/2, -thickness/2])
            chamferCube([thickness, thickness, thickness], chamfers, ch);
        }
    }

    translate([0, 0, thickness-screw_head_inset])
        cylinder(h=100, d=screw_head_dia);
    cylinder(h=100, d=screw_dia, center=true);

    s = (d/2) - sqrt((d/2)^2 - (pad_dia/2)^2);
    translate([(length-s-pad_depth), 0, thickness/2])
    rotate([0, 90, 0])
        cylinder(h=100, d=pad_dia);
}
