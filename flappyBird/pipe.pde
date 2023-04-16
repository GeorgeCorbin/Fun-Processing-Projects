class Pipe {
  float x, y, vx;
  int pipeWidth = 50;
  int pipeHeight = height;
  boolean isCounted = false;
  PImage pipeImage;


  Pipe(float startX, float startY) {
    x = startX;
    y = startY;
    vx = -3;
    pipeImage = loadImage("pipe.png");
    pipeImage.resize(pipeWidth, pipeHeight);
  }

  void update() {
    move();
    display();
  }

  void move() {
    x += vx;
  }

  void display() {
    if (y < 0) {
      pushMatrix();
      translate(x + pipeWidth / 2, y + pipeHeight / 2);
      rotate(PI);
      image(pipeImage, -pipeWidth / 2, -pipeHeight / 2);
      popMatrix();
    } else {
      image(pipeImage, x, y);
    }
  }

  boolean isPassed(Bird bird) {
    if (x + pipeWidth < bird.getLeftEdge() && !isCounted) {
      isCounted = true;
      return true;
    } else {
      return false;
    }
  }

  boolean isOffScreen() {
    return x + pipeWidth + 10 < 0;
  }

  boolean isColliding(Bird bird) {
    if (bird.getRightEdge() < x || x + pipeWidth < bird.getLeftEdge()) {    // If before or after pipes
      return false;
    } else if (y < 0) {    // If Top Pipe
      if (bird.getTopEdge() > y + pipeHeight) {
        return false;
      }
    } else {    // Bottom Pipe
      if (bird.getBottomEdge() < y) {
        return false;
      }
    }
    return true;
  }
}
