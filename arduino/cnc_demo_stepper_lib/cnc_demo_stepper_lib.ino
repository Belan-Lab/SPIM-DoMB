// example vor Nano CNC board with stepper lib

// #include "A4988.h"
#include <Arduino.h>
#include "BasicStepperDriver.h"
#include "MultiDriver.h"
#include "SyncDriver.h"

// steppers set up
#define X_STEP 5         // X-axis step pin  X-5, Y-6. Z-7 
#define X_DIR 2          // X-axis dir pin   X-2, Y-3. Z-4 

#define Y_STEP 6         // Y-axis step pin  X-5, Y-6. Z-7 
#define Y_DIR 3          // y-axis dir pin   X-2, Y-3. Z-4 

#define Z_STEP 7         // Z-axis step pin  X-5, Y-6. Z-7 
#define Z_DIR 4          // z-axis dir pin   X-2, Y-3. Z-4 

#define MOTOR_EN 8       // drivers enable pin

#define MOTOR_STEPS 2047  // steps per revolution

BasicStepperDriver stepperX(MOTOR_STEPS, X_DIR, X_STEP);
BasicStepperDriver stepperY(MOTOR_STEPS, Y_DIR, Y_STEP);
BasicStepperDriver stepperZ(MOTOR_STEPS, Z_DIR, Z_STEP);

SyncDriver controller(stepperX, stepperY, stepperZ);

int rotate = 360;

void setup() {
  stepperX.begin(20., 1);
  stepperY.begin(20., 1);
  stepperZ.begin(20., 1);

  pinMode(MOTOR_EN, OUTPUT);
  digitalWrite(MOTOR_EN, LOW);
}

void loop() {
  controller.rotate(rotate, rotate, rotate);

  delay(200);

  controller.rotate(-rotate, -rotate, -rotate);

  delay(200);
}