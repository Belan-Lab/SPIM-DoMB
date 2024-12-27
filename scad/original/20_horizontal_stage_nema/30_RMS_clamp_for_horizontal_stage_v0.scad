//Objective arm for NEMA stage, RMS 

cube_win_side = 34.1;
cube_side = 49.8;
wall_th = (cube_side - cube_win_side)/2;

stage_w = 30;
stage_l = 96.9;
stage_box_h = 35;
stage_h = 28.5;

platform_w = 29.7;
platfotm_l = 32;
platform_h = cube_side - wall_th*2 - stage_h - 1;

optical_axis_l = cube_side/2 + (cube_side-wall_th-stage_h);
RMS_d = 20.32;

platform_arm_th = 7;
platform_arm_h = optical_axis_l + RMS_d/2+4;
platform_arm_l = platfotm_l + platform_arm_th;

FDM_offset = 0.15;


  module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
      }


module RMSClamp(){
    difference(){
        // main body
        translate([platform_arm_th/2,0,0]){
        union(){
            cube([platform_arm_l,platform_w,platform_h], center = true);
        
            translate([platform_arm_l/2-3,0,optical_axis_l/2 - platform_h/2])
                cube([platform_arm_th, platform_w, optical_axis_l], center = true);
            
            translate([platform_arm_l/2-3,0,optical_axis_l - platform_h/2])
            rotate([0,90,0])
                cylinder(d = platform_w, h = platform_arm_th, center = true, $fn = 2360);
            
            rotate([0,0,-90])
            translate([-7,10,platform_h/2])
                prism(14,3,20);
            }
            }
        // RMS hole    
        translate([10,0,optical_axis_l - platform_h/2])
        rotate([0,90,0])
            cylinder(d = RMS_d + FDM_offset, h = 40, center = true, $fn=360);   
        // mounting hole
        translate([-platfotm_l/2+6,10,0])
            cylinder(d = 2.7, h = 10, center = true, $fn = 60);
        translate([-platfotm_l/2+6,10,5])
            cylinder(d = 5.5, h = 10, center = true, $fn = 60);

        translate([-platfotm_l/2+6,-10,0])
            cylinder(d = 2.7, h = 10, center = true, $fn = 60);
        translate([-platfotm_l/2+6,-10,5])
            cylinder(d = 5.5, h = 10, center = true, $fn = 60);
            
        translate([platfotm_l/2-6,10,0])
            cylinder(d = 2.7, h = 10, center = true, $fn = 60);
        translate([platfotm_l/2-6,10,5])
            cylinder(d = 5.5, h = 10, center = true, $fn = 60);
            
        translate([platfotm_l/2-6,-10,0])
            cylinder(d = 2.7, h = 10, center = true, $fn = 60);
        translate([platfotm_l/2-6,-10,5])
            cylinder(d = 5.5, h = 10, center = true, $fn = 60);
    }
}

RMSClamp();