void setup() {
  size(640, 480);
}

void draw() {
  //background(255, 217, 102);
  background(mouseX, mouseY, 0);
  fill(120, 180, 40);
  //stroke(0, 90, 20);
  //strokeWeight(8);
  noStroke();

  //얼굴
  ellipse(320, 270, 300, 220);

  //눈
  ellipse(260, 180, 110, 120);
  ellipse(640 - 260, 180, 110, 120 );

  //흰자
  fill(255);
  ellipse(260, 180, 75, 78);
  ellipse(640-260, 180, 75, 78);

  float leftEyeX = constrain(mouseX, 260 - 15, 260 + 15);
  float leftEyeY = constrain(mouseY, 180 - 15, 180 + 15);

  float rightEyeX = constrain(mouseX, (640 - 260) - 15, (640 - 260) + 15);
  float rightEyeY = constrain(mouseY, 180 - 15, 180 + 15);

  //눈동자
  fill(0);
  //ellipse(260, 180, 35, 35);
  //ellipse(640-260, 180, 35, 35);
  circle(leftEyeX, leftEyeY, 35);
  circle(rightEyeX, rightEyeY, 35);

  //반사광
  fill(255);
  //circle(268, 170, 10);
  //circle(640-252, 170, 10);
  circle(leftEyeX + 8, leftEyeY - 10, 10);
  circle(rightEyeX + 8, rightEyeY - 10, 10);

  //볼터치
  fill(255, 50, 50, 100);
  circle(222, 270, 100);
  circle(640-222, 270, 100);

  //코
  fill(0);
  //arc(50, 55, 80,80,10,10);
  ellipse(310, 230, 8, 12);
  ellipse(640-310, 230, 8, 12);

  //입
  float distance = dist(mouseX, mouseY, 320, 270);
  noFill();
  stroke(0);
  strokeWeight(4);
  strokeCap(ROUND);
  //bezier(270, 320, 250, 320, 350, 320, 370, 320);
  if (distance > 150) {
    // 무표정
    bezier(285, 300, 290, 300, 350, 300, 355, 300);
  } else {
    // 웃는 입
    bezier(270, 300, 290, 320, 350, 320, 370, 300);
  }
  
  //파리
  noStroke();
  fill(106, 118, 134);
  ellipse(mouseX, mouseY, 25, 30);
  //circle(mouseX-10 mouseY, 10);
  //circle(mouseX+10 mouseY, 10);
}
