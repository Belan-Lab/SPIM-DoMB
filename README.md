<p align="left">
<a href="#logo" name="logo"><img src="https://raw.githubusercontent.com/bionanoimaging/UC2-GIT/master/IMAGES/UC2_logo_text.png" width="400"></a>
</p>
[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct-single.svg)](https://stand-with-ukraine.pp.ua)

# openUC2 solutions for DoMB

Fork of [openUC2 Project](https://github.com/openUC2/UC2-GIT?tab=readme-ov-file)

This repo will contain hardware solutions and adaptations of original openUC2 parts/projects for our experimental work in the Department of Molecular Biophysics at Bogomoletz Institute of Physiology (Kyiv, Ukraine).

---

# Hardware
## C-mount adapter
Parametric model of a cube insert with C-mount thread (_c-mount_insert_v0.scad_).

__Model__
![](img/c-mount_cube_insert.png)

__Printed long insert__
![](img/c-mount_photo.jpg)

__Installed insert__
![](img/c-mount_in_cube.jpg)

##  LED/power cube V0
Parametric model of a cube insert with two LED dimmers and 12V output with type-C Power Delivery input (_led_power_insert_v0.scad_).

__Model__
![](img/led_power_cube_insert_v0.png)

Part|#|Cost/unit|Link
-|-|-|-
LED dimmer | 2x | $2.72   | [AliExpress](https://a.aliexpress.com/_EuX3DTP) 
PD decoy module 12V | 1x | $0.44   | [AliExpress](https://a.aliexpress.com/_Ezeg4Hf) 
Mini560 Pro Step Down to 3.3V| 1x | $0.81  | [AliExpress](https://a.aliexpress.com/_EJQFP5x) 
White LED 10W 3V (XML2) | 1x | $1.29  | [AliExpress](https://a.aliexpress.com/_EHBMyXT) 
460 nm LED 3W 3V (10 pc) | 1x | $1.94   | [AliExpress](https://a.aliexpress.com/_EI94HWN)
XT30 connector | 3x | $0.6  | [arduino.ua](https://arduino.ua/prod5276-xt30-konnektor-para-dlya-podklucheniya-li-po-li-ion-akkymylyatorov)

__Assembled power cube__
![](img/power_cube_close_up.jpg)

__Power cube with two LED cubes__
![](img/power_cube_connected.jpg)

__White 10W LED cube with radiator from northbridge__
![](img/white_led_front.jpg)

![](img/white_led_back.jpg)


## 25 mm filter holder V1
Sliding holder for standard 25 mm optical filters. The storage box for filter holders has mounting holes for standard M6 25mm spacing optical board.

__Model__
![](img/filter_insert_v1_scad.png)

Assembled filter cube             | Filter cube with filter holders and holders storage box 
:-------------------------:|:-------------------------:
![](img/filter_insert_v1_assembled.jpg) | ![](img/filter_insert_v1_full_set.jpg)


## Servo stage for light-sheet V1
The holder was adapted to install a plastic photometric cuvette for sample mounting.

__Model__
![](img/servo_stage_v1_scad.png)
_Inclides openSCAD library "Bibliothek für Evolventen-Zahnräder, Schnecken und Zahnstangen" (gear.scad)_

__Assembled cube__
![](img/servo_stage_v1_side.jpg)

![](img/servo_stage_v1_top.jpg)

## 5X Laser beam expander V0

__Model__
![](img/beam_expander_v0_scad.png)

Part|#|Cost/unit|Link
-|-|-|-
Acrilic LED lens, F22 D20.8 | 1x | $1.35 | [AliExpress](https://a.aliexpress.com/_EHJOUo1) 
iPhone 4S lens, F3.85 | 1x |  -  |  

## RGB laser module V0

Module for mounting and control with Arduino of the RGB laser LED module.

Part|#|Cost/unit|Link
-|-|-|-
RGB laser module | 1x | $19.5 | [AliExpress](https://a.aliexpress.com/_EHowiiN)
Arduino Nano type-C | 1x | $2.13 | [AliExpress](https://a.aliexpress.com/_EwrjzyD) 
Arduino Nano expansion board | 1x | $0.94 | [AliExpress](https://a.aliexpress.com/_EyNqegd) 
PD decoy module 12V | 1x | $0.44 | [AliExpress](https://a.aliexpress.com/_Ezeg4Hf) 

### RGB laser trigger board modification
The original diode bridge on the RBG laser trigger board (circled in red) was replaced with two jumpers for the DC power supply only, and the original trigger connectors were replaced with 2.54 mm pin headers.

Original board             |  Modified board
:-------------------------:|:-------------------------:
![](img/rgb_board.jpg) | ![](img/rgb_board_fin.jpg)

### Nano expansion board modification
The expansion board's original DC connector (circled in red) was replaced with a PD trigger module for power supply with a power delivery source (AC adapter, power bank, etc.).

Original board (top)            |  Modified board (top)
:-------------------------:|:-------------------------:
![](img/nano_board.jpg) | ![](img/nano_board_fin.jpg)

Arduino pin 2 was pulled up with a 1K resistor to the 5V (circled in red) for connection to the passive trigger output of the Point Grey Grasshopper 3 camera (trigger output - pin 2, gnd - pin 6). The male XT30 connector for an optional power supply from the LED/power cube was soldered to the power input. 

Original board (bottom)            | Modified board (bottom) 
:-------------------------:|:-------------------------:
![](img/nano_board_bott.jpg) | ![](img/nano_board_bott_fin.jpg) 

### Assembled control module
Lasers power supply is provided through an arduino Vin pin.

TTL inputs of the RGB laser trigger board  was connected to the next arduino pins:

- __650 nm__ - 8
- __520 nm__ - 9
- __450 nm__ - 10

Trigger board holder  | Assembled module 
:-------------------------:|:-------------------------:
![](img/arduino_mount.png) | ![](img/rgb_module_side.jpg) 

For arduino operating details see [Step-by-step to controlling multiple light sources with an Arduino](https://github.com/nimwegenLab/MiM_NikonTi/blob/master/Docs/NikonTi_hardware_triggering.m).

---

# Software
All control is provided with [Micro-Manager](https://micro-manager.org/) and [pymmcore-plus](https://pymmcore-plus.github.io/pymmcore-plus/) library with [napari-micromanager](https://pymmcore-plus.github.io/napari-micromanager/) GUI.

__Configuration__
Component | Desctiption | Micro-manager adapter
- | - | -
Camera | FLIR Grasshopper3 USB3 | [Point Grey Research](https://micro-manager.org/Point_Grey_Research)
Stage | Servo stage | [CustomArduino](https://micro-manager.org/CustomArduino) (MarzhauserLStep Z-stage)
Laser | RGB laser control wtih TTL | [Arduino](https://micro-manager.org/Arduino)

_Note: AnswerTimeout property for the servo stage was set to 5000.000_

---

# Useful links

- [Grasshopper3 USB 3.1 manual, PDF](https://www.physics.utoronto.ca/apl/fvf/GS3-U3-Technical-Reference.pdf)
- [Step-by-step to controlling multiple light sources with an Arduino for sequenceable MDA by Guillaume Witz & Thomas Julou](https://github.com/nimwegenLab/MiM_NikonTi/blob/master/Docs/NikonTi_hardware_triggering.m)