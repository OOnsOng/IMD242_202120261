int[] fruitAmts;
String[] fruitNames = {"mango",
  "strawberry",
  "kiwi",
  "plum",
  "blueberry"};
//선언, 초기화, 할당 한번에 하는 법
//-> 여기서 나열하고 void setup()에 fruitAmts = new int[fruitNames.length]; 하면 됨
color[] barColors = new color[fruitNames.length];

void setup() {
  size(1280, 720);
  //size(960, 720);
  fruitAmts = new int[fruitNames.length];
  //초기화를 해줘야함 (몇 개인지를 미리 설정해줘야됨)
  for (int n = 0; n < fruitAmts.length; n++) {
    //fruitAmts.length는 array의 크기를 반환해줌
    if (n == 0) {
      fruitAmts[n] = 50;
    } else {
      fruitAmts[n] = int(random(5, 100));
    }
    int r = int(random(0, 20));
    int g = int(random(100, 255));
    int b = int(random(0, 20));
    barColors[n] = color(r, g, b);
  }

  //fruitAmts[0] =  50;
  //fruitAmts[1] =  int(random(5, 100));
  //fruitAmts[2] =  int(random(5, 100));
  //fruitAmts[3] =  int(random(5, 100));
  //fruitAmts[4] =  int(random(5, 100));
  //반드시 0부터 시작 개수 -1까지가 들어갈 수 있는 실질적인 숫자
}

float barGap = 100;
float barWidth = 28;


void draw () {
  background(0, 40, 0);
  strokeWeight(barWidth);

  float totalGraphWidth = (fruitNames.length - 1) * barGap + barWidth;
  float x = (width - totalGraphWidth) / 2;
  int totalAmts = 0;

  for (int n = 0; n < fruitNames.length; n++) {
    totalAmts += fruitAmts[n];
  }

  float averageAmts = (float)totalAmts / fruitAmts.length;

  for (int n = 0; n < fruitNames.length; n++) {
    //float barHeight = 2 * fruitAmts[n];
    //float startX = x + barGap * n;
    //float endY = height * 0.5 - barHeight;

    //if (n == 0 || n == fruitNames.length - 1) {
    //  strokeCap(SQUARE);
    //} else {
    //  strokeCap(ROUND);
    //}

    stroke(barColors[n]);
    strokeWeight(barWidth);
    strokeCap(SQUARE);

    textAlign(CENTER);
    textSize(24);
    fill(255);
    line(x + barGap * n, height * 0.5,
      x + barGap * n, height * 0.5 - 2 * fruitAmts[n]);
    //line(startX, height * 0.5, startX, endY);
    text(fruitNames[n],
      x + barGap * n, height * 0.5 + 30);
    text(fruitAmts[n],
      x + barGap * n, height * 0.5 - 2 * fruitAmts[n] - 20);

    fill(252, 211, 69);
    text("Total Fruit Inventory: " + totalAmts,
      width * 0.5, height * 0.7);
    text("Average Number of Fruits: " + averageAmts,
      width * 0.5, height * 0.75);
  }
}
