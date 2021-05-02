#include <M5Atom.h>
#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

float roll, pitch, yaw;

void setup() {
  M5.begin();
  M5.IMU.Init();
  SerialBT.begin("M5AtomMatrix");
}

void loop() {
  M5.update();  // ボタンの状態を更新
  if (M5.Btn.wasReleased()) {
    ESP.restart();
  }
  M5.IMU.getAhrsData(&pitch, &roll, &yaw);
  Serial.printf("%5.1f,%5.1f,%5.1f\n", pitch, roll, yaw);
  SerialBT.printf("%5.1f, %5.1f, %5.1f\n", pitch, roll, yaw);
  delay(20);
}
