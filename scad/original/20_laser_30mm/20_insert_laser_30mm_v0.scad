//30 mm laser holder

/* [Hiden] */
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 7; //holder height
IM_offset = 0.2;

laser_side = 30 + 2*IM_offset;
space_l = 0;

screw_d = 3;
screw_head_d = 5.75;
screw_head_h = 2;

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


module LaserHolder() {
    difference() {
        union() {
            CubeInsert();
            translate([0,0,(h+space_l)/2])
                cube([laser_side+2, laser_side+2, h+space_l], center = true);
        }
        translate([0,0,h/2])
            cube([laser_side, laser_side, 50], center = true);
    }
}


module LaserHolderBack() {
    difference() {
        CubeInsert();
        translate([0,0,h/2])
            cube([laser_side+1.5, laser_side+1.5, 50], center = true);
        
        // mounting holes
        rotate([90,0,0])
        translate([0,h/2,0])
            cylinder(d = screw_d, h = 50, center = true, $fn = 180);
        
        rotate([90,0,0]){
            translate([0,h/2,25-screw_head_h/2])
                cylinder(d = screw_head_d, h = screw_head_h, center = true, $fn = 180);
            translate([0,h/2,-25+screw_head_h/2])
                cylinder(d = screw_head_d, h = screw_head_h, center = true, $fn = 180);
        }
            
        rotate([0,90,0])
        translate([-h/2,0,0])
            cylinder(d = screw_d, h = 50, center = true, $fn = 180);

        rotate([0,90,0]){
            translate([-h/2,0,25-screw_head_h/2])
                cylinder(d = screw_head_d, h = screw_head_h, center = true, $fn = 180);
            translate([-h/2,0,-25+screw_head_h/2])
                cylinder(d = screw_head_d, h = screw_head_h, center = true, $fn = 180);
        }
    }
}


LaserHolder();

translate([55,0,0])
LaserHolderBack();