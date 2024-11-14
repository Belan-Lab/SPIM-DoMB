#!/bin/bash
# Exit immediately if any command fails
set -e

mkdir -p builds
openscad -o builds/base.stl openscad/base.scad
openscad -o builds/main_body.stl openscad/main_body.scad
# openscad -o builds/moving_platform.stl openscad/moving_platform.scad
# openscad -o builds/gears.stl openscad/gears.scad
# openscad -o builds/small_gears.stl openscad/small_gears.scad
