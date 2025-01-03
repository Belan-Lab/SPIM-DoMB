/* arduino.scad
 *
 * Copyright (C) Jestin Stoffel 2012
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

// Throughout this entire model, (0,0) is the top left mounting hole (nearest  the USB port)

// thickness of the PCB
board_height = 3;

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

module MountingHoles()
{
	translate([0, 0, -10])
	{
		ArduinoHole(25);
		translate([-1.0929112, -48.4026972, 0]) ArduinoHole(25);
		translate([51, -15.25, 0]) ArduinoHole(25);
		translate([51, -43.25, 0]) ArduinoHole(25);
	}
}

module ArduinoHole(length)
{
	color([0.7, 0.7, 0.7])
	cylinder(r=1.5, h=length, $fn=25);
}

module Arduino() {
    difference()
		{
			Board();
			MountingHoles();
            translate([5,-12,0])
                cube([50, 15, 3]);
            translate([5,-61.5,0])
                cube([50, 15, 3]);
            translate([-0.75,-45.5,1])
                cube([48.15, 32.3, 3]);
            translate([-0.75+1.5,-45.5+1.5,0])
                cube([48.15-3, 32.3-3, 3]);
		}
}

Arduino();