/*
 * 👋 Hello! This is an ml5.js example made and shared with ❤️.
 * Learn more about the ml5.js project: https://ml5js.org/
 * ml5.js license and Code of Conduct: https://github.com/ml5js/ml5-next-gen/blob/main/LICENSE.md
 *
 * This example demonstrates face tracking on live video through ml5.faceMesh.
 */

let faceMesh;
let video;
let faces = [];
// 2개 이상일 가능성이 있는 함수는 무조건 array 선언을 해놔야됨
let options = { maxFaces: 1, refineLandmarks: false, flipHorizontal: false };
// maxFaces -> 인식하는 얼굴 수, refineLandmarks -> false로 해야 빨리 돌아감, flipHorizontal -> 반전된 화면을 보여줌 true로 하면 페이스매쉬랑 반대로 움직임

function preload() {
  // Load the faceMesh model
  faceMesh = ml5.faceMesh(options);
}

function setup() {
  createCanvas(640, 480);
  // Create the webcam video and hide it
  video = createCapture(VIDEO);
  video.size(640, 480);
  video.hide();
  // hide 안 넣으면 비디오 화면이 두 개 생김(페이스매쉬가 안된 비디오)
  // Start detecting faces from the webcam video
  faceMesh.detectStart(video, gotFaces);
}

function draw() {
  // Draw the webcam video
  image(video, 0, 0, width, height);

  // Draw all the tracked face points
  for (let i = 0; i < faces.length; i++) {
    let face = faces[i];
    // for (let j = 0; j < face.keypoints.length; j++) {
    //   let keypoint = face.keypoints[j];
    //   fill(0, 255, 0);
    //   noStroke();
    //   circle(keypoint.x, keypoint.y, 5);
    // }
    let leftEye = face.leftEye;
    for (let n = 0; n < leftEye.keypoints.length; n++) {
      let keypoint = leftEye.keypoints[n];
      circle(keypoint.x, keypoint.y, 5);
    }
  }
}

// Callback function for when faceMesh outputs data
function gotFaces(results) {
  // Save the output to the faces variable
  faces = results;
}

function keyPressed() {
  if (key === 'o' || key === 'O') {
    console.log(faces);
  }
}
