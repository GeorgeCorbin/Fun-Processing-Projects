// Obstacle Variables/Arrays
int MAX_OBJECTS = 5;
int NUM_OBSTACLES = 2;
Obstacle [] obstacles = new Obstacle[NUM_OBSTACLES];
//                      (w, h, y)             BLOCK                   BAR                     SPIKES
PVector [] shapeSize = new PVector[] {new PVector(80, 95, 30), new PVector(75, 0, 30), new PVector(75, 20, 0)};
int spacing = 500;
float initialXVelocity = -3.0;

// Power Up Variables
PowerUp powerUp;
PowerUpType activePowerUp = PowerUpType.NONE;
int lives = 1;
boolean doubleJump = false;

// Ground Variables
float groundLevel;
float groundHeight = 43;

// Player Variables
int manWidth = 20;
int manHeight = 40;
Man player = null;

// Score Related Variables
float rawScore = 0;
int score = 0;
int bestScore = 0;
int startPauseTime = 0;
int endPauseTime = 0;
int timePaused = 0;
int totalBonusTime;
int powerUpStartTime; 

// FSM Variables
int state = 0;
String openingRemarks = "Welcome to Jump, Slide, Run" +
  "\n\nUp Arrow to Jump" +
  "\nHold Down Arrow to Slide" + 
  "\nR to Restart" +
  "\nH for Help" +
  "\n\nPress Space to Start";
String helpScreenText1 = "Up Arrow to Jump" +
  "\nHold Down Arrow to Slide" + 
  "\n\nR to Restart" + 
  "\nP to Pause" + 
  "\nQ to Leave Help" + 
  "\n\nNote: You Can Land on" + 
  "\n        Top of Every Obstalce" + 
  "\n        Except Spikes";
String helpScreenText2 = "This is a Power Up:" +
  "\nIt Can Be:" + 
  "\n   Double Points, Double Jump, or Extra life" +
  "\n\nDouble Points Disappears after a while" +
  "\nDouble Jump has one use" +
  "\nYou can have a max of" + 
  "\n      5 Extra Lives" +
  "\nYou can have only one type" +
  "\n      of Power Up at a Time";

// Pause Variables
boolean pause = false;

// Death Variables
boolean flashMode = false;
int flashStart = 0;

void setup() {
  ellipseMode(CORNER);
  rectMode(CORNER);
  //size(640, 480);
  size(712, 343, P2D);
  groundLevel = height - 43;
  player = new Man(manWidth, manHeight, new PVector(width-612, height - 43));    // create player
  initialXVelocity = -3.0;
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i] = makeObstacle(width + i*spacing);
  }
  powerUp = null;
  pause = false;
  activePowerUp = PowerUpType.NONE;
  rawScore = 0;
  lives = 1;
}

void draw() {
  if (millis() > flashStart + 500) {
    flashMode = false;
  }
  if (flashMode && millis() / 100 % 2 == 0) {
    background(#ff0000);
  } else {
    background(#ffffff);
  }
  fill(#000000);
  rect(0, groundLevel, width, groundHeight);    // Ground

  switch(state) {
  case 0:    // Intro Screen
    textSize(24);
    textAlign(CENTER);
    text(openingRemarks, .5 * width, .1 * height);
    if (key == ' ') {
      state = 1;
      setup();
    }

    break;
  case 1:    // Game Screen
    if (!pause) {
      player.move();    // call to class telling player to move
    }
    player.update();    // call to class telling player to do different actions (jump, slide, run)

    for (int i = 0; i < obstacles.length; i++) {
      if (!pause) {
        obstacles[i].move();      // Call to class telling it to move
      }
      if (obstacles[i].isOffScreen()) {    // If obstacle is off the screen 
        float x = ((int)(width / spacing) + 1) * spacing + obstacles[i].getX();
        obstacles[i] = makeObstacle(x);
        if (obstacles[i].shape == Type.BAR && powerUp == null && random(1) < 1) {    // random gives the frequency of spawing a power up
          powerUp = makePowerUps(x);
        }
      }

      obstacles[i].drawObstacle();

      if (obstacles[i].isColliding(player)) {    // If player collides with obstacle switch to death screen
        lives--;
        if (lives == 0) {
          state = 2;
        } else {
          flashMode = true;
          flashStart = millis();
        }
      }
    }

    if (powerUp != null) {
      if (!pause) {
        powerUp.move();
      }
      powerUp.drawPowerUp();

      if (powerUp.isColliding(player)) {
        activePowerUp = powerUp.getBooster();
        powerUpStartTime = millis();
        powerUp = null;
        if (activePowerUp == PowerUpType.DOUBLE_JUMP) {
          doubleJump = true;
        } else {
          doubleJump = false;
        }
        if (activePowerUp == PowerUpType.EXTRA_LIFE && lives < 5) {
          lives++;
        }
      } else if (powerUp.isOffScreen()) {
        powerUp = null;
      }
    }
    textAlign(CENTER);
    fill(#00bb00);
    switch (activePowerUp) {
    case DOUBLE_JUMP:
      if (doubleJump) {
        text("DOUBLE JUMP", width * .5, height * .1);
      }
      break;
    case DOUBLE_POINTS:
      text("DOUBLE POINTS", width * .5, height * .1);
      if (!pause && millis() - powerUpStartTime - timePaused > 3000) {
        activePowerUp = PowerUpType.NONE;
      }
      break;
    case EXTRA_LIFE:
      text("EXTRA LIFE EARNED", width * .5, height * .1);
      if (!pause && millis() - powerUpStartTime - timePaused > 2000) {
        activePowerUp = PowerUpType.NONE;
      }
      break;
    default:
    }

    if (score > bestScore) {    // Check for Best Score
      bestScore = score;
    }

    // Calculate Score
    if (!pause) {
      int factor = activePowerUp == PowerUpType.DOUBLE_POINTS ? 2 : 1;
      rawScore += (10.0/frameRate) * factor; 
      score = (int)rawScore;
    }

    // Display Score
    textAlign(LEFT);
    fill(0);
    text("Score: " + score, width * .05, height * .1);
    // Display Best Score
    text("High Score: " + bestScore, width * .05, height * .2);

    // Display Lives
    text("Lives: " + lives, width * .8, height * .1);

    break;
  case 2:    // Death Screen

    String deathScreen = "You died!" +
      "\n\nYour Score: " + score +
      "\n\nPress R to Restart";
    textAlign(CENTER);
    text(deathScreen, .5 * width, .15 * height);
    break;
  case 3:    // Help Screen
    textAlign(LEFT);
    textSize(18);
    fill(0);
    text(helpScreenText1, width * .03, height * .1);
    text(helpScreenText2, width * .45, height * .1);
    image(loadImage("PowerUpBorder.png"), width * .7, height * .05);
    break;
  }
}


Obstacle makeObstacle(float x) {
  Type shape = Type.values()[(int)(random(Type.values().length))];
  float hSize = shapeSize[shape.ordinal()].x;
  float vSize = shapeSize[shape.ordinal()].y;
  float heightAboveGround = shapeSize[shape.ordinal()].z;
  initialXVelocity -= .05;
  return new Obstacle (hSize, vSize, new PVector(x, groundLevel - heightAboveGround), shape, initialXVelocity);
}

PowerUp makePowerUps(float x) {
  PowerUpType booster = PowerUpType.values()[(int)(random(PowerUpType.values().length - 1))];
  //float heightAboveGround = shapeSize[booster.ordinal()].z;
  return new PowerUp(new PVector(x + 42.5, height - groundHeight - 160), booster, initialXVelocity);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    state = 0;
    timePaused = 0;
  }
  if (key == 'p' || key == 'P') {
    pause = !pause;

    if (pause) {
      startPauseTime = millis();
    } else {       
      endPauseTime = millis();
      timePaused += endPauseTime - startPauseTime;
    }
  }

  if (state == 0 && key == 'h' || key == 'H') {    // Go to Help
    state = 3;
  } 
  if (state == 3 && key == 'q' || key == 'Q') {    // Leave Help
    state = 0;
  }
  switch (keyCode) {
  case DOWN:
    player.startSliding();
    break;
  case UP:
    if (player.startJumping(doubleJump)) {
      doubleJump = false;
      activePowerUp = PowerUpType.NONE;
    }
    break;
  }
}
void keyReleased() {
  if (keyCode == DOWN) {
    player.endSliding();
  }
}
