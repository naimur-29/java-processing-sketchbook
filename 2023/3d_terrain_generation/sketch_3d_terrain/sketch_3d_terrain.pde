int cols, rows;
int scale = 20;
int w = 3000;
int h = 1600;

float[][] terrain;
float flying = 0;

void setup() {
  size(600, 600, P3D);
  
  cols = w / scale;
  rows = h /scale;
  terrain = new float[cols][rows];
}

void draw() {
  flying -= 0.1;
  
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.15;
    }
    yoff += 0.15;
  }
  
  background(0);
  lights();
  stroke(0, 255, 0, 50);
  noFill();
  
  translate(width/2, height/2);
  rotateX(PI/2.5);
  
  translate(-w/2, -h/2);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scale, y * scale, terrain[x][y]);
      vertex(x * scale, (y + 1) * scale, terrain[x][y + 1]);
    }
    endShape();
  }
}
