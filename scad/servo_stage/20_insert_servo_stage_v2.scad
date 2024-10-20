// IN PROGRESS

include <gears.scad>

// INSERT PARAMS
/* [Hiden] */
a = 49.8;
b = 33.6;
c = 6.28;
d = 53.8;
h = 5; //holder height
IM_offset = 0.2;

servo_w = 10.75;
servo_l = 18.7;
servo_h = 7.8;

// GEAR PARAMS
width = 10.0; // 0.01
teeth_1st = 12;
teeth_2nd = 30;
bore = 3.8; // 0.01
straight = true;

/* [Advanced Parameters] */
hub = false;
hub_diameter = 6; // 0.01
hub_thickness = 5; // 0.01
// (Weight optimization if applicable)
optimized = true;
pressure_angle = 20; // 0.01
helix_angle = 30; // 0.01
clearance = 0.05; // 0.01

/* [Rack parameters] */
rack_l = 70; // 0.01
rack_h = 2; // 0.01

/* [Multi-gear configurations] */
idler_teeth = 36;
idler_bore = 3; // 0.01
assembled = false;

// rack rail params

platform_h = 5;
sample_s = 11.75;
sample_h = 10;
rail_width = sample_s + 6;

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

module RackRail () {
    translate([0,40,platform_h/2])
    
    union() {
        difference() {
            union() {
                translate([rail_width/4,0,0])
                 cube([rack_l+rail_width/2,
                       rail_width,
                       platform_h], center=true);
        
                translate([rack_l/2+rail_width/2,
                           0,
                           0])
                  cylinder(platform_h, d=rail_width, center=true);
                }
        
            translate([rack_l/2+sample_s/2+1,
                       0,
                       sample_h/4+1.5])
              cube([sample_s+2*IM_offset,
                    sample_s+2*IM_offset,
                    sample_h], center=true);
            }
            
        translate([0,
                   rail_width/2,
                   platform_h/2+1.1])
        rotate([90,0,0])

          zahnstange(
              modul=Module, 
              laenge=rack_l-1.5, 
              hoehe=rack_h, 
              breite=rail_width,
              eingriffswinkel=pressure_angle,
              schraegungswinkel=finalHelixAngle);
        
        }
    }
    
module ServoGear() {
    translate([0,65,0])
    
    stirnrad (
        modul=Module,
        zahnzahl=teeth_1st,
        breite=width,
        bohrung=bore,
        nabendurchmesser=final_hub_diameter,
        nabendicke=final_hub_thickness,
        eingriffswinkel=pressure_angle,
        schraegungswinkel=-finalHelixAngle, 
        optimiert=optimized);
    }


module SecondGear() {
    translate([0,100,0])
    
    stirnrad (
        modul=Module,
        zahnzahl=teeth_2nd,
        breite=rail_width,
        bohrung=bore,
        nabendurchmesser=final_hub_diameter,
        nabendicke=final_hub_thickness,
        eingriffswinkel=pressure_angle,
        schraegungswinkel=finalHelixAngle, 
        optimiert=optimized);
    }


module ServoInsert() {
    union(){
      CubeInsert();
        
      // insert extension
      translate([25,0,h/2])
        union() {
            cube([30,b+2*IM_offset,h], center=true);
            
            translate([14,0,0])
              cylinder(h, d=b+2*IM_offset, center=true);
            }
            
      // rail sides
      translate([-47/2-1.5,rail_width/2+2*IM_offset,h])
        cube([50,2,7]);
        
      translate([-47/2-1.5,-(rail_width/2+2*IM_offset+2),h])
        cube([50,2,7]);
      
      // servo holder  
      translate([-17,
                 -(servo_w+rail_width/2+IM_offset+5),
                 h])
        union(){  
          translate([0,
                     0,
                     0])
            cube([18.7+2*IM_offset+3,
                  servo_w,
                  (teeth/2)-(servo_h/2)+platform_h+2*IM_offset]);
        
          translate([servo_l+2*IM_offset+3,
                     4,
                     0])
            cube([3,
                  servo_w-4,
                  (teeth/2)-(servo_h/2)+platform_h+IM_offset+servo_h]);
          
          translate([0,
                     0,
                     0])
            cube([3,
                  servo_w,
                  (teeth/2)-(servo_h/2)+platform_h+IM_offset+servo_h]);        
        } 
      }
    }

ServoInsert();

RackRail();

SecondGear();
    
ServoGear();

//
//zahnstange_und_rad (
//    modul=Module,
//    laenge_stange=rack_l,
//    zahnzahl_rad=teeth,
//    hoehe_stange=rack_h,
//    bohrung_rad=bore, breite=width,
//    nabendicke=final_hub_thickness,
//    nabendurchmesser=final_hub_diameter,
//    eingriffswinkel=pressure_angle,
//    schraegungswinkel=finalHelixAngle,
//    zusammen_gebaut=assembled,
//    optimiert=optimized);