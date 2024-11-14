// Cubes enclosure, emission light path. DoMB SPIM
// Borys Olifirov 2024

FDM_offset = 0.2;

enc_w = 65;
enc_h = 65;
enc_l = 180;

wall_t = 1.5;

camera_d = 28;
camera_shift = 8;


module EmEnclosure() {
    union() {
        difference() {
            cube([enc_w+2*wall_t,enc_l,enc_h+wall_t], center = true);
            translate([0,0,-wall_t])
                cube([enc_w,enc_l,enc_h], center = true);
        }
        difference() {
            translate([0,enc_l/2-wall_t/2,0])
                cube([enc_w+wall_t,wall_t,enc_h+wall_t], center = true);
            translate([0,enc_l/2,camera_shift])
            rotate([90,0,0])
                cylinder(d = camera_d+2*FDM_offset,
                         h = 40,
                         center = true);
            translate([0,enc_l/2,-enc_h/4+camera_shift/2-wall_t/2])
                cube([camera_d+2*FDM_offset,
                      40,
                      enc_h/2+camera_shift+2*FDM_offset],
                     center = true);
        }
    }
}

EmEnclosure();