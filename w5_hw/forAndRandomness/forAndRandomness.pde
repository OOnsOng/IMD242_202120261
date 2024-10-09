//1. 마우스 위치에 따라 최소 3개에서 최대 16개의 사각 타일로 채운다.

int tileNum;
int randomSeed = 0;
float noiseMult = 0.001;

void setup() {
  size(800, 800);
}

void draw() {
  noiseSeed(randomSeed);
  //색이 계속 같음
  //randomSeed(randomSeed);
  //색이 바뀜
  background(0);
  //int(random(1, 21));
  //뒤의 값을 원하는 값보다 1크게 해줘야함 (뒤의 값 미만의 수만 나옴)
  tileNum = int(map(mouseX, 0, width, 3, 16 + 1));
  //int로 정수화할 때 원하는 값보다 1 더 크게 설정해줘야함
  //noiseMult = map(mouseY, 0, height, 0.01, 0.0005);
  noiseMult = pow(5, map(mouseY, 0, height, -1, -4));

  //float tileSize = width / tileNum;
  //정수 나누기 정수면 float여도 소수값을 빼버림 (밑의 식처럼 수정하기)
  float tileSize = width / float(tileNum);
  //tileNum을 float로 감싸줘서 소수화 해주기

  for (int row = 0; row < tileNum; row++) {
    for (int col = 0; col < tileNum; col++) {
      float rectX = tileSize * col;
      float rectY = tileSize * row;
      float centerX = rectX + tileSize * 0.5;
      float centerY = rectY + tileSize * 0.5;
      //float randomVal = random(1);
      float noiseVal = noise(centerX * noiseMult, centerY * noiseMult);
      //fill(0);
      //rect(rectX, rectY, tileSize, tileSize);
      //fill(255 * randomVal);
      //색상이 랜덤으로 보여짐
      //fill(255 * noiseVal);
      fill(0);
      //stroke(100, 255, 100);
      stroke(150, mouseY, mouseX);
      strokeWeight(2);
      circle(centerX, centerY, tileSize * 1);
      //마지막 -> 네모와 원의 간격
      pushMatrix();
      translate(centerX, centerY);
      //rotate(radians(360 * randomVal));
      //rotate를 하지 않으면 방향이 다 똑같음
      rotate(radians(-90 + 180 * noiseVal));
      //strokeWeight(4);
      float lineLength = tileSize * 0.8 * 0.5;
      line(0, 0, lineLength, 0);
      fill(mouseY, mouseX, 100);
      noStroke();
      circle(lineLength, 0, tileSize * .2);
      popMatrix();
      //pushMatrix(), popMatrix() 하면 정렬됨
    }
  }
}
