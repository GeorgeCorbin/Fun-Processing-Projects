class Particle {

  PVector pos, vel, acc;
  color particleColor;
  PVector startingPosition;

  Particle(float x, float y, color c) {
    pos = new PVector(x, y);
    vel = new PVector();
    particleColor = c;
    startingPosition = new PVector(x, y);
  }

  void update() {
    if (mousePressed && dist(mouseX, mouseY, pos.x, pos.y) < 75) {
      accelerationController();
    } else {
      returnController();
    }
    fill(particleColor);
    ellipse(pos.x, pos.y, 14, 14);
  }

  void accelerationController() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector desiredVel = PVector.sub(pos, mouse);
    //desiredVel.setMag(500/desiredVel.mag());
    desiredVel.setMag(75 - desiredVel.mag());
    
    desiredVel.limit(10);
    PVector desiredAcc = PVector.sub(desiredVel, vel);
    desiredAcc.limit(1);
    acc = desiredAcc;
    vel.add(acc);
    pos.add(vel);
    vel.mult(0.95);
  }

  void returnController() {
    PVector desiredVel = PVector.sub(startingPosition, pos); 
    
    desiredVel.limit(10);
    PVector desiredAcc = PVector.sub(desiredVel, vel);
    desiredAcc.limit(1);
    acc = desiredAcc;
    vel.add(acc);
    pos.add(vel);
    vel.mult(0.95);
  }
}
