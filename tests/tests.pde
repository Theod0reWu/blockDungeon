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
    stock.vertex(5,-16);
    stock.vertex(45,-16);
    stock.vertex(45,-10);
    stock.vertex(10,14);
    stock.vertex(5, 14);
    stock.endShape(CLOSE);
    stock.fill(#5D5A5A);
    PShape body = createShape();
    
    bull.addChild(arm);
    bull.addChild(stock);
    
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
