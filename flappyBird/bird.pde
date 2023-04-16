class Bird {
  
  PImage birdImage;

  float x, y, vx, vy, ay, h;
  
  int birdHeight = 30;
  int birdWidth = 42;

  Bird(float startX, float startY) {
    x = startX;
    y = startY;
    vx = 0;
    vy = 0;
    ay = .55;
    h = 0;
    birdImage = loadImage("bird.png");
    birdImage.resize(birdWidth, birdHeight);
  }

  void update() {
    move();
    display();
  }

  void move() {
    y += vy;
    vy += ay;
    if (y <= 0) {
      y = 0;
    } 
    if (y >= height - birdHeight + 5) {
      y = height - birdHeight + 5;
    }
  }

  void display() {
    float angle;
    int upAngle = -30;
    int downAngle = 90;
    int upSpeedLimit = 4;
    int downSpeedLimit = 15;
    
    pushMatrix();
    translate(x + birdWidth / 2, y + birdHeight / 2);
    if (vy < upSpeedLimit) {
      angle = upAngle;
    } else if (vy > downSpeedLimit) {
      angle = downAngle;
     } else {
       angle = (((vy - upSpeedLimit) / (downSpeedLimit - upSpeedLimit)) * (downAngle - upAngle) + upAngle);
     }
    rotate(radians(angle));
    image(birdImage, -birdWidth / 2, -birdHeight / 2);
    popMatrix();

  }

  float getLeftEdge() {
    return x;
  }
  
  float getRightEdge() {
    return x + birdWidth;
  }
  float getTopEdge() {
    return y;
  }
  
  float getBottomEdge() {
    return y + birdHeight;
  }
  boolean isDead() {
    return y + birdHeight - 5  >= height;
  }
}
