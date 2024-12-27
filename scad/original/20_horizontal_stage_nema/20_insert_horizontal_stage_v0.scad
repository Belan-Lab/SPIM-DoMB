//Cube insert: Perpendicular 

stage_w = 30;
stage_l = 96.9;
stage_box_h = 35;
stage_h = 28.5;

cube_win_side = 34.1;
cube_side = 49.8;
wall_th = (cube_side - cube_win_side)/2;

/* [Hiden] */
$fn = 80;
eps = .002;
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = cube_win_side/2-stage_w/2;
FDM_offset = 0.15;

scr_d = 2.8; // Screw hole diameter (M3)

mount_x = 92.17 - 3.36;
mount_y = 35.85 - 6.3;

module DoubleInsert() {
    union() {   //basic insert design
            cube([2*a,b+2*FDM_offset,h], center=true);
            cube([2*b+2*FDM_offset+(a-b),a,h], center=true);
        
            translate([(2*a)/4,0,0])
            rotate(a=[0,0,45])
                cube([c,d+2*FDM_offset,h], center=true);
        
            translate([(2*a)/4,0,0])
            rotate(a=[0,0,-45])
                cube([c,d+2*FDM_offset,h], center=true);
        
            translate([-(2*a)/4,0,0])
            rotate(a=[0,0,45])
                cube([c,d+2*FDM_offset,h], center=true);
        
            translate([-(2*a)/4,0,0])
            rotate(a=[0,0,-45])
                cube([c,d+2*FDM_offset,h], center=true);
        }
}

module LaserInsert() {
    difference() {
        // insert base
        union() {
            DoubleInsert();
            translate([0,cube_side/2-wall_th/2,cube_win_side/2])
                cube([83.8-2*FDM_offset,wall_th,cube_win_side-2*FDM_offset], center=true);
        }
        
        // front mounting holes
        rotate([90,0,0])
        translate([83.8/2-6-21,6.5+h+FDM_offset,0])
            cylinder(d = 3,h = 50, center = true);
        rotate([90,0,0])
        translate([83.8/2-6-21,6.5+h+FDM_offset,-cube_side/2-10+3])
            cylinder(d = 6+2*FDM_offset,h = 20, center = true, $fn=6);
        
        rotate([90,0,0])
        translate([83.8/2-6-21,(stage_w-6.5)+h+FDM_offset,0])
            cylinder(d = 3,h = 50, center = true);
        rotate([90,0,0])
        translate([83.8/2-6-21,(stage_w-6.5)+h+FDM_offset,-cube_side/2-10+3])
            cylinder(d = 6+2*FDM_offset,h = 20, center = true, $fn=6);
    }
}


LaserInsert();