// Sample holder for OpenFlexure Block Stage. DoMB SPIM
// Borys Olifirov 2024

FDM_offset = 0.2;

holder_screw_d = 3;
holder_screw_hd = 5.5;
holder_nut_size = 6;

holder_base_l = 25;
holder_base_screw_l = 75;
holder_base_w = holder_screw_hd+3*2;

holder_arm_l = 20;
holder_arm_w = holder_screw_hd + 3*2;

syringe_d = 6;
clip_wall = 1.5;


module HolderBase() {
    difference() {
        // main_body
        union() {
            cube([holder_base_l+holder_base_screw_l,holder_base_w,5]);
            translate([0,holder_base_w/2,0])
                cylinder(d = holder_base_w, h = 5);
            translate([holder_base_l+holder_base_screw_l,holder_base_w/2,0])
                cylinder(d = holder_base_w, h = 5);
        }
        
        // bottom hole
        union() {
            translate([0,holder_base_w/2-(3+2*FDM_offset)/2,0])
                cube([holder_base_screw_l,3+2*FDM_offset,2]);
            translate([0,holder_base_w/2,0])
                cylinder(d = 3+2*FDM_offset, h = 2, $fn = 30);
            translate([holder_base_screw_l,holder_base_w/2,0])
                cylinder(d = 3+2*FDM_offset, h = 2, $fn = 30);
        }
        
        // up hole
        union() {
            translate([0,holder_base_w/2-(5.5+2*FDM_offset)/2,2])
                cube([holder_base_screw_l,holder_screw_hd+2*FDM_offset,3]);
            translate([0,holder_base_w/2,2])
                cylinder(d = holder_screw_hd+2*FDM_offset, h = 3, $fn = 30);
            translate([holder_base_screw_l,holder_base_w/2,2])
                cylinder(d = holder_screw_hd+2*FDM_offset, h = 3, $fn = 30);
        }
        
        // screw hole
        translate([holder_base_l+holder_base_screw_l,holder_base_w/2,0])
            cylinder(d = holder_screw_d+2*FDM_offset, h = 15, $fn = 30);
        
    }
}


module HolderClipArm() {
    clip_offset = 0.4;
    union() {
        // main body
        difference() {
            union() {
                cube([holder_arm_l,holder_base_w,5]);
                translate([0,holder_arm_w/2,0])
                    cylinder(d = holder_base_w, h = 15);
                translate([holder_arm_l,holder_arm_w/2,0])
                    cylinder(d = holder_base_w, h = 5);
            }
            translate([0,holder_arm_w/2,3])
                cylinder(d = holder_screw_d+2*FDM_offset, h = 15, $fn = 30);
            translate([0,holder_arm_w/2,0])
                cylinder(d = holder_nut_size+2*FDM_offset, h = 3, $fn = 6);
            
            translate([holder_arm_l+holder_base_w/2+syringe_d*clip_offset,
                       holder_arm_w/2,
                       0])  // clip contact surface
                cylinder(d = syringe_d+2*clip_wall, h = 10, $fn=30);
        }
    
        // syringe clip
        difference() {
            translate([holder_arm_l+holder_base_w/2+syringe_d*clip_offset,
                       holder_arm_w/2,
                       0])
                cylinder(d = syringe_d+2*clip_wall, h = 10, $fn=30);
            translate([holder_arm_l+holder_base_w/2+syringe_d*clip_offset,
                       holder_arm_w/2,
                       0])
                cylinder(d = syringe_d+2*FDM_offset, h = 10, $fn=30);
            translate([holder_arm_l+holder_base_w/2+syringe_d,
                       holder_arm_w/2,
                       0])
                cylinder(d = syringe_d+2*FDM_offset, h = 10, $fn=30);
        }
    }
}


HolderBase();

translate([0,20,0])
HolderClipArm();