PImage left, right;
import processing.serial.*;
Serial port1, port2;

void setup() {
  size(600, 600, P3D);
  left = loadImage("orphe_left.jpg");  // 200 x 550
  right = loadImage("orphe_right.jpg");  // 200 x 550
  textureMode(IMAGE);

  String[] ports = Serial.list();
  for (int i = 0; i < ports.length; i++) {
    println(i + ": " + ports[i]);
  }
  port1 = new Serial(this, ports[4], 115200);
  port2 = new Serial(this, ports[3], 115200);
}

String str1, str2;

void draw() {

  if (port1.available() == 0) return;
  println(port1.available());
  while (port1.available() > 0) {
    str1 = port1.readStringUntil('\n');
  }

  if (port2.available() == 0) return;
  println(port2.available());
  while (port2.available() > 0) {
    str2 = port2.readStringUntil('\n');
  }
  
  background(0);
  scale(0.5);

  // left
  String toks[] = split(trim(str1), ",");
  if (toks.length != 3) {println("left"); return;}

  float pitch = float(toks[0]);
  float roll = -float(toks[1]);
  float yaw = 180 - float(toks[2]);

  pushMatrix();
  translate(width - 200, height , 0);
  float c1 = cos(radians(roll));
  float s1 = sin(radians(roll));
  float c2 = cos(radians(pitch));
  float s2 = sin(radians(pitch));
  float c3 = cos(radians(yaw));
  float s3 = sin(radians(yaw));
  applyMatrix(c2*c3, s1*s3+c1*c3*s2, c3*s1*s2-c1*s3, 0,
              -s2, c1*c2, c2*s1, 0,
              c2*s3, c1*s2*s3-c3*s1, c1*c3+s1*s2*s3, 0,
              0, 0, 0, 1);
  drawM5StickC_left();
  popMatrix();
  
  // right
  toks = split(trim(str2), ",");
  if (toks.length != 3) {println("right"); return;}

  pitch = float(toks[0]);
  roll = -float(toks[1]);
  yaw = 180 - float(toks[2]);

  pushMatrix();
  translate(width + 200, height , 0);
  c1 = cos(radians(roll));
  s1 = sin(radians(roll));
  c2 = cos(radians(pitch));
  s2 = sin(radians(pitch));
  c3 = cos(radians(yaw));
  s3 = sin(radians(yaw));
  applyMatrix(c2*c3, s1*s3+c1*c3*s2, c3*s1*s2-c1*s3, 0,
              -s2, c1*c2, c2*s1, 0,
              c2*s3, c1*s2*s3-c3*s1, c1*c3+s1*s2*s3, 0,
              0, 0, 0, 1);
  drawM5StickC_right();
  popMatrix();
}

void drawM5StickC_left() {
  beginShape();
  texture(left);
  vertex(-100, 0, -225,   0,   0); //V1
  vertex( 100, 0, -225, 200,   0); //V2
  vertex( 100, 0,  225, 200, 550); //V3
  vertex(-100, 0,  225,   0, 550); //V4
  endShape();
}

void drawM5StickC_right() {
  beginShape();
  texture(right);
  vertex(-100, 0, -225,   0,   0); //V1
  vertex( 100, 0, -225, 200,   0); //V2
  vertex( 100, 0,  225, 200, 550); //V3
  vertex(-100, 0,  225,   0, 550); //V4
  endShape();
}
