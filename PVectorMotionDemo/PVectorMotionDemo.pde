// This isn't the interesting part.
// Check out the particle class.

ArrayList<Particle> particles = new ArrayList<Particle>(1000);
PImage kirby;

void setup () {
  size(500, 500);
  noStroke();
  kirby = loadImage("kirby.jpg");
  kirby.resize(width, height);
  //image(kirby, 0, 0);
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      Particle p = new Particle(i * 10 + 7, j * 10 + 7, kirby.get(i * 10 + 7, j * 10 + 7));
      particles.add(p);
    }
  }
}

void draw() {
  background(0);
  //image(kirby, 0, 0);
  for (Particle p : particles) {
    p.update();
  }
  //particles.get(625).update(); 
}
