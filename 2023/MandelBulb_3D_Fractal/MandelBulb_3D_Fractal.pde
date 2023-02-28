import peasy.*;

int DIM = 128;
PeasyCam cam;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

//void createCube(int dimension, float posX, float posY) {
//  for (int i = 0; i < dimension; i++) {
//    for (int j = 0; j < dimension; j++) {
//      for (int k = 0; k < dimension; k++) {
//        float x = map(i, 0, DIM, posX, posY);
//        float y = map(j, 0, DIM, posX, posY);
//        float z = map(k, 0, DIM, posX, posY);
        
//        point(x, y, z);
//      }
//    }
//  }
//}

class Spherical {
  float r, theta, phi;
  
  Spherical(float r, float theta, float phi) {
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
}

Spherical spherical(float x, float y, float z) {
  float r = sqrt(x*x + y*y + z*z);
  float theta = atan2(sqrt(x*x + y*y), z);
  float phi = atan2(y, x);
  
  return new Spherical(r, theta, phi);
}

void setup() {
  size (600, 600, P3D);
  cam = new PeasyCam(this, 500);

  for (int i = 0; i < DIM; i++) {
    for (int j = 0; j < DIM; j++) {
      
      boolean isEdge = false;
      for (int k = 0; k < DIM; k++) {
        float x = map(i, 0, DIM, -1, 1);
        float y = map(j, 0, DIM, -1, 1);
        float z = map(k, 0, DIM, -1, 1);
        
        PVector zeta = new PVector(0, 0, 0);
        int n = 16;
        
        int maxIterations = 10;
        int iterations = 0;
        while(true) {
          Spherical sphericalZ = spherical(zeta.x, zeta.y, zeta.z);
          
          float newX = pow(sphericalZ.r, n) * sin(sphericalZ.theta*n) * cos(sphericalZ.phi*n);
          float newY = pow(sphericalZ.r, n) * sin(sphericalZ.theta*n) * sin(sphericalZ.phi*n);
          float newZ = pow(sphericalZ.r, n) * cos(sphericalZ.theta*n);
          
          zeta.x = newX + x;
          zeta.y = newY + y;
          zeta.z = newZ + z;
          iterations++;
          
          if (sphericalZ.r > 2) {
            isEdge = !isEdge;
            break;
          }
          if (iterations > maxIterations) {
            if (!isEdge) {
              isEdge = true;
              mandelbulb.add(new PVector(x*100, y*100, z*100));
            }
            break;
          }
        }
      }
    }
  }
}

void draw() {
  background(0);

  for (PVector p : mandelbulb) {
    stroke(255);
    point(p.x, p.y, p.z);
  }
}
