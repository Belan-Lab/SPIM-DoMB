//Cube with walls insert template

IM_offset = 0.3;

a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 3; //holder height

hole_w = 22;
hole_l = 20;

step_w = 1;
step_h = 1;

module CubeInsert () {
    translate([0,0,h/2])
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


module CLensInsert () {
    difference() {
        CubeInsert();
        translate([-(hole_w-step_w+2*IM_offset)/2,-(hole_l-step_w+2*IM_offset)/2,0])
            cube([hole_w-step_w+2*IM_offset,hole_l-step_w+2*IM_offset,20]);
        translate([-(hole_w+2*IM_offset)/2,-(hole_l+2*IM_offset)/2,step_h])
            cube([hole_w+2*IM_offset,hole_l+2*IM_offset,20]);
    }
}

CLensInsert();