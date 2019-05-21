void generateTerrain(){
  //border
  noStroke();
  int wallWidth = 50;
  int borderLength = 10000;
  walls.add(new Wall(0,0,borderLength,wallWidth,color(200)));
  walls.add(new Wall(0,0,wallWidth,borderLength,color(200)));
  walls.add(new Wall(0,borderLength - wallWidth, wallWidth, borderLength, color(200)));
  walls.add(new Wall(borderLength-wallWidth,0, wallWidth, borderLength, color(200)));
}

class Wall implements Displayable{
  float x,y,w,h;
  color c;
  Wall(float x, float y, float w, float h, color c){
    this.x = x; this.y = y; this.w = w; this.h = h;
    this.c = c;
  }
  void display(){
    fill(c);
    rect(x,y,w,h);
  }
}