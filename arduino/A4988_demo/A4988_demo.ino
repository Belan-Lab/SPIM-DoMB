// stepper driver set up
const int stepPin = 2; 
const int dirPin = 3; 
const int qstepPin = 8;

void setup() {
  // initialize stepper pins
  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT); 
  pinMode(qstepPin,OUTPUT); 
}

void loop() {
  digitalWrite(dirPin,HIGH); // Enables the motor to move in a particular direction
  digitalWrite(qstepPin, LOW);
  // Makes 200 pulses for making one full cycle rotation
  for(int x = 0; x < 500; x++) {
    digitalWrite(stepPin,HIGH); 
    delay(1); 
    digitalWrite(stepPin,LOW); 
    delay(1); 
  }
  delay(1000); // One second delay
  
  digitalWrite(dirPin,LOW); //Changes the rotations direction
  digitalWrite(qstepPin, HIGH);
  // Makes 400 pulses for making two full cycle rotation
  for(int x = 0; x < 1000; x++) {
    digitalWrite(stepPin,HIGH);
    delay(1);
    digitalWrite(stepPin,LOW);
    delay(1);
  }
  delay(1000);
}
