// Mounting bracket for 4x6 cm protoboard
// (use 2, one on each end)

// All units are mm

// width of an M2 nut
nut_w = 3.89;

// allow some clearance (due to imprecision of printer)
nut_clear = 0.8;

// width of the pocket where the nut will sit
nut_pocket_w = nut_w + nut_clear;

// height of M2 nut, use this as the pocket depth
nut_h = 1.5;

// clearance hole width for an M2 screw
screw_hole_w = 2.4;

// distance between centers of screw holes
// (along 4cm dimension of protoboard)
screw_hole_center_d = 35.8;

// width of mounting pad
pad_w = 8;

// height of mounting pad
pad_h = nut_h + 2;

// small fudge factor for making hollows using difference
fudge = 0.1;

module mounting_pad() {
    difference() {
        translate([-pad_w/2, -pad_w/2, 0]) {
            cube([pad_w, pad_w, pad_h]);
        }
        
        translate([0, 0, -fudge]) {
            cylinder(r=nut_pocket_w/2, h=nut_h+fudge, $fn=6);
        }
        
        translate([0, 0, -fudge]) {
            cylinder(r=screw_hole_w/2, h=pad_h+fudge*2, $fn=60);
        }
    }
}

translate([0, 0, pad_w/2]) {
    rotate([90, 0, 0]) {
        mounting_pad();
    }
}
