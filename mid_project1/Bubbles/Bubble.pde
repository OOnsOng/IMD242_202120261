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
