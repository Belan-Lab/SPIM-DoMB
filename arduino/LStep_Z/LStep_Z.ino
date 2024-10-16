// based on https://github.com/mutterer/MM_CustomArduino

// An arduino firmware that can be used with the Micro-Manager LStep Z-Stage device adaptor.
// Allows building simple 1-axis stage devices.
// version 0.1
// JM 2016-2018

// References
// https://micro-manager.org/wiki/MarzhauserLStep
// MM device adaptor code /DeviceAdapters/Marzhauser-LStep/LStep.cpp
// LStep documentation from www.marzhauser.com/nc/en/service/downloads.html

// in HCW, use serial port settings:
// AnswerTimeout,3000.0000
// BaudRate,9600
// DelayBetweenCharsMs,0.0000
// Handshaking,Off
// Parity,None
// StopBits,1

#include <Servo.h>
Servo myservo; 
int servoPin = 3;
#include <LiquidCrystal.h>
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);
String cmd = "" ;
float z = 0.0;

void setup() {
  Serial.begin( 9600 );
  myservo.attach(servoPin);
  lcd.begin(16, 2);
  lcd.print("MiFoBio 2018");
  lcd.setCursor(0, 1);
  lcd.print("vLStep-Z ready");
  delay(1000);
  reply ("Vers:LS");
}
char c = '*';

void loop()
{
  if (Serial.available()) {
    cmd = Serial.readStringUntil('\r');
    processCommand(cmd);
    cmd = "";
  }
}

void processCommand(String s) {
  if (s.startsWith("?ver")) {
    reply ("Vers:LS");
  } else if (s.startsWith("!autostatus 0")) {
    delay(5);
  } else if (s.startsWith("?det")) {
    reply ("60");
  } else if (s.startsWith("?pitch z")) {
    reply ("50.0");
  } else if (s.startsWith("?vel z")) {
    reply ("100.0");
  } else if (s.startsWith("?accel z")) {
    reply ("1.0");
  } else if (s.startsWith("!dim z 1")) {
    delay(5);
  } else if (s.startsWith("!dim z 2")) {
    delay(5);
  } else if (s.startsWith("?statusaxis")) {
    reply ("@");
  } else if (s.startsWith("!vel z")) {
    delay(5);
  } else if (s.startsWith("!accel z")) {
    delay(5);
  } else if (s.startsWith("?pos z")) {
    String zs = String(z, 1);
    reply (zs);
    lcd.clear();
    lcd.print("MiFoBio 2018");
    lcd.setCursor(0, 1);
    lcd.print("Z:");
    lcd.print(zs);
  } else if (s.startsWith("?lim z")) {
    reply ("0.0 100.0");
  } else if (s.startsWith("!pos z")) {
    delay(5);
  } else if (s.startsWith("?status")) {
    reply ("OK...");
  } else if (s.startsWith("!dim z 0")) {
    delay(5);
  } else if (s.startsWith("!speed z")) {
    delay(5);
  } else if (s.startsWith("!mor z")) {
    String delta = s.substring(s.indexOf("z") + 1);
    z = z + delta.toFloat();
    turnServo();
  } else if (s.startsWith("!moa z")) {
    String apos = s.substring(s.indexOf("z") + 1);
    z = apos.toFloat();
    turnServo();
  } else if (s.startsWith("?err")) {
    reply ("0");
  }
}

void reply(String s) {
  Serial.print(s);
  Serial.print("\r");
}

void turnServo() {
    myservo.write(map(z,-100,100,0,180));
  }
/*
  // "?ver"   ->   Vers:LS
  // "?det"   ->   11F31  seul le 2nd least significant byte (le 3) est important = 3 axes
  // "?statusaxis" -> @ si dispo et M si busy
  // "!autostatus 0"
  // "?pitch z" -> 50.0
  // "!dim z 2" mettre en microns
  // "!dim z 1"
  // "?vel z"  -> 100.0
  // "!vel z 100"
  // "?accel z" -> 1.0
  // "!accel z 1"
  "a" -> abort ??
  "!moa z 10"  move z to absolute 10
  // "?err"  retourner 0
  // "!mor z " move z by relative 10
  // "?pos z" query current z pos -> return z pos
  // "?lim z" query limits, -> 0.0 100.0
  // "!pos z 0" set origin
  // "!pos z 20 fixe cette origine pour le controlle
  // "?status"  -> OK...
  "!dim z 0" set as steps.
  "MOA Z " move to abs step pos
  "?pos z" get position as steps
  //"!speed z 10" lance le mouvement en mm/sec
*/