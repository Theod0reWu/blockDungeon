abstract class Person implements Displayable, Moveable, Collideable{
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
    h = 140;
    
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
  
  float getX(){return x;}float getY(){return y;}
  float getW(){return w;}float getH(){return h;}
  boolean isTouching(Collideable other){ //people will only be able to see if they hit walls(kinda like real life, cause you can't really see the bullets
    if (getX() > other.getX() + other.getW() || other.getX() > getX() + getW()){return false;}
    if (getY() > other.getY() + other.getH() || other.getY() > getY() + getH()){return false;}
    return true;
  }
  boolean willTouch(Collideable other, float dx, float dy){
    boolean ans = false;
    x+=dx; y+=dy;
    if (isTouching(other)){ans = true;}
    x-=dx; y-=dy;
    return ans;
  }
}
