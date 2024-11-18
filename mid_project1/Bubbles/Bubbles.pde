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

//파티클 클래스
class Particle {
  PVector pos; //파티클 위치
  PVector velocity; //파티클 속도
  float lifespan; // 파티클 수명
  
  Particle(float x, float y, float speed, float angle) {
    pos = new PVector(x, y); //파티클 처음 위치 설정
    velocity = new PVector(cos(angle) * speed, sin(angle) * speed); //speed와 angle에 따른 파티클의 초기 속도 설정
    lifespan = 255; //파티클의 초기 lifespan을 255로 설정 (가장 진한 투명도인 255로 설정)
  }

  void update() {
    pos.add(velocity); //파티클 위치를 현재 위치에 속도를 더한 것으로 업데이트
    lifespan -= 5; //매 프레임마다 lifespan을 감소시켜 점점 투명해짐
  }

  void display() {
    noStroke(); //파티클 두께 제거
    fill(255, lifespan); //파티클의 색상을 255로 설정하고 lifespan에 따라 투명도 감소
    ellipse(pos.x, pos.y, 3, 3); //파티클을 현재 위치에서 반지름 3인 작은 원으로 생성
  }

  boolean isDisappear() {
    return lifespan <= 0; //lifespan이 0 이하인 파티클은 삭제
  }
}

//비눗방울 클래스
class Bubble {
  PVector pos; //파티클 위치
  PVector velocity; //파티클 속도
  float radius; //비눗방울 반지름
  float birthTime; //비눗방울 생성 시간
  boolean popped; //비눗방울의 터짐 여부
  boolean isPreview; //미리보기 여부
  color bubbleColor; //비눗방울 색상
  int mergeCount; //비눗방울이 합쳐진 횟수
  float transparency; //비눗방울 투명도

  Bubble(float x, float y, float r) {
    pos = new PVector(x, y); //비눗방울 처음 위치 설정
    velocity = new PVector(-random(1, 3), random(0, 2)); //왼쪽으로 움직이는 기본 속도 설정
    radius = r; //비눗방울 반지름
    birthTime = millis(); //비눗방울 생성 시간을 기록
    popped = false; //popped의 기본값을 false로 설정
    isPreview = false; //isPreview의 기본값을 false로 설정
    mergeCount = 0; //합쳐진 횟수를 0으로 초기화
    bubbleColor = color(255); //비눗방울의 기본 색상을 하얀색으로 설정
    //투명도를 50, 100, 200 중 하나로 랜덤하게 설정
    int[] possibleTransparencies = {50, 100, 200};
    transparency = possibleTransparencies[(int)random(0, 3)];
  }

  void update() {
    if (!isPreview && millis() - birthTime > random(8000, 15000)) {
      pop(); // 비눗방울이 생성된 후 8~15초가 지나면 터짐
    }
    pos.add(velocity); //비눗방울 위치를 velocity만큼 이동시킴
  }

  void updatePreview() {
    int pressDuration = millis() - pressStartTime;
    radius = map(pressDuration, 0, 3000, 10, 120); //마우스를 누른 시간에 따라 반지름의 크기를 10~120 사이로 조절(3초를 기준으로 설정)
    pos.set(mouseX - radius, mouseY); //마우스 왼쪽에서 비눗방울이 이동
    isPreview = true; //현재 방울이 미리보기 상태임을 나타냄
  }

  void display() {
    if (!popped) { //비눗방울이 터지지 않았을 경우

      //chat gpt에게 비눗방울 색상이 테두리에서 중심으로 갈수록 자연스럽게 연해지게 그라데이션 하는 방법에 대하여 물어보았다
      color borderColor = color(255, transparency); //테두리 색상은 하얀색에 투명도 설정
      color fillColor = color(255, transparency * 0.07); //내부 색상은 테두리보다 0.07배 투명한 하얀색

      float gradientRange = radius * 0.6; //그라데이션 범위를 반지름의 60%로 설정

      //그라데이션을 부드럽게 적용
      for (int idx = 0; idx < radius; idx++) { //그라데이션 범위를 줄여서 안쪽 원을 더 작게함
        float inter = map(idx, 0, gradientRange, 0, 1); //테두리에서 중심으로 갈수록 inter 값 증가
        inter = constrain(inter, 0, 1); // inter 값을 0~1 사이로 제한

        color c = lerpColor(borderColor, fillColor, inter); //테두리에서 내부로 갈수록 색상이 부드럽게 변화

        // 그라데이션이 부드럽게 변화하도록 범위가 자연스럽게 섞임
        stroke(c); //c를  테두리 색상으로 설정
        noFill(); //내부 색상 없애기
        ellipse(pos.x, pos.y, radius * 2 - idx, radius * 2 - idx); //중심을 기준으로 원을 겹쳐서 그라데이션 효과
      }
    } else { //비눗방울이 터졌을 경우
      stroke(bubbleColor, 200); //bubbleColor의 두께 200인 외곽선을 그림
      noFill(); //내부 색상 없애기
      ellipse(pos.x, pos.y, radius * 3, radius * 3); //터진 비눗방울은 반지름을 3배로 키워서 터지는 효과를 줌
    }
  }

  void edgesOfScreen() {
    if (pos.x - radius < 0 || pos.x + radius > width || pos.y - radius < 0 || pos.y + radius > height) {
      pop(); //비눗방울이 화면의 경계선에 닿으면 터짐
    }
  }

  //chat gpt에게 생성된지 3초가 지나고 투명도가 같으면 합쳐지도록 물어보았다. (합치는 횟수는 3회로 제한)
  void checkCollision(Bubble other) {
    //다른 비눗방울과의 충돌 감지
    float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
    if (d < radius + other.radius && !popped && !other.popped && millis() - birthTime > 3000 && millis() - other.birthTime > 1000) {
      //비눗방울이 생성되고 3초가 지난 뒤, 두 비눗방울이 겹쳐지고 둘 다 터지지 않았을 경우
      if (mergeCount < 3 && other.mergeCount < 3 && transparency == other.transparency) { //두 비눗방울의 투명도가 같고 각각 3번 이하로 합쳐졌으면
        merge(other); //합치기
      }
    }
  }

  void merge(Bubble other) {
    //투명도가 50인 비눗방울끼리는 합쳐지지 않도록 설정
    if (transparency == 50 || other.transparency == 50) { //투명도가 50이면
      return; //합치지 않고 종료
    }

    //두 비눗방울 합치기
    float newRadius = sqrt(sq(radius) + sq(other.radius)); //두 비눗방울의 합으로 새로운 반지름 계산
    PVector newPosition = new PVector((pos.x + other.pos.x) / 2, (pos.y + other.pos.y) / 2); //두 비눗방울의 중간 위치를 새로운 위치로 설정

    //기존 두 비눗방울을 터뜨리고 하나의 비눗방울로 합침
    radius = newRadius; //새로운 반지름으로 설정
    pos = newPosition; //새로운 위치로 설정
    mergeCount++; //합쳐진 횟수 증가
    other.popped = true; //다른 비눗방울을 터뜨림
  }

  void pop() {
    popped = true; //비눗방울이 터짐
    radius += 1; //터지는 순간 반지름을 1 정도 증가시킴
  }

  boolean isPopped() {
    return popped && millis() - birthTime > 200; //200밀리초가 지난 비눗방울은 제거 대상
  }
}
