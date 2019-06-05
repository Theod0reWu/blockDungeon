class Room{
  float x,y;
  float w,h;
  String[][] obstable;
  Room(float x, float y, float w, float h){
   this.x = x; this.y = y; this.w = w; this.h = h;
   //println(w+":"+h);
   
   
   //add some of those wall obstacles
   int obstacles = (int)random(5) + 5; int tries = 0;
   while (obstacles > 0 && tries < 1000){
     float rx = random(w) + x; float ry = random(h)+y;
     float rw = random(265)+70; float rh = random(265)+200;
     if (isValid(rx, ry, rw, rh)){walls.add(new Wall(rx, ry, rw, rh, wallColor)); obstacles--;} 
     tries++;
   }
  }
  void dis(){
    rect(x,y,w,h);
  }
  boolean isValid(float x, float y, float w, float h){
    for (Wall wall : walls){
     if (isTouchingWall(x,y,w,h,wall)){return false;} 
    }
    if (x+w < this.x + this.w - 100 && y + h < this.y + this.h - 250 && x > this.x + 100 && y > this.y + 250){return true;}    
    return false;
  }
  boolean isTouchingWall(float x, float y, float w, float h, Wall wall){
    if (x > wall.getX() + wall.getW() || wall.getX() > x + w){return false;}
    if (y > wall.getY() + wall.getH() || wall.getY() > y + h){return false;}
    return true;
  }
}
int floors = 3;
int rooms = 2;//acutally just the room lines should be even number
boolean[] visited = new boolean[(floors+1)*(rooms+1)-1];
void spawnEnemies(){
  
  
}
