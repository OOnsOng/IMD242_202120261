let gradientText = ' .:-=+*#%@';

let canvasSize = [640, 480];
let scale = 0.1;
let captureSize = [canvasSize[0] * scale, canvasSize[1] * scale];
let tileWidth = canvasSize[0] / captureSize[0];

let capture;

function setup() {
  createCanvas(canvasSize[0], canvasSize[1]);
  capture = createCapture(VIDEO, { flipped: true });
  capture.size(captureSize[0], canvasSize[1]);
  capture.hide();
}

function draw() {
  background(220);
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  // text(gradientText.charAt(3), 20, 20);
  // gradientText.charAt(n) 하면 n번째 위치의 글자만 보임
  capture.loadPixels();
  // 이걸 해줘야 새로운 픽셀이 계속 업데이트 됨
  for (let idx = 0; idx < capture.pixels.length / 4; idx++) {
    let r = capture.pixels[4 * idx + 0];
    let g = capture.pixels[4 * idx + 1];
    let b = capture.pixels[4 * idx + 2];
    let a = capture.pixels[4 * idx + 3];
    let bright = brightness([r, g, b]);
    let gradientIdx = map(bright, 0, 255, 0, gradientText.length - 1);
    gradientIdx = floor(gradientIdx);
    let asciiText = gradientText.charAt(gradientIdx);
    let column = idx % captureSize[0];
    let row = floor(idx / captureSize[0]);
    let x = column * tileWidth + tileWidth * 0.5;
    let y = row * tileWidth + tileWidth * 0.5;
    text(asciiText, x, y);
  }
}
