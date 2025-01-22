//Cylindrical lens holder, ext

/* [Hiden] */
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 10; //holder height
IM_offset = 0.2;

lens_h = 22;
lens_w = 20;

space_l = 10;
wall_th = 2;

module CubeInsert () {
    translate([0, 0, h/2])
    difference(){
        union() {   //basic insert design
            cube([a,b+2*IM_offset,h], center=true);
            cube([b+2*IM_offset,a,h], center=true);
            rotate(a=[0,0,45]){
                cube([c,d+2*IM_offset,h], center=true);
            }
            rotate(a=[0,0,-45]){
                cube([c,d+2*IM_offset,h], center=true);
            }
        }
    }
}


module CLensHolder() {
    difference() {
        union() {
            CubeInsert();
            translate([0,0,(h+space_l)/2])
                cube([lens_h+2*wall_th, lens_w+2*wall_th, h+space_l], center = true);
        }
        translate([0,0,h/2])
            cube([lens_h+2*IM_offset, lens_w+2*IM_offset, 50], center = true);
    }
}

module CLensCap() {
    difference() {
        union() {
            translate([0,0,0.75])
                cube([lens_h+2*wall_th, lens_w+2*wall_th, 1.5], center = true);
            translate([0,0,1.5+0.75])
                cube([lens_h-2*IM_offset, lens_w-2*IM_offset, 3], center = true);
            }
        
        translate([0,0,0.75])
            cube([lens_h-3, lens_w-3, 50], center = true);
    }
}


CLensHolder();

translate([0, 40, 0])
CLensCap();