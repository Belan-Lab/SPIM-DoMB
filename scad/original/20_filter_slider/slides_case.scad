// Filters slides holder
slider_h = 9.5;
FDM_offset = 0.2;

module SlidesCase() {
    slider_hf = slider_h + 2*FDM_offset;
    difference() {
        union() {
            cube([9+slider_hf*5,
                3+30+2*FDM_offset,
                40]);
            
            translate([10.25/2,-10.25/2-FDM_offset,0])
            cylinder(d=10.25, h=10);
            translate([0,-10.25/2,0])
                cube([10.25,10.25/2,10]);
            
            translate([10.25/2+25,-10.25/2-FDM_offset,0])
            cylinder(d=10.25, h=10);
            translate([25,-10.25/2,0])
                cube([10.25,10.25/2,10]);
        }
            
        translate([1.5,1.5,2])
        cube([slider_hf,
              30+2*FDM_offset,
              60]);       
        translate([1.5*2+slider_hf,1.5,2])
        cube([slider_hf,
              30+2*FDM_offset,
              60]);
        translate([1.5*3+slider_hf*2,1.5,2])
        cube([slider_hf,
              30+2*FDM_offset,
              60]);
        translate([1.5*4+slider_hf*3,1.5,2])
        cube([slider_hf,
              30+2*FDM_offset,
              60]);
        translate([1.5*5+slider_hf*4,1.5,2])
        cube([slider_hf,
              30+2*FDM_offset,
              50]);
        
        translate([10.25/2+25,-10.25/2-FDM_offset,0]){
            cylinder(d = 6+FDM_offset,h = 20);
            translate([0,0,2])
            cylinder(d = 10.26,h = 20);
        }
        translate([10.25/2,-10.25/2-FDM_offset,0]){
            cylinder(d = 6+FDM_offset,h = 20);
            translate([0,0,2])
            cylinder(d = 10.26,h = 20);
        }
    }
}

SlidesCase();