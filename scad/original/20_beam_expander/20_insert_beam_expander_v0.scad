// IN PROGRESS
//Cube insert: beam expander


/* [Hiden] */
$fn = 80;
eps = .002;
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 5;
IM_offset = 0.17;

1st_lens_w = 8.45;   // phone lens side size
1st_lens_h = 20;

2nd_lens_d = 20.3;  // objective lens diameter
2nd_lens_h = 30;

lens_l = 15;


module Insert() {
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

module LensTube() {
    translate([0,5,2nd_lens_d/2-(h/2-2)]) // 2nd_lens_d/2
    rotate([90,0,0])
    union() {
        cylinder(h=lens_l,
                 d1=1st_lens_w*1.4 + 2*IM_offset,
                 d2=2nd_lens_d + 2*IM_offset, center=true);
        
        translate([0,0,
                   lens_l/2+2nd_lens_h*2])
        cylinder(h=2nd_lens_h*4,
                 d=2nd_lens_d + 2*IM_offset, center=true);
        
        translate([0,0,
                   -(lens_l/2+1st_lens_h*2)])
        cube([1st_lens_w + 2*IM_offset,
              1st_lens_w + 2*IM_offset,
              1st_lens_h*4],
              center=true);
    }
}

module ExpanderInsert() {
    difference() {
        union(){
            Insert();
            translate([0,0,5])
            rotate([-90,45,0])
            difference() {
                cylinder(a,2nd_lens_d,1st_lens_w+2,
                         $fn=4,center=true);
                
                translate([0,25,0])
                rotate([0,0,45])
                cube([30,100,a], center=true);

                translate([0,-31,0])
                rotate([0,0,45])                
                cube([30,100,a], center=true);
            }
        }
        LensTube();
    }  
}


ExpanderInsert();

