//Cube insert for 25 mm filters
filter_d = 25;
filter_aperture = 20.75;
filter_h = 3.5; // 3.45 (3.5) or 4.95 (5)
filter_name = "D535/40M";

holder_h = filter_h + 4;
slide_w = 30;
cap_w = 2;

/* [Hiden] */
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = holder_h + cap_w + 2;
IM_offset = 0.2;


module Insert () {
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


module SliderInsert () {
    difference() {
        Insert();
        cylinder(d=filter_aperture, h=h);  // aperture
        
        // main slot
        translate([0,0,2])  
           cylinder(d=slide_w+2*IM_offset, h=h-2);
        translate([0,-50/2,h/2+2])
            cube([slide_w+2*IM_offset,50,h], center=true);
        
        // cap step
        translate([0,0,h-cap_w])  
           cylinder(d=b+IM_offset*2, h=cap_w+IM_offset);
        translate([0,-50/2,h-cap_w+cap_w/2+IM_offset/2])
            cube([b+IM_offset*2,50,cap_w+IM_offset], center=true);
        
    }
}


module SliderCap () {
    difference() {
        union() {
            cylinder(d=b+IM_offset*2, h=cap_w);
            translate([-(b+IM_offset*2)/2,-d/2,0])
                cube([b+IM_offset*2,d/2-IM_offset,cap_w]);
        }
    cylinder(d=filter_aperture, h=h);  // aperture
    }
}


module FilterHolder () {
    l = 40;
    difference() {
        // solid part
        union() {
            cylinder(d=slide_w-2*IM_offset, 
                     h=holder_h-2*IM_offset);
            translate([-(slide_w-2*IM_offset)/2,-l,0])
                cube([slide_w-2*IM_offset,
                      l,
                      holder_h-2*IM_offset]);
        }
        translate([(slide_w-2*IM_offset)/2,-l,0])
            cylinder(d=10, h=holder_h-2*IM_offset);
        translate([-(slide_w-2*IM_offset)/2,-l,0])
            cylinder(d=10, h=holder_h-2*IM_offset);
        
        // filter hole
        cylinder(h=50, d=filter_aperture);
        translate([0,0,2])
            cylinder(h=50, d=filter_d+2*IM_offset);
        
        // text
        translate([0,-(l-10),holder_h-2*IM_offset-2])
        rotate([0,0,180])
            linear_extrude(height = 2)
                text(filter_name,
                     size=3,
                     font="Arial black:style=Bold",
                     halign = "center", spacing=1);
    }
}


module FilterClip () {
    difference() {
        cylinder(d=filter_d+2*IM_offset, h=2);
        cylinder(d=filter_aperture+1.5, h=2);
        translate([0,-1,0])
        cube([40,2,2]);
    }
}


SliderInsert();

translate([-50,0,0])
SliderCap ();

translate([50,0,0])
FilterHolder();

translate([85,0,0])
FilterClip();