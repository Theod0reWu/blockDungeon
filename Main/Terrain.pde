void generateTerrain(){
  //border
  
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