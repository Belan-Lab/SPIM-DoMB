// Nano CNC board with stepper lib and joystick control

// #include "A4988.h"
#include <Arduino.h>
#include "BasicStepperDriver.h"
#include "MultiDriver.h"
#include "SyncDriver.h"

// joystick set up
#define X_STICK A7
#define Y_STICK A6
#define J_CLICK 12

#define U_LIM 614
#define D_LIM 414

int xPos = 0;
int yPos = 0;
int bStt = 0;
int bSttLast = 0;
int bPress = 0;

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
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 
  
  pinMode(X_STICK, INPUT);
  pinMode(Y_STICK, INPUT);
  pinMode(J_CLICK, INPUT_PULLUP);

  pinMode(MOTOR_EN, OUTPUT);
  digitalWrite(MOTOR_EN, LOW);

  stepperX.begin(15., 1);
  stepperY.begin(15., 1);
  stepperZ.begin(15., 1);

  pinMode(MOTOR_EN, OUTPUT);
  digitalWrite(MOTOR_EN, HIGH);

}


void loop() {
  bState();

  xPos = analogRead(X_STICK);
  yPos = analogRead(Y_STICK);
  
  if (bPress == 0){
    xyMove();
  }
  else if (bPress == 1){
    zMove();
  }

  Serial.print("X: ");
  Serial.print(xPos);
  Serial.print(" | Y: ");
  Serial.print(yPos);
  Serial.print(" | Button: ");
  Serial.println(bPress);
}


void xyMove() {
  if ((xPos > U_LIM) && (yPos > U_LIM)){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(-10, 10, 0);
    }
  else if ((xPos < D_LIM) && (yPos < D_LIM)){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(10, -10, 0);
    }
  else if ((xPos < D_LIM) && (yPos > U_LIM)){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(10, 10, 0);
    }
  else if ((xPos > U_LIM) && (yPos < D_LIM)){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(-10, -10, 0);
    }
  else if (yPos < D_LIM){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(0, -10, 0);
    }
  else if (yPos > U_LIM){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(0, 10, 0);
    }
  else if (xPos < D_LIM){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(10, 0, 0);
    }
  else if (xPos > U_LIM){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(-10, 0, 0);
    }
}


void zMove() {
  if (yPos < D_LIM){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(0, 0, 10);
    }
  else if (yPos > U_LIM){
    digitalWrite(MOTOR_EN, LOW);
    delayMicroseconds(10);
    controller.rotate(0, 0, -10);
    }
}


void bState() {
  int bStt = digitalRead(J_CLICK);

  if (bStt == LOW && bSttLast == HIGH) {
    bPress = !bPress;
  }

  bSttLast = bStt;
}
