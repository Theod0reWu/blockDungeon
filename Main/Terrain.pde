String[][] map;
void generateTerrain(){
  map = new String[100][100];
  //border
  int wallWidth = 100;
  int borderLength = 5000;
  color wallColor = color(100);
  //outer border
  walls.add(new Wall(0,0,borderLength+2*wallWidth,wallWidth,wallColor));
  walls.add(new Wall(0,0,wallWidth,borderLength+2*wallWidth,wallColor));
  walls.add(new Wall(borderLength+wallWidth,0, wallWidth,borderLength+2*wallWidth,wallColor));
  walls.add(new Wall(0,borderLength+wallWidth, borderLength+2*wallWidth,wallWidth, wallColor));
  // basic rooms
  
  
  //walls.add(new Wall(0,
}
void placeBackground(){ //colorful tile background thingy
  
}
class Wall implements Displayable, Collideable{
  float x,y,w,h; //top left corner
  color c;
  Wall(float x, float y, float w, float h, color c){
    this.x = x; this.y = y; this.w = w; this.h = h;
    this.c = c;
  }
  void display(){
    fill(c);
    noStroke();
    rect(x,y,w,h);
    stroke(0);
  }
  boolean isTouching(Collideable other){
    return true;
  }
  float getX(){return x;}
  float getY(){return y;}
  float getW(){return w;}
  float getH(){return h;}
  float getAngle(){return 0;}
}