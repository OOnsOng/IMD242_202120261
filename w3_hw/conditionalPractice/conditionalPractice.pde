void setup() {
  size(640, 360);
  rectMode(CENTER);
  //rectMode(RADIUS);
}

void draw() {
  background(0);

  stroke(255);
  strokeWeight(4);
  fill(165);
  
  if (mouseY < height / 4) {
    line(width * .5 - 45, height / 4 - 80, width * .5 + 45, height / 4 - 15);
  } else if (mouseY < height / 4 * 2) {
    square(width * .5, height / 4 * 2 - 45, 70);
  } else if (mouseY < height / 4 * 3) {
    rect(width * .5, height * .5 + 45, 150, 35, 5);
  } else {
    circle(width * .5, height / 4 * 4 - 45, 70);
  }

  stroke(165);
  //strokeWeight(5);
  line(0, height / 4 , width, height / 4);
  line(0, height / 4 * 2, width, height / 4 * 2);
  line(0, height / 4 * 3, width, height / 4 * 3);
}
