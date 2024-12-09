let canvasContainer = document.querySelector('#canvas-container');
let sizeSlider = documet.querySelector('.range.range-size');
let rgbSlider = document.querySelectorAll('range.range-color');
let valueOutPlaces = document.querySelectorAll('.value');
// rgbSlider[0].addEventListener('change', (e) => {
//   valueOutPlaces[0].textContent = rgbSlider[0].value;
// });
rgbSlider.forEach((eachRgbSlider, idx) => {
  eachRgbSlider.addEventListener('change', (e) => {
    valueOutPlaces[idx].textContent = eachRgbSlider.value;
  });
});

function setup() {
  createCanvas(400, 400).parent(canvasContainer);
}

function draw() {
  background(220);
  fill(rgbSlider[0].value, rgbSlider[1].value, rgbSlider[2].value);
  circle(mouseX, mouseY, sizeSlider.value);
  fill(0);
  text(rgbSlider[0].value, 8, 16);
  text(rgbSlider[1].value, 8, 32);
  text(rgbSlider[2].value, 8, 48);
}
