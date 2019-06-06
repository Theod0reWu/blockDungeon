String[][] map;
int borderLength = 6000;
int wallWidth = 100;
color wallColor = color(100);
void generateTerrain(){
  resetColors();
  map = new String[100][100];
  //border
  borderLength = 6000;
  int doorway = 300;
  
  int tw = borderLength+2*wallWidth; //total width
  //outer border
  walls.add(new Wall(0,0,tw,wallWidth,wallColor));
  walls.add(new Wall(0,0,wallWidth,tw,wallColor));
  walls.add(new Wall(borderLength+wallWidth,0, wallWidth,tw,wallColor));
  walls.add(new Wall(0,borderLength+wallWidth, tw,wallWidth, wallColor));
  // basic rooms
  int x = 0;
  for (float f = borderLength/floors; f <= borderLength - 500; f+=borderLength/floors, x++){
    if (x%2 == 0){walls.add(new Wall(0,f, tw-doorway, wallWidth, wallColor));}
    else {walls.add(new Wall(doorway,f, tw-doorway, wallWidth, wallColor));}
    float w = borderLength - f;
    if (f+borderLength/floors <= borderLength-500){w=borderLength/floors-wallWidth;}
    areas.add(new Room(wallWidth,f+wallWidth, borderLength/(rooms+1)-wallWidth,w));
  }
  //starting room
  x = 0;
  for (float f = 0; f <= borderLength - 500; f+=borderLength/floors,x++){
    int up = 0;
    if (x%2==0){up = 1;}
    for (int r = borderLength/(rooms+1); r < borderLength - 140; r+=borderLength/(rooms+1), up++){
      int d =300+wallWidth;
      if (up%2==1){d=0;}
      walls.add(new Wall(r,f+d,wallWidth,borderLength/floors - 300, wallColor)); 
      float h = borderLength-f; float w = borderLength-r;
      if (f+borderLength/floors <= borderLength-500){h=borderLength/floors-wallWidth;}
      if (r + borderLength/(rooms+1) < borderLength){w = borderLength/(rooms+1)-wallWidth;}
      areas.add(new Room (r+wallWidth,f+wallWidth,w,h));
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
