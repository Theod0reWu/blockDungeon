class Room implements Collideable{
  float x,y;
  float w,h;
  int id;
  String[][] obstable;
  boolean spawnt = false;
  Room(float x, float y, float w, float h){
   this.x = x; this.y = y; this.w = w; this.h = h;
   //println(w+":"+h);
   
   
   //add some of those wall obstacles
   //println(w+":"+h);
   int obstacles = (int)random(w*h/700000); int tries = 0;
   if ((int)(w*h/700000) >= 1){obstacles += (int)(w*h/700000);}
   else {obstacles += 1;}
   while (obstacles > 0 && tries < 1000){
     float rx = random(w) + x; float ry = random(h)+y;
     float rw = random(265)+70; float rh = random(265)+200;
     if (isValid(rx, ry, rw, rh)){walls.add(new Wall(rx, ry, rw, rh, color(random(100) + 50))); obstacles--;} 
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
    for (Enemy e: enemies){
     if (isTouchingWall(x,y,w,h,e)){return false;} 
    }
    if (x+w < this.x + this.w - 100 && y + h < this.y + this.h - 250 && x > this.x + 100 && y > this.y + 250){return true;}    
    return false;
  }
  boolean isTouchingWall(float x, float y, float w, float h, Collideable wall){
    if (x > wall.getX() + wall.getW() || wall.getX() > x + w){return false;}
    if (y > wall.getY() + wall.getH() || wall.getY() > y + h){return false;}
    return true;
  }
  void spawnEnemies(){
    int rNum = (int)random(w*h/800000);
    if ((int)(w*h/800000) >= 2){rNum += (int)(w*h/800000);}
    else {rNum += 2;}
    int tries = 0;
    while (rNum > 0 && tries < 1000 && !spawnt){
      float rx = random(w) + x; float ry = random(h)+y;
      if (isValid(rx,ry,70,200)){enemies.add(new Enemy(rx,ry)); rNum--;}
    }
    spawnt = true;
  }
  float getX(){return x;}float getY(){return y;}
  float getW(){return w;}float getH(){return h;}
  boolean isTouching(Collideable other){ //people will only be able to see if they hit walls(kinda like real life, cause you can't really see the bullets
    if (getX() > other.getX() + other.getW() || other.getX() > getX() + getW()){return false;}
    if (getY() > other.getY() + other.getH() || other.getY() > getY() + getH()){return false;}
    return true;
  }
}
int floors = 3;
int rooms = 4;//acutally just the room lines should be even number
boolean[] visited = new boolean[(floors+1)*(rooms+1)-1];
