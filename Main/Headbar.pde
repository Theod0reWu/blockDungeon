void displayHeadbar(){
  fill(0);
  //ellipse(ax,ay,10,10);
  fill(color(255,0,0));
  pushMatrix();
  translate(-ax,-ay);
  rescale(1/scale);
  rect(0,0,neo.health*5, 50);
  popMatrix();
}
