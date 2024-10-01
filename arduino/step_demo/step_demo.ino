// set pins
const int a1 = 2;     
const int a2 =  3;
const int b1 =  4;
const int b2 =  5;

const int xPin = A1;
const int yPin = A0;
const int buttonPin = 6;

// cet const
const int step_delay = 1;
const int inter_step_delay = 7;

// set init vals
int xPosition = 0;
int yPosition = 0;
int buttonState = 0;


void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 

  // initialize j pins 
  pinMode(xPin, INPUT);
  pinMode(yPin, INPUT);
  pinMode(buttonPin, INPUT_PULLUP); 


  // initialize stepper pins
  pinMode(a1, OUTPUT);
  pinMode(a2, OUTPUT);
  pinMode(b1, OUTPUT);
  pinMode(b2, OUTPUT);
  
  digitalWrite(a1, LOW);
  digitalWrite(a2, LOW); 
  digitalWrite(b1, LOW); 
  digitalWrite(b2, LOW);   
}

void loop(){
  xPosition = analogRead(xPin);
  yPosition = analogRead(yPin);
  buttonState = digitalRead(buttonPin);

  Serial.print("X: ");
  Serial.print(xPosition);
  Serial.print(" | Y: ");
  Serial.print(yPosition);
  Serial.print(" | Button: ");
  Serial.println(buttonState);

  if (buttonState == 0) move_clocwise();

  if (xPosition > 767 or yPosition > 767) move_clocwise();
  if (xPosition < 255 or yPosition < 255) move_contrclocwise();

  }

void move_clocwise(){
    step1();
    delay(inter_step_delay);
    step2();
    delay(inter_step_delay);
    step3();
    delay(inter_step_delay);
    step4();
    delay(inter_step_delay);
}

void move_contrclocwise(){
    step4();
    delay(inter_step_delay);
    step3();
    delay(inter_step_delay);
    step2();
    delay(inter_step_delay);
    step1();
    delay(inter_step_delay);
}

void step1 (){
  digitalWrite(a1, HIGH);
  delay(step_delay);
  digitalWrite(a2, LOW);
  delay(step_delay); 
  digitalWrite(b1, LOW); 
  delay(step_delay);
  digitalWrite(b2, LOW); 
}

void step2 (){
  digitalWrite(a1, LOW);
  delay(step_delay);
  digitalWrite(a2, LOW); 
  delay(step_delay);
  digitalWrite(b1, HIGH); 
  delay(step_delay);
  digitalWrite(b2, LOW); 
}

void step3 (){
  digitalWrite(a1, LOW);
  delay(step_delay);
  digitalWrite(a2, HIGH); 
  delay(step_delay);
  digitalWrite(b1, LOW); 
  delay(step_delay);
  digitalWrite(b2, LOW); 
}

void step4 (){
  digitalWrite(a1, LOW);
  delay(step_delay);
  digitalWrite(a2, LOW); 
  delay(step_delay);
  digitalWrite(b1, LOW); 
  delay(step_delay);
  digitalWrite(b2, HIGH); 
}