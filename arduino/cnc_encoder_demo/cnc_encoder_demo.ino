// example vor Nano CNC board, X-axis control with encoder

#include <Encoder.h>
#include <Pushbutton.h>
#include "A4988.h"

// stepper driver set up
const int XstepPin = 5;    // X-axis step pin
const int XdirPin = 2;     // X-axis dir pin
const int EnPin = 8;       // Drivers enable pin
const int stepDelay = 500;

// encoder set up
Encoder zEnc(13,12);         // encoder CLC and DT pins
const int stepsPerTick = 10;

long Eposition  = 0;
long EpositionNew = 0;
long EpositionDiff = 0;


void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 
  
  // initialize stepper pins
  pinMode(XstepPin,OUTPUT);
  digitalWrite(XstepPin,LOW);
   
  pinMode(XdirPin,OUTPUT);
  digitalWrite(XdirPin,LOW);
   
  pinMode(EnPin,OUTPUT); 
  digitalWrite(EnPin, HIGH);
}


void loop() {
  EpositionNew = zEnc.read()/2; 
  Serial.println(EpositionNew);

  if (EpositionNew != Eposition){
    Eposition = EpositionNew;
    EpositionDiff = EpositionNew - Eposition;
    }
  else {
    EpositionDiff = 0;
  }

  if (EpositionDiff != 0){
    if (EpositionDiff > 0){
      step_clock();
      }
    else{
      step_clock();
    }
  }    
}


void step_clock(){
  digitalWrite(EnPin, LOW);
  delay(2);
    
  digitalWrite(XdirPin,LOW);
  for(int x = 0; x < stepsPerTick; x++){
    digitalWrite(XstepPin,HIGH);
    delayMicroseconds(stepDelay);
    digitalWrite(XstepPin,LOW);
    delayMicroseconds(stepDelay);
  }
  
  digitalWrite(EnPin, HIGH);
}
