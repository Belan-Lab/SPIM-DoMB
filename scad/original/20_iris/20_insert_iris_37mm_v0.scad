// Iris insert

IM_offset = 0.2;

/* [Hiden] */
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 12; //holder height

iris_a = 23;
iris_h = 7;
iris_d = 37.1; 


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


module IrisInsert() {
    difference(){
        CubeInsert();
        cylinder(d = iris_a, h = 20, $fn = 180);
        
        translate([0,0,h-iris_h])
            cylinder(d = iris_d + 2*IM_offset, h = iris_h, $fn = 180);
        
        translate([-(b+2*IM_offset)/2,0,h-iris_h])
            cube([b+2*IM_offset,b,iris_h]);
    }
}


IrisInsert();