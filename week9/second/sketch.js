let tileNumX = 16;
let tileNumY = 16;

function setup() {
  createCanvas(640, 480);
}

function draw() {
  background('#333333');
  noStroke();
  fill('cornflowerblue');
  // for (let column = 0; column < width; column += 40) {
  //   // 자바스크립트는 모든 변수가 무조건 let으로 시작함 **
  //   for (let row = 0; row < height; row += 40) {
  //     let x = 20 + column;
  //     let y = 20 + row;
  //     let diameter = 30;
  //     circle(x, y, diameter);
  //   }
  // }
  for (let row = 0; row < tileNumY; row++) {
    for (let column = 0; column < tileNumX; column++) {
      let tileW = width / column;
      let tileH = height / row;
      let x = tileW * 0.5 + column * tileW;
      let y = tileH * 0.5 + row * tileH;
      ellipse(x, y, tileW, tileH);
    }
  }
}
