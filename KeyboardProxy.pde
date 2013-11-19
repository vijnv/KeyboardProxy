import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import processing.serial.*;

// Implementing Java Robot class:
// http://docs.oracle.com/javase/6/docs/api/java/awt/Robot.html

Robot robot;
Serial myPort;
boolean robot_active = false;

void setup() {
  size(200, 200);
  textAlign(CENTER, CENTER);
  textSize(26);
  try {
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }
  robot.setAutoDelay(40);
  robot.setAutoWaitForIdle(true);

  printArray(Serial.list());
  // Run this sketch once and look for your Arduino port in
  // the list. Adjust the portumber between the [] brackets below:
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  if (robot_active) {
    background(0, 153, 0);
    text("Status: ON", 0, 0, width, height);
  } 
  else {
    background(204, 0, 0);
    text("Status: OFF", 0, 0, width, height);
  }
}

void mousePressed() {
  robot_active = !robot_active;
}

void serialEvent(Serial p) {
  int keycode = lookupKey(p.read());
  if (keycode > 0 && robot_active) {
    print("Keycode: ");
    println(keycode);
    robot.keyPress(keycode);
    robot.keyRelease(keycode);
  }
}

int lookupKey(int val) {
  int kc=0;
  switch (val) {
    case 62: // char: >
      kc = KeyEvent.VK_RIGHT;
      break;
    case 60: // char: < 
      kc = KeyEvent.VK_LEFT;
      break;
    case 94: // char: ^ 
      kc = KeyEvent.VK_UP;
      break;
    case 46: // char: .
      kc = KeyEvent.VK_DOWN;
      break;
    case 95: // char: _ 
      kc = KeyEvent.VK_SPACE;
      break;
    default:
      if (val >= 48 && val <= 90) {
         kc = val;
      } else { 
         kc = 0;
      }
  }
  return kc;
}
