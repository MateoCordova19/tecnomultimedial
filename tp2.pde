int resolutionX = 800;
int resolutionY = 400;
PImage img;
// Variables de la ilusión óptica
int rectSize = 50;
float angle = 0;

void setup() {
   size(resolutionX, resolutionY);
   rectMode(CENTER);
   img = loadImage("IMG_0414.jpeg");
   
}

void draw() {
   background(250);
   image(img,0,0,400,400);// Variables de resolución
   drawIllusion(rectSize, angle);
   
   rectSize = map(mouseX, 0, width, 10, 200);
   angle += 0.01;
}

void drawIllusion(int size, float rotation) {
   for (int i = 400; i < resolutionX; i += size) {
      for (int j = 0; j < resolutionY; j += size) {
         pushMatrix();
         translate(i, j);
         rotate(rotation);
         
         if ((i / size) % 2 == 0) {
            fill(0);
         } else {
            fill(200);
         }
         
         rect(0, 0, size, size);
         popMatrix();
      }
   }
}

void keyPressed() {
   if (key == 'r' || key == 'R') {
      resetVariables();
   }
}

void resetVariables() {
   rectSize = 50;
   angle = 0;
}