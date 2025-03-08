// Light path tube. DoMB SPIM
// Borys Olifirov 2025

tube_h = 50;
tube_id = 25.4;  //1.35

wall_w = 1.5;
wall_tol = 0.06;
slit_gap = 0.05;
$fn = 100;

module TubeEnclosure() {
    difference() {
        cylinder(d = tube_id+(wall_w-wall_tol)*2, h = tube_h, center = true);
        cylinder(d = tube_id, h = tube_h+2, center = true);
        translate([10,0,0])
            cube([tube_id, slit_gap, tube_h+4], center = true);
        
    }
}

TubeEnclosure();