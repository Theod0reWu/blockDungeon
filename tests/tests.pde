PShape group;

void setup() {
  size(1000,1000);
  // Make a group PShape
  group = createShape();
  group.beginShape();
  group.vertex(0,0);
  group.vertex(0,-100);
  group.vertex(50,50);
  group.endShape(CLOSE);
}

void draw() {
  background(52);
  translate(mouseX, mouseY);
  fill(255);
  //group.rotate(.1);
  shape(group);
}
