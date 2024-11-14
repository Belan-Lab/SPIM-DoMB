// NB this file WILL NOT WORK unless you also have the microscope source code.
// The quickest way to get this is to download:
// https://gitlab.com/openflexure/openflexure-microscope/-/archive/v7.0.0-beta1/openflexure-microscope-v7.0.0-beta1.zip
// and unzip it into ../../../openflexure-microscope.  This means you will
// have a folder called openflexure-microscope in the same directory as the
// folder containing this repo (openflexure-block-stage).  This was last done using
// v7.0.0-beta1 which is why the link above references that version.

// This file is more or less identical to openscad/rms_optics_module.scad but with
// use paths corrected and include_wedge=false.

use <../../../openflexure-microscope/openscad/libs/lib_optics.scad>
use <../../../openflexure-microscope/openscad/libs/optics_configurations.scad>
use <../../../openflexure-microscope/openscad/libs/microscope_parameters.scad>

//These parameters can be overwritten here or from command line with -D
OPTICS = "rms_f50d13";
BEAMSPLITTER = false;
CAMERA = "picamera_2";
PARFOCAL_DISTANCE = 45;

configurable_optics_module(OPTICS, CAMERA, BEAMSPLITTER, PARFOCAL_DISTANCE);

module configurable_optics_module(optics, camera_type, beamsplitter, parfocal_distance){
    params = default_params();
    // 45mm is the default parfocal distance.
    // If this setting is changed, it would normally be to 35mm.
    // The code below will print a warning if it is changed.
    if (parfocal_distance!=45){
        if (parfocal_distance==35){
            echo("Generating an optics module for older, 35mm parfocal, objectives.  Please check carefully, this option is not tested.");
        }
        else {
            echo("WARNING: parfocal_distance is neither 35mm nor 45mm, this may be an error.");
        }
    }

    // Note calling the optics module rms inside each if statment
    // to avoid nested ternaries
    if (optics=="rms_f50d13"){
        optics_config = rms_f50d13_config(
            camera_type=camera_type, 
            beamsplitter=beamsplitter, 
            parfocal_distance=parfocal_distance
        );
        optics_module_rms(params, optics_config, include_wedge=false);
    }
    else if(optics=="rms_infinity_f50d13"){
        optics_config = rms_infinity_f50d13_config(
            camera_type=camera_type, 
            beamsplitter=beamsplitter, 
            parfocal_distance=parfocal_distance
        );
        optics_module_rms(params, optics_config, include_wedge=false);
    }
    else{
        assert(false, "Unknown optics configuration specified");
    }

}
