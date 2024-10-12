//Cube with walls insert template

IM_offset = 0.2;

a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 4; //holder height

wall_width = 2.5;
wall_r_h = 20;
wall_l_h = 20;

led_d = 6.75;

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


module WallInsert () {
    union() {
        CubeInsert();
        translate([a/2-wall_width,-((b+2*IM_offset)/2),0])
            cube([wall_width,b+2*IM_offset,b+2*IM_offset]);
        translate([-((b+2*IM_offset))/2,(a+2*IM_offset)/2-wall_width,0])
            cube([b+2*IM_offset,wall_width,wall_r_h+2*IM_offset]);
        translate([-((b+2*IM_offset))/2,-((a+2*IM_offset)/2),0])
            cube([b+2*IM_offset,wall_width,wall_l_h+2*IM_offset]);
    }
}

module LEDInsert () {
    difference() {
        WallInsert();
        translate([15,-((b+2*IM_offset)/2-6.75),(led_d-2*IM_offset)/2+h+1.4])
        rotate([0,90,0])
            cylinder(h=15,d=led_d-2*IM_offset);
        translate([15,((b+2*IM_offset)/2-6.75),(b+2*IM_offset)-((led_d-2*IM_offset)/2+1.4)])
        rotate([0,90,0])
            cylinder(h=15,d=led_d-2*IM_offset);
    }
}

LEDInsert();