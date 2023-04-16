// 

Obstacle[] obstacles;
int state;
int a=175;
int b=600;
int d=-650;
int f=-1300;
int score;
float a1, b1;

void setup()
{
  size (350, 650);  
  //size (640, 480);
  rectMode(CENTER);
  state = 0;
  score =0;
  a=175;
  b=600;
  obstacles = new Obstacle[11];
  for (int i=0; i<11; i++)
  {
    obstacles[i] = new Obstacle();
    obstacles[i].x = random(175, 200);
    obstacles[i].y = 0;
    obstacles[i].h = (int)random(7, 10);
    obstacles[i].v = 0.01;
    obstacles[i].show();
    obstacles[i].energy();
  }
  obstacles[1].x=random(80, 200);
  obstacles[2].x=random(80, 200);
  obstacles[3].x=random(80, 200);
  obstacles[4].x=random(80, 200);
  obstacles[5].x=random(80, 200);
  obstacles[6].x=random(80, 200);
  obstacles[7].x=random(80, 200);
  obstacles[8].x=random(80, 200);
  obstacles[9].x=random(80, 200);
  obstacles[10].x=random(80, 200);
}
void draw ()
{
  background(0);
  if (state==0)
  {


    background(255, 255, 255);
    fill(22, 3, 252);
    textSize(20);
    text("Press space to Start", 150, 200);
    textSize(15);
    fill(255, 0, 0);
    text("Use Arrow keys to move", 100, 250);
    if (key == ' ') state=1;
  } else if (state==1) {
    rectMode(LEFT);
    background(0);
    
    fill(#00ff00);
    rect(0, 0, 65, height);
    rect(280, 0, width, height);
    rectMode(CENTER);
    fill(255);
    text("Score: " + score, 125, 100);
    fill(0);
    text("Wall", 30, height/2);
    text("Wall", 310, height/2);
    car();
    move();
    for (int i=0; i<11; i++)
    {
      obstacles[i].show();
      obstacles[i].energy();
      if (b < obstacles[i].y) {
        score = score + 1;
      }
    }
  } else if (state==2) {
    textSize(20);
    text("GAME OVER", 150, 150);
    text("PRESS R AND START AGAIN", 50, 175);
  }
}
void car () {


  if (b<600)
  {
    f= f+1;
    d =d+1;
  }

  if (d >650)
  {
    d=-1300;
    d= d+1;
  }
  fill(32, 102, 125);
  rect(a, b, 10, 10);
  fill(255, 13, 17);
  rect(b1, a1, 20, 20);
  {
    a1=a1+5;
  }
  if (a1>650)
  {
    a1=0;
    b1=random(150, 250);
  }
  if (a<75)
  {
    a=a+5;
  }
  if (a>275)
  {
    a=a-5;
  }
  if (b>height)
  {
    state=2;
  }
  if (b<0)
  {
    state=2;
  }
  if (dist(a, b, b1, a1)<15) {
    state = 2;
  }
}

boolean rightpressed, leftpressed, uppressed;
boolean rrightpressed, rleftpressed, ruppressed;

void keyPressed()
{
  if (keyCode == RIGHT ) rightpressed = true;
  if (keyCode == LEFT)leftpressed = true;
  if (keyCode == UP) uppressed = true;
  if (key == 'r') {
    setup();
    state = 1;
  }
}

void keyReleased()
{
  if (keyCode == RIGHT ) rightpressed= false;
  if (keyCode == LEFT)leftpressed=false;
  if (keyCode == UP) uppressed =false;
}

void move()
{
  b+=1;
  if (rightpressed) a+=4;
  if (leftpressed) a-=4;
  if (uppressed) b-=4;
}
