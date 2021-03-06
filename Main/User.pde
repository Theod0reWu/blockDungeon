  int mags = 1;
class User extends Person{
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
  Gun otherGun;
  float onScreenX, onScreenY;
  
  PVector v = new PVector(0,0);
  
  int health; int speed = 8;
  
  User(float x , float y){
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
    PShape eye = createShape(RECT, 70, 70/2 - 5, -70/2 - 5, 12);
    eye.setFill(eyeC);
    eye.setStroke(0);
    graphics.addChild(eye);
    PShape body = createShape(RECT, 70/4.0 ,70, 35, 70,0,0,10,10);
    body.setFill(bodyC);
    graphics.addChild(body);
    
    arm = createShape();
    arm.beginShape();
    arm.vertex(0,0); 
    arm.vertex(0,-10);
    arm.vertex(64,-10);
    arm.vertex(64, 10);
    arm.vertex(0,10);
    arm.endShape(CLOSE);
    arm.setFill(255);
    //graphics.addChild(arm); I can't add it in correctly. arm is now seperately controlled
    
    onScreenX = width/2; onScreenY = height/2;
    strokeWeight(1);
    
    gun = new Gun(x+35, y+90, new PVector(0,0), 28, true);
    otherGun = new MachineGun(x+35, y+90, new PVector(0,0), 10, true);
    
    health = 120;
  }
  void moveDis(){
    pushMatrix();
    move();
    display();
    popMatrix();
    
  }
  void move(){ //println(neo.x+":"+ax);
    onScreenX = neo.x + ax; onScreenY = neo.y + ay; //println("screen:"+onScreenX + ":"+ onScreenY);
    onScreenX = width/2 + (onScreenX - width/2)*scale; onScreenY = height/2 + (onScreenY - height/2)*scale;
    mouseAngle = atan2(mouseY-onScreenY-90,mouseX-onScreenX-35);
    if ((mouseAngle <= HALF_PI && mouseAngle >= -HALF_PI) &&  !facing){flip = true; facing = true;}
    else if ((mouseAngle > HALF_PI || mouseAngle < -HALF_PI) &&  facing){flip = true; facing = false;}
    
    float ox = x; float oy = y; //original x and y
    //float speed = 7;
    //there might be faster way to detect walls while moving, but whatever
    if (keys[0]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,0,-speed)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (willTouch(e,0,-speed)){go=false; break;} 
      }
      if (go) {neo.y-=speed;}
    }
    if (keys[1]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,-speed,0)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (willTouch(e,-speed,0)){go=false; break;} 
      }
      if (go) {neo.x-=speed;}
    }
    if (keys[2]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,0,speed)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (willTouch(e,0,speed)){go=false; break;} 
      }
      if (go) {neo.y+=speed;}
    }
    if (keys[3]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,speed,0)){go = false; break;}
      }
      for (Enemy e :enemies){
       if (willTouch(e,speed,0)){go=false; break;} 
      }
      if (go) {neo.x+=speed;}
    }
    if (ox != x || oy != y){walk();}
    else{legBack();}
  };
  void legBack(){
    if (ltLeg > PI/8+.5){ltLeg-=PI/100;}
    else if (ltLeg < PI/8-.5){ltLeg+=PI/100;}
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
    fill(255);
    strokeWeight(3);
    aRect(x+35+5,y+140-5,20,60,rtLeg);
    aRect(x+35-5,y+140-5,20,60,ltLeg);
    strokeWeight(1);
    
    if(flip){
      graphics.translate(70,0);
      graphics.scale(-1,1);
      flip=false;
      otherGun.getShape().rotate(-otherGun.angle);
      otherGun.getShape().scale(1,-1);
      otherGun.getShape().rotate(otherGun.angle);
      
      gun.getShape().rotate(-gun.angle);
      gun.getShape().scale(1,-1);
      gun.getShape().rotate(gun.angle);
    }
    if (armAngle != mouseAngle){
      arm.rotate(mouseAngle - armAngle);
      gun.rotateShape(mouseAngle); otherGun.rotateShape(mouseAngle);
      armAngle = mouseAngle;
    }
    shape(graphics,x,y);
    shape(arm,x+35,y+90);
    shape(gun.getShape(),x+35,y+90);
    //line(x+35,y+90,mouseX,mouseY); //looks like laser pointer
  };
  void swapGun(){
    Gun temp = gun;
    gun = otherGun;
    otherGun = temp;
  }
  String toString(){
    return "("+x+","+y+") ";
  }
  float lastShot = frameCount;
  boolean first = false;
  void shoot(){//println(frameCount - rmenu);
    if (frameCount - lastShot > gun.fireRate && mousePressed && frameCount - rmenu > 5 && mouseButton == LEFT && !reloading){
      if (gun.inMag != 0 && !reloading){
        if (shellDropping.isPlaying()){shellDropping.pause();}
        shot.jump(0.1);
        first = true;
      }else {first = false;}
      gun.shoot(x+35,y+90);
      lastShot = frameCount;
      //sound effects
      //shot.pause();
      
      //if (shellDropping.isPlaying()){shellDropping.pause();}
    }
    if (frameCount - lastShot > gun.fireRate*2 / 3 &&  frameCount - lastShot < gun.fireRate*2/3 + 2 && first && !mousePressed){
      shellDropping.jump(0);
    }
  }
}

void aRect(float x, float y, float w, float h, float theta){ //theta is the angle from the veritcal, (x,y) is the middle of the upper width  
   pushMatrix();
   translate(x,y);
   rotate(theta);
   rect(-.5*w,0,w,h,10,10,0,0);
   popMatrix();
}
