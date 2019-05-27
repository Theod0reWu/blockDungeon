class Gun{
  float x,y;
  float damage;
  PShape gunny;
  PVector velocity;
  Bullet bType;
  float angle;
  float fireRate;
  
  float gunFactorX;
  float gunFactorY;
  
  int armL;
  int gunH;
  Gun(float x, float y, float d, PVector v, float fr){
    this.x = x; this.y = y;
    damage = d; velocity = v; angle = 0;
    fireRate = fr;
    
    armL = 50;
    gunH = 22;
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
    float a = angle;
    float m = pyth(gunH-5,armL);
    gunFactorX = armL*cos(a)+(gunH-5)*cos(a-HALF_PI);
    gunFactorY = armL*sin(a)+(gunH-5)*sin(a-HALF_PI);
    if (a < HALF_PI && a > -HALF_PI){
      gunFactorX = armL*cos(a)+(gunH-5)*cos(a-HALF_PI);
      gunFactorY = -1*(armL*sin(a)+(gunH-5)*sin(a-HALF_PI));
    }
    //println(degrees(a));
    float speed = 28; // cannot be higher than wall thickness
    PVector bv = new PVector(cos(angle)*speed, sin(angle)*speed);
    if (angle > HALF_PI || angle < -HALF_PI){
      bv = new PVector(cos(-angle)*speed, sin(-angle)*speed);
    }
    Bullet b = new Bullet(x+gunFactorX,y-gunFactorY,bv,true);
    //println(angle);
    bullets.add(b);
    //println("o: "+b.x+":"+ b.y);
    //println("b: "+b.getX()+":"+ b.getY());
    //special effects
    cartridges.add(new Cartridge(x+gunFactorX, y-gunFactorY, bv.heading(), new PVector(sin(angle+HALF_PI), cos(angle+HALF_PI))));
  }
}
enum GunTypes{
  
}
