class User extends Person{
  float ltLeg = 0; // rotates >= 0
  float rtLeg = 0; // rotates <= 0
  boolean l = true;
  boolean r = false;
  static final float maxStep = PI/5;
  float armAngle, mouseAngle;
  PShape graphics;
  PShape arm;
  Boolean facing, flip; //true = right, false = left
  Bullet bType;
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
    arm.vertex(0,-12);
    arm.vertex(64,-12);
    arm.vertex(64, 8);
    arm.vertex(0,8);
    arm.endShape(CLOSE);
    //graphics.addChild(arm); I can't add it in correctly. arm is now seperately controlled
    
    
    strokeWeight(1);
  }
  void moveDis(){
    pushMatrix();
    move();
    display();
    popMatrix();
    
  }
  void move(){
    mouseAngle = atan2(mouseY-y-90,mouseX-x-35);
    if ((mouseAngle < HALF_PI && mouseAngle > -HALF_PI) &&  !facing){flip = true; facing = true;}
    else if ((mouseAngle > HALF_PI || mouseAngle < -HALF_PI) &&  facing){flip = true; facing = false;}
  };
  void walk(){//just the animation
    float i = 100; // increment
    
    if (ltLeg >= maxStep){l =true;}
    else if (ltLeg <= -maxStep){l = false;}
    if (l){ltLeg-=PI/i;}
    else{ltLeg+=PI/i;}
    
    if (rtLeg >= maxStep){r =true;}
    else if (rtLeg <= -maxStep){r = false;}
    if (r){rtLeg-=PI/i;}
    else{rtLeg+=PI/i;}
    
  }
  void display(){
    if(flip){
      graphics.translate(70,0);
      graphics.scale(-1,1);
      flip=false;
    }
    shape(graphics,x,y);
    if (armAngle != mouseAngle){
      arm.rotate(mouseAngle - armAngle);
      armAngle = mouseAngle;
    }
    //println(degrees(armAngle));
    shape(arm,x+35,y+90);
    //line(x+35,y+90,mouseX,mouseY); looks like laser pointer
  };
  String toString(){
    return "("+x+","+y+") ";
  }
  void shoot(){
    
  }
}
