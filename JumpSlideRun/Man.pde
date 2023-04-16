enum Action {
  RUNNING, JUMPING, SLIDING
}

class Man {
  int horizontalSize;
  int verticalSize;
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0.5);
  float groundLevel;
  Action currentAction = Action.RUNNING;
  int endSlideTime = 0;
  // Image Variables
  PImage runningImg;
  PImage slidingImg;
  PImage jumpingImg;

  Man(int horizontalSize, int verticalSize, PVector position) {
    this.horizontalSize = horizontalSize;
    this.verticalSize = verticalSize;
    this.position = position;
    groundLevel = position.y;

    runningImg = loadImage("Running.png");
    slidingImg = loadImage("Sliding.png");
    jumpingImg = loadImage("Jumping.png");
  }

  void move() {
    switch (currentAction) {
    case RUNNING:
      velocity.add(acceleration);
      position.add(velocity);
      if (position.y > groundLevel) {    // If below Ground Level
        position.y = groundLevel;
        velocity.y = 0;
      }
      break;
    case SLIDING:
      break;
    case JUMPING:
      velocity.add(acceleration);
      position.add(velocity);
      if (position.y > groundLevel) {    // If below Ground Level
        position.y = groundLevel;
        velocity.y = 0;
        currentAction = Action.RUNNING;
      }
      break;
    }
  }

  void update() {
    int trail = (millis() / 100) % 5 * 3;
    fill(#cccccc);
    switch (currentAction) {
    case RUNNING:
      image(runningImg, position.x, position.y - verticalSize);
      ellipse(position.x - 8 - trail, position.y - 7, 7, 7);
      ellipse(position.x - 20 - trail, position.y - 9, 5, 5);
      ellipse(position.x - 30 - trail, position.y - 5, 3, 3);
      break;
    case JUMPING:
      image(jumpingImg, position.x, position.y - verticalSize);
      break;
    case SLIDING:
      image(slidingImg, position.x, position.y - verticalSize);
      ellipse(position.x - 8 - trail, position.y - 7, 7, 7);
      ellipse(position.x - 20 - trail, position.y - 9, 5, 5);
      ellipse(position.x - 30 - trail, position.y - 5, 3, 3);
      break;
    }
  }

  void startSliding() { 
    switch (currentAction) {
    case RUNNING:
      int temp = horizontalSize;
      horizontalSize = verticalSize;
      verticalSize = temp;    
      currentAction = Action.SLIDING;
      //endSlideTime = millis() + SLIDING_TIME;
      //System.out.println(currentAction + " " + endSlideTime + " " + millis());
      break;
    case JUMPING:
      break;
    case SLIDING:
      break;
    }
  }
  void endSliding() {
    int temp = horizontalSize;
    horizontalSize = verticalSize;
    verticalSize = temp;    
    currentAction = Action.RUNNING;
  }

  boolean startJumping(boolean doubleJump) {
    switch (currentAction) {
    case SLIDING:
      endSliding();
      // fall through
    case RUNNING:
      velocity.y = -11;
      currentAction = Action.JUMPING;
      break;
    case JUMPING:
      if (doubleJump) {
        velocity.y = -11;
        return true;
      }
      break;
    }
    return false;
  }
  float getRightEdge() {
    return position.x + horizontalSize;
  }
  float getLeftEdge() {
    return position.x;
  }
  float getTopEdge() {
    return position.y - verticalSize;
  }
  float getBottomEdge() {
    return position.y ;
  }

  void stopFall(float y, float yVel) {
    position.y = y;
    velocity.y = yVel;
  }

  void setAction(Action currentAction) {
    this.currentAction = currentAction;
  }
}
