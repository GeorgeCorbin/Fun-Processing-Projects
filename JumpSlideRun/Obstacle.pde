enum Type {
  BLOCK, BAR, SPIKES
}

class Obstacle {
  float xVelocity = -3.0;
  float horizontalSize;
  float verticalSize;
  PVector position;
  Type shape;
  boolean sameCollision = false;

  Obstacle(float horizontalSize, float verticalSize, PVector position, Type shape, float xVelocity) {
    this.horizontalSize = horizontalSize;
    this.verticalSize = verticalSize;
    this.position = position;
    this.shape = shape;
    this.xVelocity = xVelocity;
  }

  void drawObstacle() {
    fill(0);
    switch (shape) {
    case BAR:    // Line
      line(position.x, position.y, position.x + horizontalSize, position.y);
      break;
    case BLOCK:    // Block
      rect(position.x, position.y - verticalSize, horizontalSize, verticalSize);
      break;
    case SPIKES:    // Spikes
      float spikeWidth = horizontalSize / 3.0;
      for (int spike = 0; spike < 3; spike++) {
        float leftX = position.x + (spike * spikeWidth);
        triangle(leftX, position.y, leftX + spikeWidth / 2.0, position.y - verticalSize, leftX + spikeWidth, position.y);
      }
      break;
    }
  }

  void move() {
    position.x += xVelocity;
  }

  boolean isOffScreen() {
    return position.x < -horizontalSize;
  }

  float getX() {
    return position.x;
  }

  float getxVelocity() {
    return xVelocity;
  }

  void speedUp() {    
    xVelocity -= .01;
    //println(xVelocity);
  }

  boolean isColliding(Man player) {
    if (sameCollision) {
      return false;
    }
    if (player.getRightEdge() < position.x || player.getLeftEdge() > position.x + horizontalSize) {
      return false;
    } else if (player.getTopEdge() > position.y || player.getBottomEdge() < position.y - verticalSize) {
      return false;
    } 
    if (player.getBottomEdge() >= position.y - verticalSize 
      && player.getBottomEdge() <= position.y - verticalSize + 15
      && player.getRightEdge() > position.x + 5
      && shape != Type.SPIKES) {
      player.stopFall(position.y - verticalSize, 0);
      player.setAction(Action.RUNNING);
      return false;
    } else {
      sameCollision = true;
      return true;
    }
  }
}
