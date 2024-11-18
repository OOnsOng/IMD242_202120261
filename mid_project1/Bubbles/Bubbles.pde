ArrayList<Bubble> bubbles; //비눗방울 ArrayList
Bubble bigBubble; //큰 비눗방울
int pressStartTime; //마우스를 누른 시작 시간
boolean isDrag; //마우스 드래그
ArrayList<Particle> particles; //비눗방울 파티클 ArrayList


void setup() {
  fullScreen(); //전체화면으로 화면 크기 설정
  bubbles = new ArrayList<Bubble>(); //비눗방울 ArrayList 초기화
  particles = new ArrayList<Particle>(); //파티클 ArrayList 초기화
  frameRate(60); //프레임 속도 60으로 설정
  isDrag = false; //드래그의 기본값을 false로 설정
}

void draw() {
  background(158, 223, 229); //배경 색상(하늘색)

  //bubbles의 비눗방울 업데이트 및 그리기
  for (int idx = bubbles.size() - 1; idx >= 0; idx--) { //비눗방울 개수 반환
    Bubble b = bubbles.get(idx); //변수 b를 bubbles의 idx번째 비눗방울로 지정
    b.update(); //비눗방울 속성 업데이트
    b.edgesOfScreen(); //화면 경계선
    b.display(); //화면에 그리기

    //일정 시간이 지나면 터져서 사라짐
    if (b.isPopped()) {
      //chat gpt에게 비눗방울이 터질때에 맞춰서 파티클이 생성되는 코드를 물어보았다
      makeParticles(b.pos.x, b.pos.y, b.radius); //비눗방울이 터질 때 비눗방울 파티클 생성
      bubbles.remove(idx); //터진 비눗방울은 리스트에서 제거
    }
  }

  //particles의 파티클 업데이트 및 그리기
  for (int idx = particles.size() - 1; idx >= 0; idx--) {
    Particle p = particles.get(idx); //변수 p를 particles idx번째 파티클로 지정
    p.update(); //파티클 속성 업데이트
    p.display(); //화면에 그리기
    if (p.isDisappear()) { //p가 사라지면
      particles.remove(idx); // particles에서 제거함
    }
  }

  //chat gpt에게 비눗방울끼리 충돌하면 합쳐지도록 하는 코드에 대해서 물어보았다
  for (int n = 0; n < bubbles.size(); n++) { //n번째 비눗방울과 나머지 비눗방울을 비교
    for (int idx = n + 1; idx < bubbles.size(); idx++) { //현재 비눗방울 이후의 모든 비눗방울과 비교
      bubbles.get(n).checkCollision(bubbles.get(idx)); //두 비눗방울 간의 충돌 여부 확인
    }
  }

  //chat gpt에게 마우스를 드래그하지 않고 꾹 누르고 있으면 비눗방울이 커지는 코드에 대해서 물어보았다
  if (!isDrag && bigBubble != null) { //마우스를 드래그 하지 않은 상태에서 bigBubble이 존재하면
    bigBubble.updatePreview(); //bigBubble의 크기를 점점 키움
    bigBubble.display(); //화면에 그리기
  }

  //화면 좌측 상단에 ArrayList의 현재 크기 표시
  fill(255); //흰색 글자
  textSize(22); //글자 크기 22
  text("Bubbles: " + bubbles.size(), 10, 30); //비눗방울 개수 표시
}

void mousePressed() {
  pressStartTime = millis(); //마우스 누른 시간 기록
  bigBubble = new Bubble(mouseX, mouseY, 1); //마우스 위치에서 생성하고 처음 크기는 1
  bigBubble.transparency = 200; //bigBubble의 투명도를 200으로 고정
  isDrag = false; //드래그 상태를 false로 되돌림
}

void mouseReleased() {
  if (!isDrag && bigBubble != null) {
    //드래그 상태가 아니고 bigBubble이 존재하면
    bigBubble.isPreview = false; //마우스 옆에 있는 것이 아닌 움직이는 비눗방울로 전환
    bigBubble.birthTime = millis(); //비눗방울 생성 시간을 기록
    bubbles.add(bigBubble); //bubbles 리스트에 추가
  }
  bigBubble = null; //bigBubble을 초기화하여 마우스 옆에 비눗방울이 보이지 않게 함
  isDrag = false; //드래그 상태를 false로 되돌림
}

void mouseDragged() {
  isDrag = true; //마우스가 움직일 때의 드래그 상태를 true로 설정
  int pressDuration = millis() - pressStartTime; //마우스를 누른 시간으로부터 지난 시간

  //드래그 시간에 따른 비눗방울 크기 설정
  if (pressDuration < 200) {
    //마우스를 누르고 있는 시간이 200밀리초 미만이면
    float radius = random(12, 35); //비눗방울 크기를 12~35 사이에서 랜덤 설정
    Bubble newBubble = new Bubble(mouseX, mouseY, radius); //마우스 위치에서 radius 크기로 비눗방울 생성
    bubbles.add(newBubble); //bubbles 리스트에 추가
  }
}

void makeParticles(float x, float y, float radius) {
  int numParticles = (int)random(10, 30); //파티클 개수를 10~30 사이에서 랜덤 설정
  for (int idx = 0; idx < numParticles; idx++) { // 각 파티클을 numParticles만큼 반복하여 생성
    float angle = random(TWO_PI); //파티클 방향을 0~360도 범위에서 랜덤 설정
    float speed = random(1, 5); //파티클 속도를 1~5 사이에서 랜덤 설정
    float px = x + cos(angle) * radius * 0.5; //파티클의 처음 x위치를 비눗방울 중심에서 약간 떨어진 위치로 설정
    float py = y + sin(angle) * radius * 0.5; //파티클의 처음 y위치를 비눗방울 중심에서 약간 떨어진 위치로 설정
    Particle p = new Particle(px, py, speed, angle); //위의 설정을 바탕으로 파티클 생성
    particles.add(p); //particles 리스트에 추가
  }
}
