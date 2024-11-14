// Sample holder for OpenFlexure Block Stage. DoMB SPIM
// Borys Olifirov 2024

FDM_offset = 0.2;

holder_base_l = 30;
holder_base_w = 5.5+3*2;

holder_arm_l = 30;


module HolderBase() {
    difference() {
        // main_body
        union() {
            cube([holder_base_l+50,holder_base_w,5]);
            translate([0,holder_base_w/2,0])
                cylinder(d = holder_base_w, h = 5);
            translate([holder_base_l+50,holder_base_w/2,-10])
                cylinder(d = holder_base_w, h = 15);
        }
        
        // bottom hole
        union() {
            translate([0,holder_base_w/2-(3+2*FDM_offset)/2,0])
                cube([50,3+2*FDM_offset,2]);
            translate([0,holder_base_w/2,0])
                cylinder(d = 3+2*FDM_offset, h = 2, $fn = 30);
            translate([50,holder_base_w/2,0])
                cylinder(d = 3+2*FDM_offset, h = 2, $fn = 30);
        }
        
        // up hole
        union() {
            translate([0,holder_base_w/2-(5.5+2*FDM_offset)/2,2])
                cube([50,5.5+2*FDM_offset,3]);
            translate([0,holder_base_w/2,2])
                cylinder(d = 5.5+2*FDM_offset, h = 3, $fn = 30);
            translate([50,holder_base_w/2,2])
                cylinder(d = 5.5+2*FDM_offset, h = 3, $fn = 30);
        }
        
        // screw hole
        translate([holder_base_l+50,holder_base_w/2,-10])
            cylinder(d = 3+2*FDM_offset, h = 15, $fn = 30);
        
    }
}

HolderBase();