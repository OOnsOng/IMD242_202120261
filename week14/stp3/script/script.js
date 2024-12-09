let slider = document.querySelector('#slider-1');
// 아이디를 기준으로 슬라이더를 가져옴
console.log(slider);
console.log(slider.value);
let aNewDiv = document.createElement('div');
let textContents = document.createTextNode(slider.value);
aNewDiv.appendChild(textContents);
document.body.appendChild(aNewDiv);
