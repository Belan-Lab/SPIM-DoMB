// Cubes enclosure, emission light path. DoMB SPIM
// Borys Olifirov 2024

FDM_offset = 0.2;

enc_w = 65;
enc_h = 65;
enc_l = 180;
wall_t = 1.5;

clip_l = 10;
clip_t = 3;
clip_offset = 0.25;

foot_l = 30;
s_d = 6.1;

module EnclosureClip() {
    union() {
        difference() {
            cube([enc_w+2*wall_t+2*clip_offset+2*clip_t,
                  clip_l,
                  enc_h+wall_t+clip_t+clip_offset],
                 center = true);
            translate([0,0,-wall_t])
                cube([enc_w+2*wall_t+clip_offset,
                      enc_l/5,
                      enc_h+wall_t+clip_offset], center = true);
        }
        difference() {
            // right foot            
            translate([(enc_w+2*wall_t+2*clip_offset+2*clip_t)/2 + foot_l/2,
                       0,
                      -(enc_h+wall_t+clip_t+clip_offset)/2+clip_t/2])
                cube([foot_l,clip_l,clip_t], center = true);
            translate([(enc_w+2*wall_t+2*clip_offset+2*clip_t)/2+s_d/2+(5+FDM_offset),
                       0,
                       -enc_h/2])
                cylinder(d = s_d, h = 30, center = true);
            translate([(enc_w+2*wall_t+2*clip_offset+2*clip_t)/2+s_d/2+(5+FDM_offset+100/2),
                       0,
                       -enc_h/2])
                cube([100,s_d,30], center = true);
        }
        
        difference() {
            // left foot            
            translate([-(enc_w+2*wall_t+2*clip_offset+2*clip_t)/2 - foot_l/2,
                       0,
                      -(enc_h+wall_t+clip_t+clip_offset)/2+clip_t/2])
                cube([foot_l,clip_l,clip_t], center = true);
            translate([-(enc_w+2*wall_t+2*clip_offset+2*clip_t)/2-s_d/2-(5+FDM_offset),
                       0,
                       -enc_h/2])
                cylinder(d = s_d, h = 30, center = true);
            translate([-(enc_w+2*wall_t+2*clip_offset+2*clip_t)/2-s_d/2-(5+FDM_offset+100/2),
                       0,
                       -enc_h/2])
                cube([100,s_d,30], center = true);
        }
    }
}

EnclosureClip();