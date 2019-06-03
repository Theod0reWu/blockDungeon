String[][] map;
int floors = 6;
int rooms = 4;//acutally just the room lines
int borderLength = 6000;
int wallWidth = 100;
color wallColor = color(100);
void generateTerrain(){
  resetColors();
  map = new String[100][100];
  //border
  borderLength = 6000;
  int doorway = 500;
  
  int tw = borderLength+2*wallWidth; //total width
  //outer border
  walls.add(new Wall(0,0,tw,wallWidth,wallColor));
  walls.add(new Wall(0,0,wallWidth,tw,wallColor));
  walls.add(new Wall(borderLength+wallWidth,0, wallWidth,tw,wallColor));
  walls.add(new Wall(0,borderLength+wallWidth, tw,wallWidth, wallColor));
  // basic rooms
  int x = 0;
  for (float f = borderLength/floors; f <= borderLength - 500; f+=borderLength/floors, x++){
    if (x%2 == 0){walls.add(new Wall(0,f, tw-500, wallWidth, wallColor));}
    else {walls.add(new Wall(500,f, tw-500, wallWidth, wallColor));}
  }
  //starting room
  for (float f = 0; f <= borderLength - 500; f+=borderLength/floors){
    int up = 0;
    if (f%2==0){up = 1;}
    for (int r = borderLength/(rooms+1); r < borderLength; r+=borderLength/(rooms+1), up++){
      int d =250+wallWidth;
      if (up%2==1){d=0;}
      walls.add(new Wall(r,f+d,wallWidth,borderLength/floors - 250, wallColor)); 
    }
  }
}
void placeBackground(){ //colorful tile background custom background
  resetColors();
  fill(200);
  rect(0,0,borderLength+2*wallWidth, borderLength+2*wallWidth);
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
