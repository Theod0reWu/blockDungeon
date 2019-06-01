import processing.sound.*;
SoundFile shellDropping;
SoundFile shot;
SoundFile whiz;
SoundFile hit;

float shotTime;
float shellTime;

int framerate = 60;

User neo;
ArrayList<Person> persons;
ArrayList<Wall> walls;
//ArrayList<Moveable> movies;
//ArrayList<Displayable> dis;
ArrayList<Bullet> bullets;
ArrayList<Effect> effects;
ArrayList<Cartridge> cartridges;
ArrayList<Enemy> enemies;

Boolean[] keys;
float dx, dy;
float ax = 0, ay = 0; //"actual" x and y

float scale = 1;
float offsetX = 0;
float offsetY = 0;
float easing = .07;

boolean menu = true;
void setup(){
  shellDropping = new SoundFile(this, "ShellFalling.wav");
  shot = new SoundFile(this, "GunShot.wav");
  hit = new SoundFile(this, "Hurt.wav");
  //shot = new SoundFile(this, "sounds\\sound-Gunshot.mp3");
  //whiz = new SoundFile(this, "sounds\\sound-BulletWhizzing.mp3");
  //frameRate(1000);
  size(displayWidth, displayHeight);
  //size(2000,1000);
  neo = new User(200,200);
  persons = new ArrayList<Person>();
  //persons.add(neo); //user will now be seperately operated on
  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy( 500,500));
  
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
  if (menu){
    background(150,.1);
    textSize(32);
    
    fill(0);
    ellipse(width/2,height*2/3, 100,100);
    fill(255);
    text("PLAY",width/2-38,height*2/3 + 10);
    
    textSize(20);
    text("Use the wasd keys to move", 50,50);
    
    if (mousePressed && sqrt(sq(mouseX - width/2)+sq(mouseY-height*2/3)) <= 90){menu = false;}
  }
  else{
    frameRate(framerate);
    //println(shot.isPlaying());
    //println(shot.duration());
    background(255);
    //ellipse(width/2,height/2, 10,10);
    rescale(scale);
    neo.move(); //println(width+":"+height);
    dx = width/2 - neo.x - ax;
    dy = height/2 - neo.y - ay; //offset by this much (used for mouse too
    offsetX = dx * easing;
    offsetY = dy * easing;
    if (abs(offsetX) > 1){ax+= offsetX;} 
    if (abs(offsetY) > 1){ay+=offsetY;} //println("a:"+ax+":"+ay);
    translate(ax,ay); //println(offsetX+":"+offsetY); //should be 760 340
    //cannot use b/c of mouse aiming
    //translate(dx,dy); //println(dx+":"+dy);
    placeBackground();
    textSize(20);
    fill(0);
    neo.shoot(); //machine gun
    for (Cartridge c : cartridges){
      c.display();
      if (c.dead){cartridges.remove(c); break;}
    }
    for(Bullet b: bullets){
      boolean dead = false;
      color c = color(0);
      for (Wall w: walls){
        if (b.isTouching(w)){dead = true; c = color(150);break;}
      }
      for (Enemy e: enemies){
        if (b.isTouching(e) && b.good){
          e.health -= b.damage;hit.jump(0);
          dead = true; c = color(255);break;}
      }
      if (b.isTouching(neo) && !b.good){
        neo.health -= b.damage;hit.jump(0);
        dead = true;
        c = color(255); break;
      }
      if (dead){
        b.velocity.normalize();
        int factor = 15;
        effects.add(new Effect(b.x+b.velocity.x*15,b.y+b.velocity.y*15,10, c));
        //whiz.play();
        bullets.remove(b);
        break;
      }
      b.move();
      b.display();
    }
    for (Enemy e : enemies){
      if (e.health<=0){
        effects.add(new Effect(e.x+35, e.y+90, 80, color(255)));
        enemies.remove(e);break;}
      e.move();
      e.display();
    }
    for (Wall w: walls){
      w.display();
    }
    //neo.moveDis(); for the panning thing (maybe later)
    neo.display();
    //if (mousePressed){effects.add(new Effect(mouseX-dx, mouseY-dy,10));} //proper usage of dx dy on mouse
    for (Effect e:effects){
      e.display();
      if (e.particles.size() == 0){effects.remove(e); break;}
    }
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
   case 'i':
   if (scale <= 1.2){scale+=.1;}
   break;
   case 'o':
   if (scale >= .2){scale-=.1;}
   else if (scale >= .02){scale-=.01;}
   break;
   case 'm':
   menu=!menu;
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

float pyth(float a, float b){
  return sqrt(sq(a)+sq(b));
}
void rescale(float scale){
  //translate(width/2 - (width/2*scale),height/2 - (height/2*scale));
  float cx = width/2+35; float cy = height/2+90;
  translate(cx,cy);
  scale(scale);
  translate(-cx,-cy);
}
