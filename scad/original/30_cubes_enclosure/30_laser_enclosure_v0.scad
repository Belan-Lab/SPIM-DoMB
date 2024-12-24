// Cubes enclosure, emission light path. DoMB SPIM
// Borys Olifirov 2024

FDM_offset = 0.2;

enc_w = 65;
enc_h = 65;
enc_l = 200;

wall_t = 1.5;

port_d = 15;

p_h = 9;


module EmEnclosure() {
    union() {
        // enclosure walls
        // side and top walls
        difference() {
            cube([enc_w+2*wall_t,enc_l,enc_h+wall_t], center = true);
            translate([0,0,-wall_t])
                cube([enc_w,enc_l,enc_h], center = true);
            
            // wires port
            translate([-enc_w/2,enc_l/2-port_d/2-25,-(enc_h/2+4*FDM_offset)])
            rotate([90,0,90])
                cylinder(d = port_d+2*FDM_offset,
                         h = 40,
                         center = true, $fn=30);
        }
        difference() {
            // rare wall
            translate([0,enc_l/2-wall_t/2,0])
                cube([enc_w+wall_t,wall_t,enc_h+wall_t], center = true);
        }
    }
}

EmEnclosure();