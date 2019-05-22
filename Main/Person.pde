abstract class Person implements Displayable, Moveable{
  float x,y; //top left corner
  float w, h; //how wide or tall someone is
  float armAngle;
  color headC,bodyC, armC, legC, eyeC;
  float headSize;
  PVector v;
  Person(float x, float y){
    this.x = x;
    this.y = y;
    
    headC = color(255,255,255);
    bodyC = color(255,255,255);
    armC = color(255,255,255);
    legC = color(255,255,255);
    eyeC = color(255,0,0);
    
    w = 70;
    h = w + 1.7*w + .7*1.7*w;
    
    armAngle = 0;
    headSize = 60;
  }
  Person(float x, float y, float w){
    this(x,y);
    this.w = w;
    h = w + 1.7*w + .7*1.7*w;
  }
  abstract void move();
  abstract void display();
}