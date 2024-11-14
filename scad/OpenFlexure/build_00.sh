#!/bin/bash
# Exit immediately if any command fails
set -e

mkdir -p builds
openscad -o builds/actuator_assembly_tools.stl openscad/actuator_assembly_tools.scad
openscad -o builds/base.stl openscad/base.scad
openscad -o builds/main_body.stl openscad/main_body.scad
openscad -o builds/moving_platform.stl openscad/moving_platform.scad
openscad -o builds/gears.stl openscad/gears.scad
openscad -o builds/small_gears.stl openscad/small_gears.scad

mkdir -p builds/accessories
openscad -o builds/accessories/CPS532_to_top_plate.stl openscad/accessories/CPS532_to_top_plate.scad
openscad -o builds/accessories/LED_to_top_plate.stl openscad/accessories/LED_to_top_plate.scad
openscad -o builds/accessories/rms_to_top_plate.stl openscad/accessories/rms_to_top_plate.scad
openscad -o builds/accessories/vertical_sample_clips.stl openscad/accessories/vertical_sample_clips.scad

# NB we first build the STL and put it in the *openscad* folder
openscad -o openscad/accessories/optics_module_rms_f50d13_nodovetail.stl openscad/accessories/optics_module_rms_f50d13_nodovetail.scad
# Now we build the microscope attachment
openscad -o builds/accessories/microscope_module.stl openscad/accessories/microscope_module.scad
