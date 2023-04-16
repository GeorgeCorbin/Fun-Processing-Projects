//ArrayList<Integer> x = new ArrayList<Integer> () , y = new ArrayList<Integer>();
//int w = 30, h = 30, grid = 20;
int direction1=0;
int direction2=180;
//int startscreen;

int highscore = 0;
int time1 = 0;
int snakesize=5;
int snakesize2=5;
int[] headx1= new int [2500];
int[] heady1= new int [2500];
int[] headx2= new int [2500];
int[] heady2= new int [2500];
int redSquarex=(round(random(47))+1)*8;
int redSquarey=(round(random(47))+1)*8;
boolean restart=true;
boolean stopgame=false;
int state = 0;

void setup()
{
  newGame();
  size(400, 400);
  textAlign(CENTER);
  // x.add(5);
  // y.add(5);
}
void draw() {
  switch (state) {
  case 0:
    background(255);
    fill(0);
    textSize(20);
    text("Snake but with a Twist!", width * .5, height *.25);
    text("WSAD to move Green Snake", width * .5, height *.4);
    text("Arrow Keys to move Blue Snake", width * .5, height *.46);
    text("Collect as many red squares as", width * .5, height *.57);
    text("possible and dont run into yourself!", width*.5, height *.62);
    text("Press Space to begin", width * .5, height *.8);
    if (key == ' ') {
      state = 1;
      newGame();
    }
    break;
  case 1:
    if (stopgame) {
    } else {
      time1+=1;
      //fill(243, 0, 0);
      fill(#ff0000);
      stroke(12);
      rect(redSquarex, redSquarey, 8, 8);
      fill(0);
      stroke(243);
      rect(0, 0, width, 8);
      rect(0, height-8, width, 8);
      rect(0, 0, 8, height);
      rect(width-8, 0, 8, height);
      /*  background(255);
       for(int i = 0; i< w; i++) line(i*grid, 0, i*grid, height);
       for(int i = 0; i< h; i++) line(0, i*grid, width, i*grid);
       for(int i = 0; i< x.size();i++){
       fill(0,255,0);
       rect(x.get(i)*grid, y.get(i)*grid,grid, grid);
       */
      if ((time1 % 5)==0) {
        move();
        drawSnakes();
        collisions();
        // text("Score: " + snakesize, 60, 20);
      }
    }
    break;
  } 
}

void drawSnakes() {
  // Snake 1
  if (headx1[1]==redSquarex && heady1[1]==redSquarey) {
    snakesize+=round(random(3)+1);
    restart=true;
    while (restart) {
      redSquarex=(round(random(47))+1)*8;
      redSquarey=(round(random(47))+1)*8;
      for (int i=1; i<snakesize; i++) {     
        if (redSquarex==headx1[i] && redSquarey==heady1[i]) {
          restart=true;
        } else {
          restart=false;
          i=1000;
        }
      }
    }
  }
  stroke(255, 255, 255);
  fill(#0000ff);
  rect(headx1[1], heady1[1], 8, 8);
  fill(255);
  rect(headx1[snakesize], heady1[snakesize], 8, 8);

  // Snake 2
  if (headx2[1]==redSquarex && heady2[1]==redSquarey) {
    snakesize2+=round(random(3)+1);
    restart=true;
    while (restart) {
      redSquarex=(round(random(47))+1)*8;
      redSquarey=(round(random(47))+1)*8;
      for (int i=1; i<snakesize; i++) {     
        if (redSquarex==headx2[i] && redSquarey==heady2[i]) {
          restart=true;
        } else {
          restart=false;
          i=1000;
        }
      }
    }
  }
  stroke(255, 255, 255);
  fill(#00ff00);
  rect(headx2[1], heady2[1], 8, 8);
  fill(255);
  rect(headx2[snakesize2], heady2[snakesize2], 8, 8);
}

void move() {
  for (int i=snakesize; i>0; i--) {
    if (i!=1) {
      headx1[i]=headx1[i-1];
      heady1[i]=heady1[i-1];
    } else {
      switch(direction1)
      {
      case 0:
        headx1[1]+=8;
        break;
      case 90:
        heady1[1]-=8;
        break;
      case 180:
        headx1[1]-=8;
        break;
      case 270:
        heady1[1]+=8;
        break;
      }
    }
  }

  for (int i=snakesize2; i>0; i--) {
    if (i!=1) {
      headx2[i]=headx2[i-1];
      heady2[i]=heady2[i-1];
    } else {
      switch(direction2) {
      case 0:
        headx2[1]+=8;
        break;
      case 90:
        heady2[1]-=8;
        break;
      case 180:
        headx2[1]-=8;
        break;
      case 270:
        heady2[1]+=8;
        break;
      }
    }
  }
}

void collisions() {
  for (int i=2; i<=snakesize; i++) {
    if (!stopgame) {
      if (headx1[1]==headx1[i] && heady1[1]==heady1[i] || headx1[1] == headx2[1] && heady1[1] == heady2[1] || headx1[i] == headx2[1] && heady1[i] == heady2[1]) {
        fill(255);
        rect(125, 125, 160, 100);
        fill(0);
        text("GAME OVER", 200, 150);
        text("Score: "+ str((snakesize-4) + (snakesize2-4)), 200, 175);  
        text("Combined Snake Size: " + str((snakesize-1) + (snakesize2-1)), 200, 200);
        text("Press SHIFT to RESTART", 200, 225);
        stopgame=true;
      }
      if (headx1[1]>=(width-8) || heady1[1]>=(height-8) || headx1[1]<=0 || heady1[1]<=0) {
        fill(255);
        rect(125, 125, 160, 100);
        fill(0);
        text("GAME OVER", 200, 150);
        text("Score: "+ str((snakesize-4) + (snakesize2-4)), 200, 175);  
        text("Combined Snake Size: " + str((snakesize-1) + (snakesize2-1)), 200, 200);
        text("Press SHIFT to RESTART", 200, 225);
        stopgame=true;
      }
    }
  }
  for (int i=2; i<=snakesize2; i++) {
    if (!stopgame) {
      if (headx2[1]==headx2[i] && heady2[1]==heady2[i] || headx1[1] == headx2[1] && heady1[1] == heady2[1] || headx2[i] == headx1[1] && heady2[i] == heady1[1]) {
        fill(255);
        rect(125, 125, 160, 100);
        fill(0);
        text("GAME OVER", 200, 150);
        text("Score: "+ str((snakesize-4) + (snakesize2-4)), 200, 175);  
        text("Combined Snake Size: " + str((snakesize-1) + (snakesize2-1)), 200, 200);
        text("Press SHIFT to RESTART", 200, 225);
        stopgame=true;
      }
      if (headx2[1]>=(width-8) || heady2[1]>=(height-8) || headx2[1]<=0 || heady2[1]<=0) {
        fill(255);
        rect(125, 125, 160, 100);
        fill(0);
        text("GAME OVER", 200, 150);
        text("Score: "+ str((snakesize-4) + (snakesize2-4)), 200, 175);  
        text("Combined Snake Size: " + str((snakesize-1) + (snakesize2-1)), 200, 200);
        text("Press SHIFT to RESTART", 200, 225);
        stopgame=true;
      }
    }
  }
}

void newGame() {
  background(255);
  headx1[1]=200;
  heady1[1]=200;
  headx2[1]=200;
  heady2[1]=200;
  for (int i=2; i<1000; i++) {
    headx1[i]=0;
    heady1[i]=0;
    headx2[i]=0;
    heady2[i]=0;
  }
  stopgame=false;
  redSquarex=(round(random(47))+1)*8;
  redSquarey=(round(random(47))+1)*8;
  snakesize=5;
  snakesize2=5;
  time1=0;
  direction1=0;
  direction2=180;
  restart=true;
}

void keyPressed() {
  // Snake 1
  if (keyCode == UP && direction1!=270 && (heady1[1]-8)!=heady1[2]) {
    direction1=90;
  }
  if (keyCode == DOWN && direction1!=90 && (heady1[1]+8)!=heady1[2]) {
    direction1=270;
  }
  if (keyCode == LEFT && direction1!=0 && (headx1[1]-8)!=headx1[2]) {
    direction1=180;
  }
  if (keyCode == RIGHT && direction1!=180 && (headx1[1]+8)!=headx1[2]) {
    direction1=0;
  }
  if (keyCode == SHIFT) {
    state = 0;
  }

  // Snake 2
  if (key == 'w' || key == 'W' && direction2!=270 && (heady2[1]-8)!=heady2[2]) {
    direction2=90;
  }
  if (key == 's' || key == 'S' && direction2!=90 && (heady2[1]+8)!=heady2[2]) {
    direction2=270;
  }
  if (key == 'a' || key == 'A' && direction2!=0 && (headx2[1]-8)!=headx2[2]) {
    direction2=180;
  }
  if (key == 'd' || key == 'D' && direction2!=180 && (headx2[1]+8)!=headx2[2]) {
    direction2=0;
  }
  if (keyCode == SHIFT) {
    state = 0;
  }
}
