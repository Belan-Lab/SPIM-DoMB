//Sample chamber

FDM_offset = 0.15;


module SampleChamber (){
    difference(){
    union(){
        translate([0,0,6/2])
             cube([50-2*FDM_offset,50-2*FDM_offset,6], center=true);
        translate([0,0,50/2])
            cube([23,23,40], center=true);
        }
    translate([0,0,45/2+5])
        cube([19,19,45], center=true);      

    translate([0,0,25])      
    rotate([0,90,0])
        cylinder(d=16, h=40, center=true);
    translate([0,-10,25])
    rotate([0,90,90])
        cylinder(d=16, h=20, center=true);

    rotate([0,90,0])
    translate([-25,0,23/2+5-0.75])   
        cylinder(d=19+2*FDM_offset, h=10, center=true);
    rotate([0,-90,0])
    translate([25,0,23/2+5-0.75])   
        cylinder(d=19+2*FDM_offset, h=10, center=true);
    rotate([90,0,0])
    translate([0,25,23/2+5-0.75])   
        cylinder(d=19+2*FDM_offset, h=10, center=true);          
    }
}

SampleChamber();