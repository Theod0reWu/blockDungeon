class Cartridge implements Displayable{
 float x, y, angle;
 final PShape shell;
 final color c;
 float a = 200;
 int frame;
 PVector v;
 boolean dead = false;
 int d;
 int dist = 0;
 Cartridge(float x, float y, float angle, PVector v){//make up fly up and rotate a little at every move
   this.x = x; this.y = y;
   //println("c:" + x+":"+y);
   this.angle = angle;
   frame = frameCount;
   this.v = v;
   d = (int)random(2) - 1;
   if (d == 0){d = 1;}
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
   stroke(1);
 }
 void display(){
   x+=v.x; y+=v.y; 
   dist+=v.y;
   centerRotate(d*random(.2));
   if (frameCount - frame > 10){a-=10; frame = frameCount;}
   if (a <= 0 || dist >= 180){dead = true;}
   shell.setFill(color(red(c),green(c),blue(c),a));
   shape(shell,x,y);
 }
 void centerRotate(float theta){
   shell.translate(10,0);
   shell.rotate(theta);
   shell.translate(-10,0);
 }
}
