float centerX, centerY;

void setup() {
  size(800, 800);
  centerX = width * .5;
  centerY = height * .5;
  rectMode(CENTER);
}

void draw() {
  background(0, 100, 150);

  fill(255);
  stroke(0, 0, 70);
  strokeWeight(10);
  //noStroke();
  circle(centerX, centerY, width - 50);

  for (int line = 0; line < 60; line++) {
    float angle = map(line, 0, 60, 0, TWO_PI);
    pushMatrix();
    translate(centerX, centerY);
    rotate(angle);
    //noStroke();

    if (line % 5 == 0) {
      strokeWeight(5);
      stroke(0, 100, 150);
      //fill(0, 100, 150);
      //circle(245, 245, 20);
    } else {
      stroke(0, 0, 70);
      strokeWeight(2);
      //fill(0, 0, 70);
      //circle(245, 245, 13);
    }
    line(0, -330, 0, -350);
    //circle(250, 250, 10);
    popMatrix();
  }

  int s = second();
  int m = minute();
  int h = hour();

  //시침
  float hourAngle = map(h % 12, 0, 12, 0, TWO_PI) + map(m, 0, 60, 0, TWO_PI / 12);
  strokeWeight(9);
  stroke(0, 0, 70);
  pushMatrix();
  translate(centerX, centerY);
  rotate(hourAngle);
  line(0, 0, 0, -170);
  popMatrix();

  //분침
  float minuteAngle = map(m, 0, 60, 0, TWO_PI);
  strokeWeight(7);
  stroke(0, 0, 70);
  pushMatrix();
  translate(centerX, centerY);
  rotate(minuteAngle);
  line(0, 0, 0, -300);
  popMatrix();

  //초침
  float secondAngle = map(s, 0, 60, 0, TWO_PI);
  strokeWeight(3);
  stroke(220, 0, 0);
  pushMatrix();
  translate(centerX, centerY);
  rotate(secondAngle);
  line(0, 0, 0, -270);
  popMatrix();

  fill(220, 0, 0);
  rect(width * .5, height * .5, 38, 38);
}
