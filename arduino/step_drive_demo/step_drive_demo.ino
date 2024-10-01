#include <Encoder.h>
#include <Pushbutton.h>

// joystick set up
const int JxPin = A6;     // joystick X axis pin
const int JyPin = A7;     // joystick Y axis pin
Pushbutton Jbutton(4);    // joystick button pin

int JxPosition = 0;
int JyPosition = 0;

// encoder set up
Encoder zEnc(7,6);       // encoder CLC and DT pins
Pushbutton Ebutton(5);    // encoder button pin

long Eposition  = 0;
long EpositionNew = 0;

// stepper driver set up
const int stepPin = 2;    // A4988 step pin
const int dirPin = 3;     // A4988 dir pin
const int qstepPin = 8;   // A4988 MS2 pin
const int dsleepPin = 9;  // A4988 sleep pin

const int stepDelayL = 400;
const int stepDelayH = 50;

byte qstepState = LOW;
bool isMoove = false;
int stepDelay = stepDelayL;

bool jOrE = false;

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 

  // initialize j pins 
  pinMode(JxPin, INPUT);
  pinMode(JyPin, INPUT);
  // pinMode(JbuttonPin, INPUT_PULLUP); 

  // initialize stepper pins
  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT); 
  pinMode(qstepPin,OUTPUT); 
  pinMode(dsleepPin,OUTPUT); 

  digitalWrite(qstepPin, LOW);
  digitalWrite(dsleepPin, LOW);
}

void loop(){
  JxPosition = analogRead(JxPin);
  JyPosition = analogRead(JyPin);

  if (Jbutton.getSingleDebouncedPress() or Ebutton.getSingleDebouncedPress()) {
    if (qstepState == LOW) {
      qstepState = HIGH;
      stepDelay = stepDelayH;
      digitalWrite(qstepPin, qstepState);
    }
    else if (qstepState == HIGH) {
      qstepState = LOW;
      stepDelay = stepDelayL;
      digitalWrite(qstepPin, qstepState);
    }
   }
   
  EpositionNew = zEnc.read(); 
  Serial.println(EpositionNew);

  if (JxPosition > 767 or JyPosition > 767 or JxPosition < 255 or JyPosition < 255 or EpositionNew != Eposition) {
    if (isMoove == false) {
        digitalWrite(dsleepPin, HIGH);
        delay(3);
        isMoove = true;
      } else {
        if (EpositionNew != Eposition) {
          move_enc();
        } else{
          move_joy();
        }
      }
    } else {
      digitalWrite(dsleepPin, LOW);
      isMoove = false;
    }
}

void move_enc() {
  long EpositionDiff = EpositionNew - Eposition;
  Eposition = EpositionNew;
  Serial.println(EpositionDiff);
  if (EpositionDiff > 0) {
    move_clocwise();
  }
  if (EpositionDiff < 0) {
    move_contrclocwise();
  }
}

void move_joy() {
  if (JxPosition > 767 or JyPosition > 767) {
    move_clocwise();
  } 
  if (JxPosition < 255 or JyPosition < 255) {
    move_contrclocwise();
  }
}

void move_clocwise() {
  digitalWrite(dirPin,LOW);
  for(int x = 0; x < 10; x++) {
    digitalWrite(stepPin,HIGH);
    delayMicroseconds(stepDelay);
    digitalWrite(stepPin,LOW);
    delayMicroseconds(stepDelay);
  }
}

void move_contrclocwise(){
  digitalWrite(dirPin,HIGH);
  for(int x = 0; x < 10; x++) {
    digitalWrite(stepPin,HIGH);
    delayMicroseconds(stepDelay);
    digitalWrite(stepPin,LOW);
    delayMicroseconds(stepDelay);
  }
}