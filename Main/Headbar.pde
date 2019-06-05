void displayHeadbar(){
  fill(0);
  pushMatrix();
  translate(-ax,-ay);
  rescale(1/scale);
  
  fill(color(255,0,0));
  for (int h = 0; h <= neo.health; h+=10){
    rect(h*2,0,20,50,5,5,5,5);
  }
  //0-200
  stroke(#E5BF3F); strokeWeight(3);
  line(250,25,20*neo.gun.magCapacity+250,25);
  fill(color(250,208,56));
  for (int b = 0; b < neo.gun.inMag; b++){
    rect(b*20 + 250,0,20,50); 
  }
  
  stroke(0); float len = 20 * scale;
  line(mouseX+len,mouseY,mouseX-len,mouseY);
  line(mouseX, mouseY+len, mouseX, mouseY-len);
  fill(0);
  if (frameCount - headshot <= 10){text("HEADSHOT!!",mouseX+20, mouseY-20);}
  //rect(0,0,neo.health*5, 50);
  popMatrix();
  stroke(0); strokeWeight(1);
}

void crossSection(){
 resetColors();
 strokeWeight(3);
 
}
