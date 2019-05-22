class Bullet implements Displayable, Moveable{
  float x,y;
  final PVector velocity;
  PShape bull;
  color c;
  Bullet(float x, float y, PVector v){
    this.x = x; this.y = y; velocity = v;
    
    c = color(250,208,56);
    bull = createShape();
    bull.beginShape();
    bull.vertex(0,0); 
    bull.vertex(0,-5);
    bull.vertex(20,-5);
    bull.vertex(20, 5);
    bull.vertex(0,5);
    bull.endShape(CLOSE);
    
    bull.rotate(atan2(velocity.x, velocity.y));
    bull.translate(x,y);
  }
  void move(){
    x+=velocity.x;
    y+=velocity.y;
    bull.translate(velocity.x, velocity.y);
  };
  void display(){
    shape(bull);
  };
}