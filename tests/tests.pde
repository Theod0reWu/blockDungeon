PShape group;

void setup() {
  size(1000,1000);
  // Make a group PShape
    PShape gunny = createShape(GROUP);
    noStroke();
    PShape r = createShape(RECT, 0, 0, 25, 10, 0, 10, 10, 0);
    r.setFill(0);
    PShape h = createShape(RECT, 0,0, 10, 20,0,0,10,10);
    h.setFill(0);
    gunny.addChild(r); gunny.addChild(h);
    
    group = gunny;
}

void draw() {
  background(52);
  translate(mouseX, mouseY);
  fill(255);
  //group.rotate(.1);
  shape(group);
}