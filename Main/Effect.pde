class Effect implements Displayable{
  float x,y, mag;
  PVector v;
  int initialTick;
  ArrayList<Particle> particles;
  Effect(float x, float y, float mag, color c){
    this.mag = mag; this.x = x; this.y = y;
    particles = new ArrayList<Particle>();
    initialTick = frameCount;
    
    int numP = (int)random(5) + 5;
    for (int p = 0; p < numP; p++){
      float s = random(5)+5;
      float theta = random(2*PI);
      float  nx = x+cos(theta)*mag*random(1);
      float ny = y+sin(theta)*mag*random(1);
      color randC = color(red(c)+random(20),green(c)+random(20),blue(c)+random(20));
      particles.add(new Particle(nx, ny,s, new PVector(nx - x, ny - y), randC));
    }
  }
  void display(){
    for (Particle p : particles){
      if (p.alive){p.update(); p.display();x++;}
      //else {particles.remove(p); break;}
    }
    //if (x == s){particles = new ArrayList<Particle>();}
  }
}
class Particle{
  float x,y, size;
  PVector v;
  int lastMove = frameCount;
  color c;
  boolean alive = true;
  float alpha = 100; //transparency
  int moves = 0;
  Particle(float x, float y, float size, PVector v, color c){
    this.x = x; this.y = y; this.v = v.normalize().mult(random(1.8));
    this.size = size; this.c = c;
  }
  void update(){
    if (frameCount - lastMove > 1){
      x+=v.x; y+=v.y;
      c = color(red(c),green(c),blue(c),alpha); 
      alpha-=1;
      lastMove = frameCount;
      moves++;
    }
    if (moves > 10){alive = false;}
  }
  void display(){
    fill(c);
    rect(x,y,size,size);
  }
}
