//Sample chamber

FDM_offset = 0.02;

chamber_side = 50;
chamber_h = 6;
chamber_wall = 2;

cuv_l = 26.38; 
cuv_w = 24.7;
cuv_h = 37.3;
cuv_wall = 1.5;

LED_d = 47.95;
LED_step = 2;
LED_hole = 35;
vertical_shift = 0.3;

module LEDSampleChamber (){
    union(){
    
    // base and LED arm
    difference(){
        union(){
        // chamber base
        difference(){
            translate([0,0,chamber_h/2])
                cube([chamber_side-2*FDM_offset,chamber_side-2*FDM_offset,6], center=true);
            translate([0,0,chamber_h/2+chamber_wall])
                cube([chamber_side-chamber_wall*2,chamber_side-chamber_wall*2,chamber_h], center=true);
        }
        // LED arm
            translate([-chamber_side/2+6/2,0,30/2])
                cube([6,chamber_side-2*FDM_offset,30], center=true);
        }
        
        // LED hole    
        rotate([0,90,0]){
        translate([-LED_d/2-vertical_shift,0,-50/2+4])
        cylinder(h=10, d=LED_hole, center=true, $fn=200);}
    
        // LED step
        rotate([0,90,0]){
        translate([-LED_d/2-vertical_shift,0,-(50/2-6-1)])
            cylinder(h=LED_step+4, d=LED_d, center=true, $fn=200);}
        }
        
    // cuvette mount
    difference(){
            translate([0,0,chamber_h/2])
                cube([cuv_l+2*cuv_wall,cuv_w+2*cuv_wall,6], center=true);
            translate([0,0,chamber_h/2])
                cube([cuv_l,cuv_w,6], center=true);         
        }
    }    
}

LEDSampleChamber();