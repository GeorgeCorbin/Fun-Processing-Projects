class Obstacle
{
  float x,y;
  int h;
  float v;

  void show()
  {
    ellipse(x,y,h,h);
    if(dist(a,b,x,y)<10)
    {
      background(250,0,0);
      //println(score);
      //score=score-10;
      state = 2;
    }
    if(score<0)
    {
      state=2;
    }
    if(y>650)
    {
      x=random(70,280);
    }
    if(y>650)
    {
      y=0;
    }
  }

  void energy()
  {
    y+= (h + height/2)*v;
  }
}
