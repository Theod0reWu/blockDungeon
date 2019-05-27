PShape group;

void setup() {
  size(1000,1000);
  // Make a group PShape
    PShape bull = createShape();
    bull.beginShape();
    bull.vertex(0,0); 
    bull.vertex(0,-5);
    bull.vertex(20,-5);
    bull.vertex(20, 5);
    bull.vertex(0,5);
    bull.endShape(CLOSE);
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
