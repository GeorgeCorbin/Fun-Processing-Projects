// Start is Mode 0
// Whoops is Mode 1
// Go is Mode 2
// End is Mode 3
// Waiting is Mode 4

float circleSpawnTime = millis() + random(2000, 7000);
int speed = 0;
int mode = 0;
int startTime = 0;

String startingText = "Hit the spacebar to start the" 
  + "\nreaction time test. Then, wait for" 
  + "\nthe red circle to appear. When it\n" 
  + "does, press the spacebar again as"
  + "\nquickly as possible. If you press"
  + "\nthe spacebar early, you'll have to"
  + "\nrestart the test."; 

String waitingText = "Wait for it...";

String tooEarlyText = "Whoops! You pressed the button"
  + "\ntoo early. Press space to try again.";

String circleText = "GO";

void setup() {
  size(500, 500);
  background(0);
}

void draw() {
  background(0);
  fill(255);

  switch (mode) {
    case 0:    // Start Screen (Mode 0)
      textSize(28);
      textAlign(CENTER);
      text(startingText, width/2, height/2 - 125);
      break;
    case 4:    // Waiting Screen (Mode 4)
      text(waitingText, width/2, height/2);
      if (millis() > circleSpawnTime) {
        startTime = millis();
        mode = 2;
      }
      break;
    case 1:    // Whoops Too Early Screen (Mode 1)
      text(tooEarlyText, width/2, height/2);
      break;
    case 2:        // Go Screen (Mode 2)
      fill(0);
      text(circleText, width/2, height/2);
      fill(#ff0000);
      ellipse(width/2, height/2, 100, 100);
      break;
    case 3:        // End Screen (Mode 3)
      String reactionText = "You reacted in " + speed + " ms."
        + "\nPress space to try again.";
  
      text(reactionText, width/2, height/2);
      break;
  }
}

void keyPressed() {
  if (key == ' ') {
    switch (mode) {
      case 0: 
        circleSpawnTime = millis() + random(2000, 7000);
        mode = 4;
        break;
      case 1:
        mode = 0;
        break;
      case 2:
        speed = millis() - startTime;
        mode = 3;
        break;
      case 3:
        mode = 0;
        break;
      case 4:
        mode = 1;
        break;
    }
  }
}
