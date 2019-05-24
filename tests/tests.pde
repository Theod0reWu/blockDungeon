PShape group;

void setup() {
  size(1000,1000);
  // Make a group PShape
    PShape gunny = createShape();
    gunny.beginShape();
    gunny.vertex(0,0);
    gunny.vertex(0,-10);
    gunny.vertex(30,-10);
    gunny.vertex(30, 0);
    gunny.vertex(10,0);
    gunny.vertex(10, 10);
    gunny.vertex(0,10);
    gunny.endShape(CLOSE);
    group = gunny;
    group.scale(1,-1);
    group.rotate(3*PI/4);
}

void draw() {
  background(255);
  translate(mouseX, mouseY);
  fill(0);
  //group.rotate(.1);
  shape(group);
}
