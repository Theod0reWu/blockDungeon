class Room{
  float x,y;
  float w,h;
  String[][] obstable;
  Room(float x, float y, float w, float h){
   this.x = x; this.y = y; this.w = w; this.h = h;
   //println(w+":"+h);
   
   
   //add some of those wall obstacles
   int obstacles = (int)random(10) + 5;
   while (obstacles > 0){
     float rx = random(w) + x; float ry = random(h)+y;
     float rw = random(265)+35; float rh = random(265)+35;
     if (isValid(rx, ry, rw, rh)){walls.add(new Wall(rx, ry, rw, rh, wallColor)); obstacles--;} 
   }
  }
  void dis(){
    rect(x,y,w,h);
  }
  boolean isValid(float x, float y, float w, float h){
    if (x+w > this.x + this.w || y + h > this.y + this.h){return false;}
    
    for(float cx = this.x; cx <= this.x+w; cx+=w){
     for  (float cy = this.y; cy <= this.y+h;cy+=h){
       if (cy == y && sqrt(sq(x - cx)+sq(y - cy)) <= 350){return false;}
       else if (sqrt(sq((x+w) - cx) + sq(y - cy)) <= 350) {return false;}
     }
    }
    
    return true;
  }
}
int floors = 3;
int rooms = 2;//acutally just the room lines should be even number
boolean[] visited = new boolean[(floors+1)*(rooms+1)-1];
void spawnEnemies(){
  
  
}
