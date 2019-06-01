class Bullet implements Displayable, Moveable, Collideable{
  float x,y;
  float w,h;
  float damage;
  final PVector velocity;
  PShape bull;
  color c;
  float angle; 
  boolean good; //sees if bullets is enemy bullet or player bullet
  Bullet(float x, float y, PVector v, boolean good){
    this.x = x; this.y = y; //midpoint of side nearest to the player
    //println("b:" + x+":"+y);
    velocity = v;
    w = 20; 
    h = 10;
    angle = velocity.heading();//atan2(velocity.y, velocity.x);
    this.good = good;
    
    damage = 50;
    
    c = color(250,208,56);
    bull = createShape();
    bull.beginShape();
    bull.vertex(0,0); 
    bull.vertex(0,-5);
    bull.vertex(20,-5);
    bull.vertex(30,0);
    bull.vertex(20, 5);
    bull.vertex(0,5);
    bull.endShape(CLOSE);
    
    bull.rotate(angle);
    //bull.translate(x,y);
    bull.setFill(c);
  }
  void move(){
    x+=velocity.x;
    y+=velocity.y;
    //bull.translate(velocity.x, velocity.y);
  };
  void display(){
    pushMatrix();
    translate(x,y);
    shape(bull);
    popMatrix();
  };
  float getW(){return w;} 
  float getH(){return h;}
  float getX(){return x + w/2*cos(angle);}
  float getY(){return y + w/2*sin(angle);}
  boolean isTouching(Collideable other){ //slight breakage at shooting the corners
    float d = sqrt(sq(h)+sq(w));
    if (getY() >= other.getY() && getY() <= other.getY() + other.getH()){
      if (getX() < other.getX()){
        //println("1");
        d = ptl(getX(), getY(), 1, 0, -other.getX());
      }else if (getX() > other.getX() + other.getW()) { d = ptl(getX(), getY(), 1, 0, -other.getX()-other.getW());}
      else{ d= 0;}
    }else if (getX() >= other.getX() && getX() <= other.getX() + other.getW()){
      if (getY() < other.getY()){
        //println("3");
        d = ptl(getX(), getY(), 0, 1, -other.getY());
      } else { d = ptl(getX(), getY(), 0, 1, -other.getY()-other.getH()); }
    }
    //println(d);
    return d < sqrt(sq(h)+sq(w));
  }
}
float ptl(float px, float py, float a, float b, float c){ //point to line distance
  return abs(a*px + b*py + c) / sqrt(a*a+b*b);
}
