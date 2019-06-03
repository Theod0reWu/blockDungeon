PShape group;

void setup() {
  size(1000,1000);
  // Make a group PShape
  /*
   gunny.vertex(armL,0);
    gunny.vertex(armL,-gunH);
    gunny.vertex(armL+45,-gunH);
    gunny.vertex(armL+45, -10);
    gunny.vertex(armL+10,-10);
    gunny.vertex(armL+10, 10);
    gunny.vertex(armL,10);
    */
    
    PShape arm = createShape();
    arm.beginShape();
    arm.vertex(0,0); 
    arm.vertex(0,-10);
    arm.vertex(64,-10);
    arm.vertex(64, 10);
    arm.vertex(0,10);
    arm.endShape(CLOSE);
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
    stock.fill(#5D5A5A);
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
    fill(0);
    PShape top = createShape(RECT, 52, -24, 2, -5);
    PShape handle = createShape(RECT, 52,-29,24,-2);
    PShape nib = createShape(RECT, 76, -24, 2, -3);
    fill(#5D5A5A);
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
    mag.vertex(72,-
    mag.vertex(80,-8);
    mag.endShape(CLOSE);
    
    bull.addChild(arm);
    bull.addChild(stock);
    bull.addChild(body);
    bull.addChild(top);
    bull.addChild(handle);
    bull.addChild(nib);
    bull.addChild(barrel);
    bull.addChild(muzzle);
    group = bull;
    //group.scale(1,-1);
    //group.rotate(3*PI/4);
}

void draw() {
  background(255);
  translate(mouseX, mouseY);
  fill(0);
  //group.rotate(.1);
  shape(group);
}
