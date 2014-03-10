# KeyboardProxy

Enables sending keyboard input for Arduino Uno and earlier boards using Processing as a proxy.

## Setup
1. Open the .pde file in Processing
2. Run the Processing Sketch
3. Watch the Processing console: it will display a list of available serial ports
4. Adjust the setup() function in the Processing sketch to connect to the right port from the list

## Usage
1. Run the Processing sketch
2. Click in the application window to enable the keyboard proxy
3. Make sure the application you want to control is in the foreground and is the selected window

## Arduino code
You can use the Serial library to send keyboard commands to the Processing sketch. The following keys are supported:
1. "A" till "Z" and "0" till "9"
2. "<" and ">" equal the left and right arrow key
3. "^" and "." equal the up and down arrow key
4. "_" equals the spacebar

### Example code for Arduino:
The following code checks an analog sensor at pin A0 and sends a  "_" character to the computer if the measured value is greater than 300, resulting in a emulated press on the spacebar.

```Arduino
int sensorPin = A0;
int prevValue = 0;

void setup() {
    Serial.begin(9600);
}

void loop() {
    int value = analogRead(sensorPin);
    if (value > 300 && prevValue <= 300) {
        Serial.write("_");
    }
    prevValue = value;
}