// example vor Nano CNC board

// stepper driver set up
const int XstepPin = 5;    // X-axis step pin  X-5, Y-6. Z-7 
const int XdirPin = 2;     // X-axis dir pin   X-2, Y-3. Z-4 

const int YstepPin = 6;    // Y-axis step pin  X-5, Y-6. Z-7 
const int YdirPin = 3;     // y-axis dir pin   X-2, Y-3. Z-4 

const int ZstepPin = 7;    // Z-axis step pin  X-5, Y-6. Z-7 
const int ZdirPin = 4;     // z-axis dir pin   X-2, Y-3. Z-4 

const int EnPin = 8;       // Drivers enable pin

void setup() {
  // initialize stepper pins
  pinMode(XstepPin,OUTPUT); 
  pinMode(XdirPin,OUTPUT);

  pinMode(YstepPin,OUTPUT); 
  pinMode(YdirPin,OUTPUT);

  pinMode(ZstepPin,OUTPUT); 
  pinMode(ZdirPin,OUTPUT);
   
  pinMode(EnPin,OUTPUT); 
  digitalWrite(EnPin, HIGH);
}

void loop() {
  digitalWrite(EnPin, LOW);
  delay(1);

  digitalWrite(XdirPin,LOW);
  digitalWrite(YdirPin,LOW);
  digitalWrite(ZdirPin,LOW);
  for(int x = 0; x < 2000; x++) {
    digitalWrite(XstepPin,HIGH);
    digitalWrite(YstepPin,HIGH);
    digitalWrite(ZstepPin,HIGH);
    delayMicroseconds(800);
    digitalWrite(XstepPin,LOW);
    digitalWrite(YstepPin,LOW);
    digitalWrite(ZstepPin,LOW);
    delayMicroseconds(800);
  }
  
  digitalWrite(EnPin, HIGH);
  
  delay(500);

  digitalWrite(EnPin, LOW);
  delay(1);

  digitalWrite(XdirPin,HIGH);
  digitalWrite(YdirPin,HIGH);
  digitalWrite(ZdirPin,HIGH);
  for(int x = 0; x < 2000; x++) {
    digitalWrite(XstepPin,HIGH);
    digitalWrite(YstepPin,HIGH);
    digitalWrite(ZstepPin,HIGH);
    delayMicroseconds(800);
    digitalWrite(XstepPin,LOW);
    digitalWrite(YstepPin,LOW);
    digitalWrite(ZstepPin,LOW);
    delayMicroseconds(800);
  }
  digitalWrite(EnPin, HIGH);
delay(500);
  
}
