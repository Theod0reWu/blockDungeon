class Bullet implements Displayable, Moveable{
  float x,y;
  final PVector velocity;
  PShape bull;
  Bullet(float x, float y, PVector v){
    this.x = x; this.y = y; velocity = v;
  }
  void move(){
    x+=velocity.x;
    y+=velocity.y;
  };
  void display(){
    
  };
}
