// George Corbin
// No Partner

Bird bird;
PFont font;
PImage backgroundImage;
PImage titleImage;
ArrayList<Pipe> pipes;
int spacing = 100;
int pipeSpawnTimeNumber = 2000;
int pipeSpawnTime;
float score;
float highScore;
int mode = 0;

String openingText = "Welcome to Flappy Bird!\n"
  + "Press Space to Start and Flap\n"
  + "and Press R to Restart.\n"
  + "Good Luck!";

String titleText = "PRESS SPACE WHEN READY!";

String deadText = "You Died!\nPress R and Try Again";

void setup() {
  size(640, 480);
  textAlign(CENTER);
  font = createFont("04B_19__.TTF", 32);
  titleImage = loadImage("title.jpg");
  titleImage.resize(width, height);
  backgroundImage = loadImage("background.png");
  backgroundImage.resize(width + 5, height + 5);
  bird = new Bird(.2 * width, height / 2);
  pipes = new ArrayList<Pipe>();
  pipeSpawnTime = millis() + pipeSpawnTimeNumber;
  score = 0;
}

void draw() {
  fill(255);
  textFont(font); 
  image(backgroundImage, 0, 0);
  switch (mode) {
  case 0:
    text(openingText, width / 2, height / 3);
    break;
  case 1:
    image(titleImage, 0, 0);
    text(titleText, width / 2, height * .9);
    break;
  case 2:
    if (millis() > pipeSpawnTime) {
      float pipeY = -(random(height - spacing * 1.5));
      Pipe p = new Pipe(width * 1.1, pipeY - spacing);    // Top Pipe
      pipes.add(p);
      p = new Pipe(width * 1.1, pipeY + height);    // Bottom Pipe
      pipes.add(p);
      pipeSpawnTime = millis() + pipeSpawnTimeNumber;
    }

    for (int i = pipes.size() - 1; i >= 0; i--) {
      Pipe p = pipes.get(i);
      p.update();
      if (p.isPassed(bird)) {
        score += .5;
      }
      if (p.isOffScreen()) {
        pipes.remove(p);
      }
      if (p.isColliding(bird)) {
        mode = 3;
      }
    }

    bird.update();
    if (bird.isDead()) {
      mode = 3;
    }
    displayScore();
    break;
  case 3:
    for (Pipe p : pipes) {
      p.display();
    }
    bird.update();
    fill(#ff0000);
    text(deadText, width/2, height/2);
    if (score > highScore) {
      highScore = score;
    }

    displayScore();
    break;
  }
}
void keyPressed() {
  if (key == 'r' || key == 'R') {
    mode = 1;
    setup();
  }
  switch (mode) {
  case 0:
    if (key == ' ') {
      mode = 1;
      setup();
    }
    break;
  case 1:
    if (key == ' ') {
      mode = 2;
    }
    break;
  case 2:
    if (key == ' ') {
      bird.vy = -8;
    }
    break;
  case 3:
    if (keyCode == 'R' || keyCode == 'r') {
      mode = 1;
    }
    break;
  }
}

void displayScore() {
  fill(255);
  text((int)score, width * .5, height * .2);

  text("Best: " + (int)highScore, width * .1, height * .1);
}
