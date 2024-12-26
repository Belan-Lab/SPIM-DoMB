//Cube insert: Perpendicular 

stage_w = 30;
stage_l = 96.9;

cube_win_side = 34.1;

/* [Hiden] */
$fn = 80;
eps = .002;
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 5;
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
        DoubleInsert();
        
        union() {
            translate([mount_x/2,mount_y/2,0])
              cylinder(h = h*2, d = scr_d, center=true);
            
            translate([-mount_x/2,mount_y/2,0])
              cylinder(h = h*2, d = scr_d, center=true);
            
            translate([mount_x/2,-mount_y/2,0])
              cylinder(h = h*2, d = scr_d, center=true);
            
            translate([-mount_x/2,-mount_y/2,0])
              cylinder(h = h*2, d = scr_d, center=true);
        }
    }
}


LaserInsert();