class User extends Person{
  float ltLeg = 0; // rotates >= 0
  float rtLeg = 0; // rotates <= 0
  boolean l = true;
  boolean r = false;
  static final float maxStep = PI/5;
  float armAngle,armX;
  PShape graphics;
  PShape arm;
  User(float x , float y){
    super(x,y);
    ltLeg = PI/6; // PI/2 is max, 0 is min
    rtLeg = -PI/6;
    armAngle = atan2(mouseY-y,mouseX-x);
    armX = .4*w;
    
    //make the shape
    strokeWeight(3);
    graphics = createShape(GROUP);
    PShape head = createShape(RECT, 0,0,70,70,10,10,10,10);
    head.setFill(headC);
    graphics.addChild(head);
    PShape eye = createShape(RECT, 70, 70/2 - 5, -70/2, 12);
    eye.setFill(eyeC);
    eye.setStroke(0);
    graphics.addChild(eye);
    PShape body = createShape(RECT, 70/4 ,70, 35, 70,0,0,10,10);
    body.setFill(bodyC);
    graphics.addChild(body);
    PShape arm = createShape();
    
    
    strokeWeight(1);
  }
  void moveDis(){
    pushMatrix();
    if (armAngle > PI/2 || armAngle < -PI/2 && w > 0){armX = .6*w;}
    else {armX = .4*w;}
    move();
    display();
    popMatrix();
    
  }
  void move(){
    armAngle = atan2(mouseY-y,mouseX-x);
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
    shape(graphics,x,y);
  };
  String toString(){
    return "("+x+","+y+") ";
  }
}

void aRect(float x, float y, float w, float h, float theta){ //theta is the angle from the veritcal, (x,y) is the middle of the upper width  
   pushMatrix();
   translate(x,y);
   rotate(theta);
   rect(-.5*w,0,w,h);
   popMatrix();
}
