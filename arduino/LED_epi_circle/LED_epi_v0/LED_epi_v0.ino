#include <FastLED.h>
#include <Encoder.h>

#define LED_PIN     6      // Пін для підключення Data In гірлянди
#define NUM_LEDS    16     // Кількість LED в гірлянді (змініть на свою)
#define BRIGHTNESS  32    // Яскравість за замовчуванням (0-255)
#define MAX_BRIGHTNESS 64 // Максимальна яскравість
#define LED_TYPE    WS2812B  // Тип LED
#define COLOR_ORDER GRB     // Порядок кольорів

// Піни енкодера
#define ENCODER_PIN_A 2
#define ENCODER_PIN_B 3
#define ENCODER_BUTTON 4   // Пін для кнопки енкодера

// Режими роботи
#define MODE_MOVE     0    // Режим руху сегмента
#define MODE_BRIGHTNESS 1  // Режим регулювання яскравості
#define MODE_LENGTH   2    // Режим регулювання довжини сегмента

CRGB leds[NUM_LEDS];
Encoder myEncoder(ENCODER_PIN_A, ENCODER_PIN_B);

// Variables for tracking
long oldPosition = 0;      // Previous encoder position
int segmentLength = 8;     // Length of illuminated segment
int currentPosition = 0;   // Current position of the first LED in segment
int currentMode = MODE_MOVE; // Current operating mode
int currentBrightness = BRIGHTNESS; // Current brightness level
bool ledsOn = true;        // Flag for LEDs on/off state

// Colors for different modes
CRGB moveColor = CRGB::White;      // Color when in movement mode
CRGB brightnessColor = CRGB::White; // Color when in brightness mode
CRGB lengthColor = CRGB::Red;     // Color when in length mode

// Button handling variables
int buttonState = HIGH;     // Current button state
int lastButtonState = HIGH; // Previous button state
unsigned long lastDebounceTime = 0;  // Last debounce time
unsigned long debounceDelay = 50;    // Debounce time in ms

// Double-click detection
unsigned long lastClickTime = 0;
unsigned long doubleClickDelay = 300; // Max time between clicks to count as double-click
bool awaitingDoubleClick = false;

// Long press detection
unsigned long buttonPressStart = 0;
bool longPressHandled = false;
unsigned long longPressDuration = 2000; // 2 seconds for long press

void setup() {
  // Initialize FastLED
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS)
    .setCorrection(TypicalLEDStrip);
  FastLED.setBrightness(currentBrightness);
  
  // Set up button with internal pull-up resistor
  pinMode(ENCODER_BUTTON, INPUT_PULLUP);
  
  // Initialize serial for debugging
  Serial.begin(9600);
  Serial.println("Starting LED ring control with encoder");
  Serial.println("Default mode: MOVE SEGMENT");
  Serial.println("Single click: Toggle brightness adjustment");
  Serial.println("Double click: Toggle segment length adjustment");
  Serial.println("Long press (2s): Turn LEDs on/off");
  
  // Initial LED update
  updateLEDs();
}

void loop() {
  // Only process encoder if LEDs are on
  if (ledsOn) {
    // Read encoder position (divide by 4 to reduce sensitivity)
    long newPosition = myEncoder.read() / 4;
    
    // Check if position has changed
    if (newPosition != oldPosition) {
      switch (currentMode) {
        case MODE_MOVE:
          // MOVE SEGMENT MODE
          if (newPosition > oldPosition) {
            // Clockwise rotation - move segment forward
            currentPosition = (currentPosition + 1) % NUM_LEDS;
          } else {
            // Counter-clockwise rotation - move segment backward
            currentPosition = (currentPosition - 1 + NUM_LEDS) % NUM_LEDS;
          }
          Serial.print("Position: ");
          Serial.println(currentPosition);
          break;
          
        case MODE_BRIGHTNESS:
          // BRIGHTNESS ADJUSTMENT MODE
          if (newPosition > oldPosition) {
            // Increase brightness (max is MAX_BRIGHTNESS)
            currentBrightness = min(currentBrightness + 5, MAX_BRIGHTNESS);
          } else {
            // Decrease brightness (min is 5)
            currentBrightness = max(currentBrightness - 5, 5);
          }
          FastLED.setBrightness(currentBrightness);
          Serial.print("Brightness: ");
          Serial.println(currentBrightness);
          break;
          
        case MODE_LENGTH:
          // SEGMENT LENGTH MODE
          if (newPosition > oldPosition) {
            // Increase segment length (max is NUM_LEDS)
            segmentLength = min(segmentLength + 1, NUM_LEDS);
          } else {
            // Decrease segment length (min is 1)
            segmentLength = max(segmentLength - 1, 1);
          }
          Serial.print("Segment Length: ");
          Serial.println(segmentLength);
          break;
      }
      
      // Update old position
      oldPosition = newPosition;
      
      // Update LEDs
      updateLEDs();
    }
  }
  
  // Button handling for mode switching and power toggle
  int reading = digitalRead(ENCODER_BUTTON);
  
  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }
  
  if ((millis() - lastDebounceTime) > debounceDelay) {
    if (reading != buttonState) {
      buttonState = reading;
      
      // Button press detected (LOW when using INPUT_PULLUP)
      if (buttonState == LOW) {
        // Button pressed - start timing for long press
        buttonPressStart = millis();
        longPressHandled = false;
      } else {
        // Button released - check if it was a long press
        unsigned long pressDuration = millis() - buttonPressStart;
        
        if (pressDuration >= longPressDuration && !longPressHandled) {
          // Long press detected - toggle LEDs on/off
          ledsOn = !ledsOn;
          Serial.print("LEDs toggled: ");
          Serial.println(ledsOn ? "ON" : "OFF");
          updateLEDs();
          longPressHandled = true;
        } else if (pressDuration < longPressDuration && !longPressHandled) {
          // Short press - handle regular button press
          handleButtonPress();
        }
      }
    }
  }
  
  // Check if we're awaiting a double click and time is up
  if (awaitingDoubleClick && (millis() - lastClickTime > doubleClickDelay)) {
    awaitingDoubleClick = false;
    
    // We had a single click (not a double), so switch to brightness mode
    if (currentMode != MODE_BRIGHTNESS) {
      currentMode = MODE_BRIGHTNESS;
      Serial.println("Mode changed: BRIGHTNESS ADJUSTMENT");
      updateLEDs();
    } else {
      // If already in brightness mode, go back to move mode
      currentMode = MODE_MOVE;
      Serial.println("Mode changed: MOVE SEGMENT");
      updateLEDs();
    }
  }
  
  lastButtonState = reading;
}

void handleButtonPress() {
  unsigned long currentTime = millis();


  // Check if LEDs are off - turn them on with a quick press
  if (!ledsOn) {
    ledsOn = true;
    Serial.println("LEDs turned ON");
    updateLEDs();
    return;
  }


  // Check if this could be a double click
  if (awaitingDoubleClick) {
    // This is a double click!
    awaitingDoubleClick = false;
    
    // Set to length adjustment mode
    currentMode = MODE_LENGTH;
    Serial.println("Mode changed: SEGMENT LENGTH ADJUSTMENT");
    updateLEDs();
  } else {
    // This might be the first click of a double click
    lastClickTime = currentTime;
    awaitingDoubleClick = true;
    
    // If in length mode, single click returns to move mode
    if (currentMode == MODE_LENGTH) {
      currentMode = MODE_MOVE;
      awaitingDoubleClick = false; // Cancel double-click detection
      Serial.println("Mode changed: MOVE SEGMENT");
      updateLEDs();
    }
  }
}

void updateLEDs() {
  // Clear all LEDs
  fill_solid(leds, NUM_LEDS, CRGB::Black);
  
  // If LEDs are turned off, just show all black
  if (!ledsOn) {
    FastLED.show();
    return;
  }
  
  // Select color based on current mode
  CRGB currentColor;
  int displayBrightness = currentBrightness;
  
  switch (currentMode) {
    case MODE_MOVE:
      currentColor = moveColor;
      break;
    case MODE_BRIGHTNESS:
      currentColor = brightnessColor;
      break;
    case MODE_LENGTH:
      currentColor = lengthColor;
      displayBrightness = 16; // Fixed low brightness in length mode
      break;
  }
  
  // Illuminate the segment with ring wraparound
  for (int i = 0; i < segmentLength; i++) {
    // Calculate position with ring wraparound
    int pos = (currentPosition + i) % NUM_LEDS;
    leds[pos] = currentColor;  // Set segment color based on mode
  }
  
  // In brightness mode, use the current brightness
  // But in length mode, override with fixed low brightness
  if (currentMode == MODE_LENGTH) {
    FastLED.setBrightness(16);
  } else {
    FastLED.setBrightness(currentBrightness);
  }
  
  // Update LEDs
  FastLED.show();
}
