// thickness of the PCB
board_height = 5;

// solid_holes - specifies if mounting holes should be added to or subtracted from the model
// combined_headers - specifies if space should be left between adjacent female headers, or if they should be rendered as a single header
// extend_ports - extends the USB and power ports by a centimeter, so that holes are more easily made when a model is used as a negative

module Board()
{
	color([0, 0.6, 0.8])
	linear_extrude(height = board_height, convexity = 10, twist = 0)
	{
		polygon( points = [ [-4.115, 2.545],
						[49.4, 2.545],
						[50.925, 1.021],
						[50.925, -10.409],
						[53.465, -12.949],
						[53.465, -45.715],
						[50.925, -48.255],
						[50.925, -50.795],
						[-4.115, -50.795] ],
				paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8]],
				convexity = 10);
	}
}

module ArduinoMount() {
    difference() {
        scale([1.2,1.2,2])
            Board();
        translate([7,-7,0])
        scale([0.9,0.9,2])
            Board();
        translate([5,-5,8])
            Board();
        
        translate([52,-3.5,2])
            cylinder(d = 10.25,h = 20);
        translate([52,-3.5,0])
            cylinder(d = 6,h = 20);
        translate([2,-3.5,2])
            cylinder(d = 10.25,h = 20);
        translate([2,-3.5,0])
            cylinder(d = 6,h = 20);
        
        translate([-10,-50.5,4])
            cube([40,40,10]);
        translate([5.5,-70,4])
            cube([45,40,10]);
        translate([41,-50.5,4])
            cube([45,32,10]);
    }
}

ArduinoMount();