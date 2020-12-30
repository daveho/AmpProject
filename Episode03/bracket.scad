// Mounting bracket for 4x6 cm protoboard
// (use 2, one on each end)

// All units are mm

// width of an M2 nut
nut_w = 3.89;

// allow some clearance (due to imprecision of printer)
nut_clear = 1;

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

// height of bracket (measured to top surface of pads)
bracket_h = 14;

// width of post wall holding up pads
post_w = 3;

// offset of post from center of pad screw holes
post_offset = pad_w/2 + 1;

// length of bottom plate
plate_len = screw_hole_center_d - post_offset*2;

// thickness of bottom plate
plate_h = 2;

// diameter of mounting screw holes (wood screws)
mounting_screw_w = 3.6;

// offset of mounting screw holes from center of pad screw holes
mounting_screw_offset = post_offset + 7;

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

module post() {
    translate([-pad_w/2, -post_w/2, 0]) {
        cube([pad_w, post_w, bracket_h]);
    }
}

module bottom_plate() {
    translate([-pad_w/2, -plate_len/2, 0]) {
        cube([pad_w, plate_len, plate_h]);
    }
}

module bracket() {
    // duplicate and raise pads to correct height
    translate([0, 0, bracket_h - pad_h]) {
        mounting_pad();
        
        translate([0, screw_hole_center_d, 0]) {
            mounting_pad();
        }
    }
    
    // vertical posts to hold pads
    translate([0, post_offset, 0]) {
        post();
    }
    translate([0, screw_hole_center_d-post_offset, 0]) {
        post();
    }
 
    // bottom plate (with mounting screw holes)
    difference() {
        translate([0, post_offset + plate_len/2, 0]) {
            bottom_plate();
        }
        
        translate([0, mounting_screw_offset, -fudge]) {
            cylinder(r=mounting_screw_w/2, h=plate_h+fudge*2, $fn=60);
        }
        
        translate([0, screw_hole_center_d-mounting_screw_offset, -fudge]) {
            cylinder(r=mounting_screw_w/2, h=plate_h+fudge*2, $fn=60);
        }
    }
}

// the bracket is printed on its side (printing the screw holes
// and nut pockets with overhangs shouldn't be a problem)
translate([0, 0, pad_w/2]) {
    rotate([0, 90, 0]) {
        bracket();
    }
}
