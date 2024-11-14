# Print the plastic parts

{{BOM}}

## Confiugure your printer {pagestep}

This project is designed to print on a RepRap-style fused filament printer.  Anything that uses PLA filament will generally be OK, we typically use a Prusa i3 or Prusa Mini in our lab, though have also used Ultimaker 2+.  Usually it's fine to stick with the default settings, though we tend to favour thicker layers (around 0.2mm) and faster print speeds (i.e. we often go for "speed" rather than "quality" presets).  This results in a rougher appearance, but often stronger parts.  The best values will depend on your printer, but we typically use an 0.4mm nozzle, printing at 40mm/s for perimeters and 80mm/s for infill.  Bridges may be printed slightly slower (30mm/s): these are all defaults from our printer.

The most important thing is not to use support material.  The mechanism inside the main body of the stage is complicated, and has been very carefully designed to print without supports.  If you use support material, it will most likely foul the mechanism, and will probably be impossible to remove.  If the bridging inside the main body is a problem (i.e. if there is debris underneath the moving part of the stage), you can use a needle file inserted through the slots at the side of the body to clean it up. It doesn't need to be aesthetically perfect, just provide enough clearance that it doesn't rub on the platform below.

>! **Do not use support material**
>!
>! If you use support material, it will most likely be impossible to remove without damaging the mechanism.  There are many "bridges" inside the main body, to form the mechanism.  These should print fine on most desktop 3D printers without any support.

It may be helpful to use a brim to ensure good adhesion to the print bed.  If your slicer puts the brim around the outside only, this should be relatively simple to remove.  If the brim is generated inside the main body, it may foul the mechanism, and can be quite tricky to remove.

You should print the parts, especially the main body, in the orientation given in the STL files, i.e. the Z axis points upwards.  Printing in other orientations is unlikely to work properly, as we treat horizontal and vertical directions quite differently when designing the parts.

If you want to try a test print first, the [OpenFlexure Microscope test print](https://build.openflexure.org/openflexure-microscope/v7.0.0-beta1/high_res_microscope/test_your_printer.html) is a good place to start.

## Print the parts {pagestep}

You will need to use a [RepRap-style fused filament 3D printer]{cat:Tool, qty:1} and some [PLA filament]{qty:250 grams} to produce the following parts (1 of each file):

* [base]{output,qty:1}: [base.stl](models/base.stl){previewpage}
* [main body]{output,qty:1}: [main_body.stl](models/main_body.stl){previewpage}
* [moving platform]{output,qty:1}: [moving_platform.stl](models/moving_platform.stl){previewpage}
* [large gears]{output,qty:3}: [gears.stl](models/gears.stl){previewpage}
* [actuator assembly tools]{output,qty:1}: [actuator_assembly_tools.stl](models/actuator_assembly_tools.stl){previewpage}
* [small gears]{output,qty:3}: [small_gears.stl](models/small_gears.stl){previewpage} (only if using motors)

You can [download all of the STLs as a single zipfile](block-stage-main-stls.zip){zip, pattern:"*.stl"}
