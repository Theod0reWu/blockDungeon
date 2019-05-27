class Cartridge implements Displayable{
 float x, y, angle;
 final PShape shell;
 final color c;
 float a = 200;
 int frame;
 PVector v;
 boolean dead = false;
 Cartridge(float x, float y, float angle, PVector v){//make up fly up and rotate a little at every move
   this.x = x; this.y = y;
   //println("c:" + x+":"+y);
   this.angle = angle;
   frame = frameCount;
   this.v = v;
   
   c = color(250,208,56,a);
   
   noStroke();
   shell = createShape();
   shell.beginShape();
   shell.vertex(0,0); 
   shell.vertex(0,-5);
   shell.vertex(20,-5);
   shell.vertex(20, 5);
   shell.vertex(0,5);
   shell.endShape(CLOSE);
   shell.setFill(c);
   shell.rotate(angle);
   //shell.translate(x,y);
 }
 void display(){
   x+=v.x; y+=v.y;
   if (frameCount - frame > 10){a-=10; frame = frameCount;}
   if (a <= 0){dead = true;}
   shell.setFill(color(red(c),green(c),blue(c),a));
   pushMatrix();
   translate(x,y);
   shape(shell);
   popMatrix();
 }
}
