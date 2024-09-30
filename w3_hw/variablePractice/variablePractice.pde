float faceX = random(width);
float faceY = random(height);
float r = random(255);
float g = random(255);
float b = random(255);
float faceSize = random(50, 200);
float eyeY = faceY - faceSize / 6;
float eyeXBetween = faceSize / 6;
float eyeSize = faceSize / 9;
float expression = random(4);
float faceStroke = faceSize / 14;
float mouthY = faceY + faceSize / 4;

void setup() {
  size(640, 480);
  background(0);
  frameRate(10);
  //colorMode(HSB);
}

void mousePressed() {
  background(0);
}

void draw() {

  //얼굴
  noStroke();
  fill(r, g, b);
  faceX = random(width);
  faceY = random(height);
  faceSize = random(50, 200);
  r = random(150, 255);
  g = random(100, 200);
  b = random(50, 200);

  eyeY = faceY - faceSize / 6;
  eyeXBetween = faceSize / 6;
  eyeSize = faceSize / 9;
  circle(faceX, faceY, faceSize);

  //눈
  fill(0);
  circle(faceX - eyeXBetween, eyeY, eyeSize);
  circle(faceX + eyeXBetween, eyeY, eyeSize);

  //입
  mouthY = faceY + faceSize / 4;
  stroke(0);

  faceStroke = faceSize / 14;
  strokeWeight(faceStroke);
  noFill();


  expression = random(4);
  if (expression < 2) { 
    //웃는 표정
    arc(faceX, mouthY - 20, faceSize / 2, faceSize / 4, 0, PI);
  } else if (expression < 3) {
    //슬픈 표정
    arc(faceX, mouthY, faceSize / 2, faceSize / 4, PI, TWO_PI);
  } else {
    //무표정
    line(faceX - faceSize / 4, mouthY - 15, faceX + faceSize / 4, mouthY - 15);
  }
}
