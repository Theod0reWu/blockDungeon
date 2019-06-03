float bSpeed = 35;
class Gun{
  float x,y;
  int damage;
  PShape gunny;
  PVector velocity;
  Bullet bType;
  float angle;
  float fireRate; //inverse higher num, lower actual rate
  
  float gunFactorX;
  float gunFactorY;
  
  int armL;
  int gunH;
  
  boolean good;
  
  int reloadTimer = 0;
  int reloadTime = 60;
  int magCapacity = 7;
  int inMag;
  
  float rand = .1;
  Gun(float x, float y, int d, PVector v, float fr, boolean good){
    this.x = x; this.y = y; //v.x+=random(.4)-.2;v.y+=random(.4)-.2;
    damage = d; velocity = v; angle = 0;
    fireRate = fr;
    this.good = good;
    inMag = magCapacity;
    
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
    if (inMag == 0){dryGun.jump(0);return;}
    inMag--;
    float a = angle;
    float cartAngle = angle - HALF_PI;
    gunFactorX = armL*cos(a)+(gunH-5)*cos(a-HALF_PI);
    gunFactorY = armL*sin(a)+(gunH-5)*sin(a-HALF_PI);
    if (a <= HALF_PI && a >= -HALF_PI){
      gunFactorX = armL*cos(a)+(gunH-5)*cos(a-HALF_PI);
      gunFactorY = -1*(armL*sin(a)+(gunH-5)*sin(a-HALF_PI));
      cartAngle = angle + HALF_PI;
    }
    //println(degrees(a));
    float speed = bSpeed; // cannot be higher than wall thickness
    float randFactor = random(rand)-rand/2;
    PVector bv = new PVector(cos(angle+randFactor)*speed, sin(angle+randFactor)*speed);
    if (angle > HALF_PI || angle < -HALF_PI){
      bv = new PVector(cos(-angle+randFactor)*speed, sin(-angle+randFactor)*speed);
    }
    Bullet b = new Bullet(x+gunFactorX,y-gunFactorY,bv,good, damage);
    //println(angle);
    bullets.add(b);
    //println("o: "+b.x+":"+ b.y);
    //println("b: "+b.getX()+":"+ b.getY());
    //special effects
    Cartridge c = new Cartridge(x+gunFactorX+random(15)-7, y-gunFactorY, bv.heading(), new PVector(random(.1)-.05,5));
    cartridges.add(c);
  }
  void reload(){ //println(reloadTimer);
    if (reloadTimer == 1){clip.jump(0);}
    if (reloadTimer == reloadTime){
      reloadTimer = 0;
      reload.jump(0); 
      inMag = magCapacity;
      reloading = false;
    }
    ++reloadTimer;
  }
}
class MachineGun extends Gun{
  MachineGun(float x, float y, int d, PVector v, float fr, boolean good){
    super(x,y,d,v,fr,good);
    stroke(0); strokeWeight(2);
    fill(#5D5A5A);
    PShape bull = createShape(GROUP);
    PShape stock = createShape();
    stock.beginShape();
    stock.vertex(5,0);
    stock.vertex(5,-20);
    stock.vertex(45,-20);
    stock.vertex(45,-12);
    stock.vertex(10,8);
    stock.vertex(5, 8);
    stock.endShape(CLOSE);
    stock.fill(#484141);
    PShape body = createShape();
    body.beginShape();
    body.vertex(45,-24);
    body.vertex(45,-8);
    body.vertex(50,-8);
    body.vertex(45,10);
    body.vertex(54,10);
    body.vertex(60,-8);
    body.vertex(64,-8);
    body.vertex(64,-10);
    body.vertex(72,-10);
    body.vertex(72,-8);
    body.vertex(80, -8);
    body.vertex(80, -24);
    body.endShape(CLOSE);
    PShape barrel = createShape();
    barrel.beginShape();
    barrel.vertex(80,-24);
    barrel.vertex(100,-24);
    barrel.vertex(100,-14);
    barrel.vertex(90,-14);
    barrel.vertex(90,-10);
    barrel.vertex(80,-10);
    barrel.endShape(CLOSE);
    
    PShape muzzle = createShape();
    muzzle.beginShape();
    muzzle.vertex(100,-20);
    muzzle.vertex(120, -20);
    muzzle.vertex(120, -14);
    muzzle.vertex(100,-14);
    muzzle.endShape(CLOSE);
    PShape mag = createShape();
    mag.beginShape();
    mag.vertex(72,-8);
    mag.vertex(72,0);
    mag.vertex(74,0);
    mag.vertex(74,6);
    mag.vertex(76,6);
    mag.vertex(76,10);
    //mag.vertex(
    mag.vertex(84,10);
    mag.vertex(84,6);
    mag.vertex(82,6);
    mag.vertex(82,0);
    mag.vertex(80,0);
    mag.vertex(80,-8);
    mag.endShape(CLOSE);
    
    fill(0);
    PShape top = createShape(RECT, 52, -24, 2, -5);
    PShape handle = createShape(RECT, 52,-29,24,-2);
    PShape nib = createShape(RECT, 76, -24, 2, -3);
    
    bull.addChild(stock);
    bull.addChild(body);
    bull.addChild(top);
    bull.addChild(handle);
    bull.addChild(nib);
    bull.addChild(barrel);
    bull.addChild(muzzle);
    bull.addChild(mag);
    
    gunny = bull;
    
    magCapacity = 24;
    inMag = 24;
    reloadTime = 90;
    rand = .2;
    fill(255);
  }
}
