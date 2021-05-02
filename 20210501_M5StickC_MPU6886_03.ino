#include <M5StickC.h>
#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

float roll, pitch, yaw;

void setup() {
  M5.begin();
  M5.Lcd.fillScreen(BLACK);
  M5.Lcd.setTextSize(4);
  M5.Lcd.setCursor(5, 5);
//  M5.MPU6886.Init();
  M5.IMU.Init();
  SerialBT.begin("M5StickC");
}

void loop() {
  M5.update();  // ボタンの状態を更新
  if (M5.BtnA.wasReleased()) {
    M5.Lcd.print('A');
    ESP.restart();
  }
//  M5.MPU6886.getAhrsData(&pitch, &roll, &yaw);
  M5.IMU.getAhrsData(&pitch, &roll, &yaw);
  Serial.printf("%5.1f,%5.1f,%5.1f\n", pitch, roll, yaw);
  SerialBT.printf("%5.1f, %5.1f, %5.1f\n", pitch, roll, yaw);
  delay(20);
}
