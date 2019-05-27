void generateTerrain(){
  //border
  int wallWidth = 80;
  int borderLength = 10000;
  color wallColor = color(150);
  walls.add(new Wall(0,0,borderLength,wallWidth,wallColor));
  walls.add(new Wall(0,0,wallWidth,borderLength,wallColor));
  walls.add(new Wall(0,borderLength - wallWidth, wallWidth, borderLength, wallColor));
  walls.add(new Wall(borderLength-wallWidth,0, wallWidth, borderLength, wallColor));
  
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
