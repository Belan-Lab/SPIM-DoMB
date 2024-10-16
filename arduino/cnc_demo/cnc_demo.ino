// example vor Nano CNC board, for X-axis only 

// stepper driver set up
const int XstepPin = 5;    // X-axis step pin
const int XdirPin = 2;     // X-axis dir pin

const int EnPin = 8;       // Drivers enable pin

void setup() {
  // initialize stepper pins
  pinMode(XstepPin,OUTPUT); 
  pinMode(XdirPin,OUTPUT);
   
  pinMode(EnPin,OUTPUT); 
  digitalWrite(EnPin, HIGH);
}

void loop() {
  digitalWrite(XdirPin,LOW);
  
  digitalWrite(EnPin, LOW);
  delay(1);
  for(int x = 0; x < 2000; x++) {
    digitalWrite(XstepPin,HIGH);
    delayMicroseconds(50);
    digitalWrite(XstepPin,LOW);
    delayMicroseconds(50);
  }
  digitalWrite(EnPin, HIGH);
  delay(1);
  delay(500);

  digitalWrite(EnPin, LOW);
  delay(1);
  for(int x = 0; x < 2000; x++) {
    digitalWrite(XstepPin,HIGH);
    delayMicroseconds(100);
    digitalWrite(XstepPin,LOW);
    delayMicroseconds(100);
  }
  digitalWrite(EnPin, HIGH);
  delay(1);
  delay(500);

  digitalWrite(EnPin, LOW);
  delay(1);
  for(int x = 0; x < 2000; x++) {
    digitalWrite(XstepPin,HIGH);
    delayMicroseconds(1000);
    digitalWrite(XstepPin,LOW);
    delayMicroseconds(1000);
  }
  digitalWrite(EnPin, HIGH);
  delay(1);
  delay(2000);
}
