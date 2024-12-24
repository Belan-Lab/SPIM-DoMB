//Beam splitter cube holder

bs_side = 24.9;
clamp_h = 2;
cube_win_side = 34.1;

/* [Hiden] */
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;

h = 10; //holder height
FDM_offset = 0.15;

module BSInsert () {
    
    difference(){
        //basic insert design
        union() {   
            cube([a,b+2*FDM_offset,h], center=true);
            cube([b+2*FDM_offset,a,h], center=true);
            rotate(a=[0,0,45])
                cube([c,d+2*FDM_offset,h], center=true);
            rotate(a=[0,0,-45])
                cube([c,d+2*FDM_offset,h], center=true);
        }
        bs_shift = cube_win_side/2-bs_side/2+5;
        translate([0,0,bs_shift])
            cube([bs_side+2*FDM_offset, bs_side+2*FDM_offset, 20], center=true);
        rotate([90,0,0])
        translate([0,bs_shift,0])
            cylinder(d = bs_side, h = 60, center=true, $fn=100);
        rotate([0,90,0])
        translate([-bs_shift,0,0])
            cylinder(d = bs_side, h = 60, center=true, $fn=100);
    }
}

BSInsert();