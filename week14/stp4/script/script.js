let slider = document.querySelector('input');
let valuePlace = document.querySelector('p');
console.log(slider);
console.log(valuePlace);
valuePlace.textContent = slider.value;

// slider.addEventListener("type", listener);
slider.addEventListener('change', (event) => {
  console.log(slider.value);
  valuePlace.textContent = slider.value;
  // 여기에 이걸 넣어주면 슬라이더가 매번 변경될 때마다 화면에서 숫자가 변경됨
});
