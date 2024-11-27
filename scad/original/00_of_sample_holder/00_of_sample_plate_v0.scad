// Sample plete for OpenFlexure Block Stage saple holder. DoMB SPIM
// Borys Olifirov 2024

FDM_offset = 0.2;

stick_d = 6;
stick_l = 80;

plate_w = 10;
plate_l = 25;
plate_h = 1.25;


 module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
      }

module SamplePlate() {
    union() {
        // plate
        translate([0,0,plate_h/2])
            cube([plate_l, plate_w, plate_h], center = true);
        
        // plate to stick adapter
        intersection() {
            rotate([0,0,90])
            translate([-plate_w/2,plate_l/2-5,0])
                prism(l = plate_w, w = 5, h = stick_d);
            union() {
                translate([-(plate_l/2-10),0,stick_d/4])
                    cube([20,stick_d,stick_d/2], center = true);
                rotate([0,90,0])
                translate([-stick_d/2,0,-10])
                    cylinder(d = stick_d, h = 20, center = true, $fn = 45);
                }
            }
        
        // stick
        rotate([0,90,0])
        translate([-stick_d/2,0,-(stick_l/2+plate_l/2)])
            cylinder(d = stick_d, h = stick_l, center = true, $fn = 45);
    }
}


SamplePlate();