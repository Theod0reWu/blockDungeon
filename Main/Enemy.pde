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
  // *****mode 1******|*****mode 2******|
  // --move randomly--|--run at player__|
  
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
    graphics.addChild(body);
    
    arm = createShape();
    arm.beginShape();
    arm.vertex(0,0); 
    arm.vertex(0,-10);
    arm.vertex(64,-10);
    arm.vertex(64, 10);
    arm.vertex(0,10);
    arm.endShape(CLOSE);
   
    strokeWeight(1);
    
    gun = new Gun(x+35, y+90, 10, new PVector(0,0), 50, false);
    
    health = 100;
    
    onScreenX = x;
    onScreenY = y;
    
    emove = new boolean[4];
  }
  void move(){
    onScreenX = x;
    onScreenY = y;
    mouseAngle = atan2(neo.y-onScreenY,neo.x-onScreenX);
    if ((mouseAngle <= HALF_PI && mouseAngle >= -HALF_PI) &&  !facing){flip = true; facing = true;}
    else if ((mouseAngle > HALF_PI || mouseAngle < -HALF_PI) &&  facing){flip = true; facing = false;}
    float ox = x; float oy = y;
    if (ox != x || oy != y){walk();} 
  }
  void move(boolean[] emove){
   if (emove[0]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,0,-speed)){go = false; break;}
      }
      if (go) {neo.y-=speed;}
    }
    if (emove[1]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,-speed,0)){go = false; break;}
      }
      if (go) {neo.x-=speed;}
    }
    if (emove[2]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,0,speed)){go = false; break;}
      }
      if (go) {neo.y+=speed;}
    }
    if (emove[3]){
      boolean go = true;
      for (Wall w : walls){
        if (willTouch(w,speed,0)){go = false; break;}
      }
      if (go) {neo.x+=speed;}
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
    fill(255);
    strokeWeight(3);
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
    shape(graphics,x,y);
    shape(arm,x+35,y+90);
    shape(gun.getShape(),x+35,y+90);
    //line(x+35,y+90,mouseX,mouseY); //looks like laser pointer
  };
}
