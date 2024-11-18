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
