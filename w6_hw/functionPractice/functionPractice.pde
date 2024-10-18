int randomSeed = int(random(100000000));

void setup() {
  size(800, 800);
}

void mousePressed() {
  randomSeed = int(random(100000000));
  println(randomSeed);
}

void draw() {
  randomSeed(randomSeed);
  background(0, 0, 50);

  for (int n = 0; n < 5; n++) {
    house(random(width * 0.1, width * 0.9),
      random(150, 250),
      random(height * 0.3, height * 0.7),
      int(random(2, 5)),
      int(random(3, 6)),
      random(20, 40),
      color(random(170, 255), random(130, 255), random(120, 255)));
  }
}

void house(float x, float w, float h, int windowRows, int windowCols, float doorHeight, color houseColor) {
  pushMatrix();
  translate(x, height);

  fill(houseColor);
  rect(0, 0, w, -h);
  
  fill(0, 0, 50);
  stroke(255);
  strokeWeight(4);
  rect(w / 3, -doorHeight, w / 3, doorHeight);

  fill(255);
  float windowWidth = w / (windowCols + 1);
  float windowHeight = (h - doorHeight) / (windowRows + 1);

  for (int row = 0; row < windowRows; row++) {
    for (int col = 0; col < windowCols; col++) {
      float wx = (col + 1) * windowWidth - windowWidth * 0.5;
      float wy = -(row + 1) * windowHeight - windowHeight * 0.5;
      
      if(wy < -doorHeight && wy > -h) {
      rect(wx, wy, windowWidth * 0.8, windowHeight * 0.8);
      }
    }
  }

  popMatrix();
}
