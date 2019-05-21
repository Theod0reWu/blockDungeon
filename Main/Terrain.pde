void generateTerrain(){
  //border
  noStroke();
  walls.add(new Wall(0,0,10000,50,color(200)));
  walls.add(new Wall(0,50,50,10000,color(200)));
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
