enum PowerUpType {    // "NONE" ALWAYS HAS TO BE LAST
  DOUBLE_JUMP, DOUBLE_POINTS, EXTRA_LIFE, NONE
}

class PowerUp {

  float xVelocity = -3.0;
  int horizontalSize = 25;
  int verticalSize = 25;
  PVector position;
  PowerUpType booster;

  PImage powerUpImg;

  PowerUp(PVector position, PowerUpType booster, float xVelocity) {
    this.position = position;
    this.booster = booster;
    this.xVelocity = xVelocity;

    powerUpImg = loadImage("PowerUpBorder.png");
  }

  void drawPowerUp() {
    image(powerUpImg, position.x, position.y - verticalSize);
  }
  void move() {
    position.x += xVelocity;
  }

  void speedUp() {    
    xVelocity -= .01;
  }

  boolean isOffScreen() {
    return position.x < -horizontalSize;
  }

  float getX() {
    return position.x;
  }

  PImage getPowerUpImage() {
    return powerUpImg;
  }

  PowerUpType getBooster() {
    return booster;
  }

  boolean isColliding(Man player) {
    if (player.getRightEdge() < position.x || player.getLeftEdge() > position.x + horizontalSize) {
      return false;
    } else if (player.getTopEdge() > position.y || player.getBottomEdge() < position.y - verticalSize) {
      return false;
    } else {
      return true;
    }
  }
}
