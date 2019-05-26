class Gun{
  float x,y;
  float damage;
  PShape gunny;
  PVector velocity;
  Bullet bType;
  float angle;
  Gun(float x, float y, float d, PVector v){
    this.x = x; this.y = y;
    damage = d; velocity = v; angle = 0;
    
    int armL = 50;
    int gunH = 22;
    gunny = createShape();
    gunny.beginShape();
    gunny.vertex(armL,0);
    gunny.vertex(armL,-gunH);
    gunny.vertex(armL+45,-gunH);
    gunny.vertex(armL+45, -10);
    gunny.vertex(armL+10,-10);
    gunny.vertex(armL+10, 10);
    gunny.vertex(armL,10);
    gunny.endShape(CLOSE);
    gunny.setFill(0);
    stroke(0);
    
  }
  PShape getShape(){
    return gunny;
  }
  void rotateShape(float mouseAngle){
    gunny.rotate(-angle);
    if (mouseAngle > HALF_PI || mouseAngle < -HALF_PI){
      gunny.rotate(-mouseAngle);
      angle = -mouseAngle;
    }
    else{
      gunny.rotate(mouseAngle);
      angle = mouseAngle;
    }
  }
  
  void shoot(float x, float y){
    PVector bv = new PVector(cos(angle)*10, sin(angle)*10);
    if (angle > HALF_PI || angle < -HALF_PI){
      bv = new PVector(cos(-angle)*10, sin(-angle)*10);
    }
    Bullet b = new Bullet(x,y,bv);
    println(angle);
    bullets.add(b);
  }
}
enum GunTypes{
  
}
