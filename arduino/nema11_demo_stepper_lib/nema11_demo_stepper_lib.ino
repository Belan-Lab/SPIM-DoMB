// example vor NEMA11 linear stege with stepper lib

// #include "A4988.h"
#include <Arduino.h>
#include "BasicStepperDriver.h"

#define STEP 2
#define DIR 3
#define EN 4
#define M_STEPS 200

BasicStepperDriver stepper(M_STEPS, DIR, STEP);

void setup() {
  stepper.begin(180.,1);

  pinMode(EN, OUTPUT);
  digitalWrite(EN, HIGH);
}

void loop() {
  digitalWrite(EN, LOW);
  delay(1);
  stepper.rotate(360*10);
  digitalWrite(EN, HIGH);
  delay(500);

  digitalWrite(EN, LOW);
  delay(1);
  stepper.rotate(-360*10);
  digitalWrite(EN, HIGH);
  delay(500);
}
