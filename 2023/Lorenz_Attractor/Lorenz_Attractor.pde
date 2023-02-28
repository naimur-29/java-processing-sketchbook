import peasy.*;

float x = 0.01, y = 0, z = 0;
float SIGMA = 10, RHO = 28, BETA = 8/3;

ArrayList<PVector> points = new ArrayList<PVector> ();

PeasyCam camera;

void setup() {
  size(1080, 720, P3D);
  colorMode(HSB);
  camera = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  
  float dt = 0.005;
  float dx = SIGMA * (y - x);
  float dy = x * (RHO - z) - y;
  float dz = x * y - BETA * z;
  
  x += dx * dt;
  y += dy * dt;
  z += dz * dt;
  
  points.add(new PVector(x, y, z));
  
  translate(0, 0, -80);
  scale(5);
  strokeWeight(0.5);
  noFill();
  
  float hue = 0;
  beginShape();
  for (PVector v : points) {
    stroke(hue, 220, 255);
    vertex(v.x, v.y, v.z);
    
    hue += 1;
    if (hue >= 255) {
      hue = 0;
    }
  }
  endShape();
  
  println(x, y, z);
}
