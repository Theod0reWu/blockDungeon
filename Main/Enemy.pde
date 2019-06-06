int enemySpeed = 6;
class Enemy extends Person implements Collideable{
  float ltLeg = 0; // rotates >= 0
  float rtLeg = 0; // rotates <= 0
  boolean l = true;
  boolean r = false;
  static final float maxStep = PI/6;
  float armAngle, mouseAngle;
  PShape graphics;
  PShape arm;
  Boolean facing, flip; //true = right, false = left
  Gun gun;
  
  PVector v = new PVector(0,0);
  
  int health;
  
  float onScreenX, onScreenY;
  
  boolean emove[];
  int speed = 6;
  int mode = 0;
  // *****mode 0******|*****mode 1******|
  // --move randomly--|--run at player__|
  
  color suitC = color(40);
  int change = frameCount;
  
  int lastShot = frameCount;
  Enemy(float x, float y){
    super(x,y);
    ltLeg = PI/6; // PI/2 is max, 0 is min
    rtLeg = -PI/6;
    mouseAngle = atan2(mouseY-y,mouseX-x);
    armAngle = 0;
    
    facing = true;
    flip = false;
    
    w = 70;
    h = 200;
    //make the shape
    strokeWeight(3);
    graphics = createShape(GROUP);
    PShape head = createShape(RECT, 0,0,70,70,10,10,10,10);
    head.setFill(headC);
    graphics.addChild(head);
    PShape eye = createShape();
    eye.beginShape();
    eye.vertex(70,30);
    eye.vertex(35,30);
    eye.vertex(30,35);
    eye.vertex(35,40);
    eye.vertex(40,35);//bottom little hinge thing
    eye.vertex(50,35);
    eye.vertex(50,45);
    eye.vertex(70,45);
    eye.endShape(CLOSE);
    eye.setFill(0);
    eye.setStroke(0);
    graphics.addChild(eye);
    PShape body = createShape(RECT, 70/4.0 ,70, 35, 70,0,0,10,10);
    body.setFill(bodyC);
    
    PShape suit = createShape();
    suit.beginShape();
    suit.vertex(70/4.0,70);
    suit.vertex(70/4.0 + 17, 70);
    suit.vertex(70/4.0 + 35, 120);
    suit.vertex(70/4.0 + 35, 140);
    suit.vertex(70/4.0, 140);
    suit.endShape(CLOSE);
    suit.setFill(suitC);
    
    PShape tie = createShape();
    tie.beginShape();
    tie.vertex(70/4.0 + 35, 70);
    tie.vertex(70/4.0 + 28, 70);
    tie.vertex(70/4.0 + 35, 90);
    tie.vertex(70/4.0 + 28, 120);
    tie.vertex(70/4.0 + 35, 120);
    tie.endShape(CLOSE);
    tie.setFill(color(255,0,0));
    
    graphics.addChild(body);
    graphics.addChild(tie);
    graphics.addChild(suit);
    
    PShape arm = createShape();
    arm.beginShape();
    arm.vertex(0,0); 
    arm.vertex(0,-10);
    arm.vertex(64,-10);
    arm.vertex(64, 10);
    arm.vertex(0,10);
    arm.endShape(CLOSE);
    arm.setFill(255);
    PShape sleeve = createShape();
    sleeve.beginShape();
    sleeve.vertex(0,0);
    sleeve.vertex(0,-10);
    sleeve.vertex(43,-10);
    sleeve.vertex(43,10);
    sleeve.vertex(0,10);
    sleeve.endShape(CLOSE);
    sleeve.setFill(suitC);
    //arm.setFill(0);
    this.arm = createShape(GROUP);
    this.arm.addChild(arm);
    this.arm.addChild(sleeve);
    strokeWeight(1);
    
    gun = new Gun(x+35, y+90, new PVector(0,0), 60, false);
    if ((int)random(5) == 1){gun = new MachineGun(x+35, y+90, new PVector(0,0), 30, false);}
    gun.reloadTime = 120;
    
    health = (int)random(4)*10 + 20;
    
    onScreenX = x;
    onScreenY = y;
    
    emove = new boolean[4];
  }
  void move(){
    speed = enemySpeed;
    onScreenX = x;
    onScreenY = y;
    mouseAngle = atan2(neo.y-onScreenY,neo.x-onScreenX);
    if ((mouseAngle <= HALF_PI && mouseAngle >= -HALF_PI) &&  !facing){flip = true; facing = true;}
    else if ((mouseAngle > HALF_PI || mouseAngle < -HALF_PI) &&  facing){flip = true; facing = false;}
    //|*****mode 0******|*****mode 1******|
    //|--move randomly--|--run at player__|
    float ox = x; float oy = y;
    switch(mode){
     case 0:
     move(emove);
     break;
     case 1:
     
     break; 
    }
    if (ox != x || oy != y){walk();}
    if (frameCount - change > 20){emove = moveRandom();change = frameCount;}
  }
  boolean[] moveRandom(){
    boolean[] emove = new boolean[4];
    int direction = (int)random(9);
    emove = dToB(direction);
    return emove;
  }
  boolean canMove(int direction){
    boolean[] m = dToB(direction);
    move(m); boolean ans = true;
    
    if (m[0] || m[1]){move(dToB(direction+2));}
    else {move(dToB(direction-2));}
    return ans;
  }
  boolean[] dToB(int direction){
   switch(direction){
    case 0:
    return new boolean[]{true,false,false,false};
    case 1:
    return new boolean[]{false,true,false,false};
    case 2:
    return new boolean[]{false,false,true,false};
    case 3: 
    return new boolean[]{false,false,false,true};
    case 4:
    return new boolean[]{true,false,false,true};
    case 5:
    return new boolean[]{true,true,false,false};
    case 6:
    return new boolean[]{false,true,true,false};
    case 7:
    return new boolean[]{false,false,true,true};
   }
   return new boolean[4];
  }
  void move(boolean[] emove){
   if (emove[0]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,0,-speed)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (e != this && willTouch(e,0,-speed)){go=false; break;} 
      }
      if (willTouch(neo,0,-speed)){go = false;}
      if (go) {this.y-=speed;}
    }
    if (emove[1]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,-speed,0)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (e != this && willTouch(e,-speed,0)){go=false; break;} 
      }
      if (willTouch(neo,-speed,0)){go = false;}
      if (go) {this.x-=speed;}
    }
    if (emove[2]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,0,speed)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (e != this && willTouch(e,0,speed)){go=false; break;} 
      }
      if (willTouch(neo,0,speed)){go = false;}
      if (go) {this.y+=speed;}
    }
    if (emove[3]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,speed,0)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (e != this && willTouch(e,speed,0)){go=false; break;} 
      }
      if (willTouch(neo,speed,0
    )){go = false;}
      if (go) {this.x+=speed;}
    }
  }
  void walk(){//just the animation
    float i = 100; // increment
    
    if (ltLeg >= maxStep){l =true;}
    else if (ltLeg <= -.08){l = false;}
    if (l){ltLeg-=PI/i;}
    else{ltLeg+=PI/i;}
    
    if (rtLeg >= .08){r =true;}
    else if (rtLeg <= -maxStep){r = false;}
    if (r){rtLeg-=PI/i;}
    else{rtLeg+=PI/i;}
  }
  void display(){
    //float x = onScreenX; float y = onScreenY; //easier to display but might need to changed later
    fill(suitC);
    strokeWeight(3); stroke(0);
    aRect(x+35-5,y+140-5,20,60,ltLeg);
    aRect(x+35+5,y+140-5,20,60,rtLeg);
    strokeWeight(1);
    
    if(flip){
      graphics.translate(70,0);
      graphics.scale(-1,1);
      flip=false;
      gun.getShape().rotate(-gun.angle);
      gun.getShape().scale(1,-1);
      gun.getShape().rotate(gun.angle);
    }
    if (armAngle != mouseAngle){
      arm.rotate(mouseAngle - armAngle);
      gun.rotateShape(mouseAngle);
      armAngle = mouseAngle;
    }
    resetColors(); fill(255);
    shape(graphics,x,y);
    shape(arm,x+35,y+90);
    shape(gun.getShape(),x+35,y+90);
    //line(x+35,y+90,mouseX,mouseY); //looks like laser pointer
  };
  void shoot(){//println(frameCount - rmenu);
    if (frameCount - lastShot > gun.fireRate && sqrt(sq(neo.x-x)+sq(neo.y-y)) <= 1500 && !gun.relo){
        if (shellDropping.isPlaying()){shellDropping.pause();}
        if (!gun.relo){shot.jump(0.1);}
        gun.shoot(x+35,y+90);
        lastShot = frameCount;
    }else if (gun.inMag == 0) {gun.reload();}
    if (frameCount - lastShot > gun.fireRate*2 / 3 &&  frameCount - lastShot < gun.fireRate*2/3 + 2){
      shellDropping.jump(0);
    }
  }
}
