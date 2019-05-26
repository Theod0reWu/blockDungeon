class Bullet implements Displayable, Moveable{
  float x,y;
  float damage;
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
    bull.vertex(25,0);
    bull.vertex(20, 5);
    bull.vertex(0,5);
    bull.endShape(CLOSE);
    
    bull.rotate(atan2(velocity.y, velocity.x));
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
}
