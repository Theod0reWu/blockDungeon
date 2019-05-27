import processing.sound.*;
SoundFile shellDropping;
SoundFile shot;
SoundFile whiz;

User neo;
ArrayList<Person> persons;
ArrayList<Wall> walls;
//ArrayList<Moveable> movies;
//ArrayList<Displayable> dis;
ArrayList<Bullet> bullets;
ArrayList<Effect> effects;
ArrayList<Cartridge> cartridges;
Boolean[] keys;
float dx, dy;
void setup(){
  shellDropping = new SoundFile(this, "sounds\\sound-ShellFalling.wav");
  shot = new SoundFile(this, "sounds\\sound-Gunshot.mp3");
  shot = new SoundFile(this, "sounds\\sound-Gunshot.mp3");
  whiz = new SoundFile(this, "sounds\\sound-BulletWhizzing.mp3");
  //frameRate(1000);
  size(displayWidth, displayHeight);
  neo = new User(width/2,height/2);
  persons = new ArrayList<Person>();
  //persons.add(neo); //user will now be seperately operated on
  
  bullets = new ArrayList<Bullet>();
  
  walls = new ArrayList<Wall>();
  generateTerrain();
  
  //movies = new ArrayList<Moveable>();
  //movies.addAll(persons);
  
  keys = new Boolean[]{false,false,false,false}; // [w,a,s,d]
  
  effects = new ArrayList<Effect>(); //always last implements seperately in the draw
  
  //dis = new ArrayList<Displayable>();
  //dis.addAll(persons);
  //dis.addAll(walls); 
  
  cartridges = new ArrayList<Cartridge>(); 
  //dis.addAll(bullets);
  
  //effects.add(new Effect(width/2,height/2,10));
  //frameRate(1000);
  
  //bullets.add(new Bullet (neo.x,neo.y, new PVector(1,1)));
}
void draw(){
  background(255);
  neo.move();
  dx = width/2 - neo.x;
  dy = height/2 - neo.y; //offset by this much (used for mouse too
  translate(dx,dy);
  textSize(20);
  fill(0);
  neo.shoot(); //machine gun
  for (Cartridge c : cartridges){
    c.display();
    if (c.dead){cartridges.remove(c); break;}
  }
  for(Bullet b: bullets){
    boolean dead = false;
    for (Wall w: walls){
      if (b.isTouching(w)){dead = true;break;}
    }
    if (dead){
      b.velocity.normalize();
      int factor = 15;
      effects.add(new Effect(b.x+b.velocity.x*15,b.y+b.velocity.y*15,10, color(150)));
      //whiz.play();
      bullets.remove(b);
      break;
    }
    b.move();
    b.display();
  }
  for (Wall w: walls){
    w.display();
  }
  //for (Moveable m: movies){
    //m.move();
  //}
  //for (Displayable d: dis){
    //d.display();
  //}
  //neo.moveDis(); for the panning thing (maybe later)
  neo.display();
  //if (mousePressed){effects.add(new Effect(mouseX-dx, mouseY-dy,10));} //proper usage of dx dy on mouse
  for (Effect e:effects){
    e.display();
    if (e.particles.size() == 0){effects.remove(e); break;}
  }
}
interface Displayable{
  void display();
}
interface Moveable{
  void move();
}
interface Collideable{ //must have h for height and w for width
  boolean isTouching(Collideable other); //they will all be rectangles
  float getX(); //top left corner 
  float getY();
  //float getAngle(); //gets the angle it is rotated by (for bullets mainly);
  float getH();float getW();
  
  /*possible collisons NO Master Collideable List!!!!!
  1. bullet hits wall (bullet checks and explodes manually)
  2. bullet hits person (same as above)
  3. person hits wall (person will have to check
  */
}
void keyPressed(){
  switch(key){
   case 'w':
   keys[0] = true;
   break;
   case 'a':
   keys[1] = true;
   break;
   case 's':
   keys[2] = true;
   break;
   case 'd': 
   keys[3] = true;
   break;
  }
  //println(key+"");
}
void keyReleased(){
  switch(key){
   case 'w':
   keys[0] = false;
   break;
   case 'a':
   keys[1] = false;
   break;
   case 's':
   keys[2] = false;
   break;
   case 'd': 
   keys[3] = false;
   break;
  }
}
void mousePressed(){
  //neo.shoot();
}
float pyth(float a, float b){
  return sqrt(sq(a)+sq(b));
}
