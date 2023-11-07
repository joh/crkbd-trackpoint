// the point of this file is to be a sort of DSL for constructing keycaps.
// when you create a method chain you are just changing the parameters
// key.scad uses, it doesn't generate anything itself until the end. This
// lets it remain easy to use key.scad like before (except without key profiles)
// without having to rely on this file. Unfortunately that means setting tons of
// special variables, but that's a limitation of SCAD we have to work around

include <./KeyV2/includes.scad>


// example key
/*dcs_row(5) legend("⇪", size=9) key();*/

// example row
/* for (x = [0:1:4]) {
  translate_u(0,-x) dcs_row(x) key();
} */

// example layout
//preonic_default("oem") key();
//60_percent_default("oem") key();
/*translate([0, $unit/2, 0])*/
/*planck_default("oem") key();*/

// The stem is the hardest part to print, so this variable controls how much 'slop' there is in the stem
// if your keycaps stick in the switch raise this value
//$stem_slop = 0.35; // Not working in thingiverse customizer atm [0:0.01:1]
// broke this out. if your keycaps are falling off lower this value. only works for cherry stems rn
$stem_inner_slop = 0.25;
$stem_inset = 0;

$unit = 19;
$dy = 2.38;

plate_size = 50;
plate_thickness = 3;
plate_hole = 4;

module plate_hole() {
    cylinder(d=plate_hole, h=100, center=true);
}

module plate_holes() {
    translate([-plate_size/2 + plate_hole, plate_size/2 - plate_hole, 0])
    plate_hole();

    translate([-plate_size/2 + plate_hole, -plate_size/2 + plate_hole, 0])
    plate_hole();

    translate([plate_size/2 - plate_hole, -plate_size/2 + plate_hole, 0])
    plate_hole();

    translate([plate_size/2 - plate_hole, plate_size/2 - plate_hole, 0])
    plate_hole();
}

module plate() {
    translate([-plate_size/2, -plate_size/2, 0])
    cube([plate_size, plate_size, plate_thickness]);
}

module top_plate() {
    difference() {
        translate([0, 0, 7])
        plate();
        keys();
        plate_holes();
        trackpoint_hole();
    }
}

module bottom_plate() {
    difference() {
        translate([0, 0, -plate_thickness+1])
        plate();
        keys_slot();
        //keys();
        plate_holes();
        trackpoint_hole();
    }
};

bottom_plate();
translate([plate_size+2, 0, 8])
rotate([0,180,0])
top_plate();
color("gray", .75)
keys();

module keys_slot() {
    linear_extrude(height=4, convexity=2)
    projection()
    keys();
}

module keys() {
    union() {
        translate([-9.54, 8.37, 0])
        //oem_row(1) legend("Y") key();
        oem_row(1) outer_total_shape(false);

        translate([9.47, 10.75, 0])
        //oem_row(1) legend("U") key();
        oem_row(1) outer_total_shape(false);

        translate([-9.53, -10.62, 0])
        //oem_row(2) legend("H") key();
        oem_row(2) outer_total_shape(false);

        translate([9.47, -8.25, 0])
        //oem_row(2) legend("J") key();
        oem_row(2) outer_total_shape(false);
    }
};

module trackpoint_hole() {
    cylinder(d=10, h=40, center=true, $fn=90);
}
