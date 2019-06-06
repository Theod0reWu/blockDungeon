import processing.sound.*;
SoundFile shellDropping;
SoundFile shot;
SoundFile whiz;
SoundFile hit;
SoundFile dying;
SoundFile dryGun;
SoundFile clip;
SoundFile reload;
SoundFile userHurt;

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
ArrayList<Room> areas;

Boolean[] keys;
float dx, dy;
float ax = 0, ay = 0; //"actual" x and y

float scale = .5;
float offsetX = 0;
float offsetY = 0;
float easing = .07;

boolean menu = true;
int rmenu;

boolean reloading = false;
int headshot;
int badHeadshot;

float maxSlow = 100;
float slow = maxSlow;
final int fps = 20; //frames per slo mo
boolean matrixDodge = false;


boolean retry = false;

int healthRegen = frameCount;

boolean godMode = false;
PShape handGun;
PShape machineGun;

void setup() {
  shellDropping = new SoundFile(this, "ShellFalling.wav");
  shot = new SoundFile(this, "GunShot.wav");
  hit = new SoundFile(this, "Hurt.wav");
  dying = new SoundFile(this, "Dying.wav");
  dryGun = new SoundFile(this, "Gun+Empty.wav");
  clip = new SoundFile(this, "Gun+Clip.wav");
  reload = new SoundFile(this, "Gun+Reload.wav");
  userHurt = new SoundFile(this, "playerHurt.wav");
  //shot = new SoundFile(this, "sounds\\sound-Gunshot.mp3");
  //whiz = new SoundFile(this, "sounds\\sound-BulletWhizzing.mp3");
  //frameRate(1000);
  size(displayWidth, displayHeight);
  //size(2000,1000);
  neo = new User(wallWidth + 20, wallWidth+20);
  persons = new ArrayList<Person>();
  //persons.add(neo); //user will now be seperately operated on
  enemies = new ArrayList<Enemy>();
  //enemies.add(new Enemy( 500, 500));

  bullets = new ArrayList<Bullet>();

  walls = new ArrayList<Wall>();
  areas = new ArrayList<Room>();
  generateTerrain();

  //movies = new ArrayList<Moveable>();
  //movies.addAll(persons);

  keys = new Boolean[]{false, false, false, false}; // [w,a,s,d]

  effects = new ArrayList<Effect>(); //always last implements seperately in the draw

  //dis = new ArrayList<Displayable>();
  //dis.addAll(persons);
  //dis.addAll(walls); 

  cartridges = new ArrayList<Cartridge>(); 
  //dis.addAll(bullets);

  //effects.add(new Effect(width/2,height/2,10));
  //frameRate(1000);

  //bullets.add(new Bullet (neo.x,neo.y, new PVector(1,1)));
  
  handGun = createShape();
  handGun.beginShape();
  handGun.vertex(0,0);
  handGun.vertex(0,-22);
  handGun.vertex(0+45,-22);
  handGun.vertex(0+45, -10);
  handGun.vertex(0+10,-10);
  handGun.vertex(0+10, 10);
  handGun.vertex(0,10);
  handGun.endShape(CLOSE);
  handGun.setFill(0);
  
  stroke(0); strokeWeight(2);
    fill(#5D5A5A);
    PShape bull = createShape(GROUP);
    PShape stock = createShape();
    stock.beginShape();
    stock.vertex(5,0);
    stock.vertex(5,-20);
    stock.vertex(45,-20);
    stock.vertex(45,-12);
    stock.vertex(10,8);
    stock.vertex(5, 8);
    stock.endShape(CLOSE);
    stock.fill(#484141);
    PShape body = createShape();
    body.beginShape();
    body.vertex(45,-24);
    body.vertex(45,-8);
    body.vertex(50,-8);
    body.vertex(45,10);
    body.vertex(54,10);
    body.vertex(60,-8);
    body.vertex(64,-8);
    body.vertex(64,-10);
    body.vertex(72,-10);
    body.vertex(72,-8);
    body.vertex(80, -8);
    body.vertex(80, -24);
    body.endShape(CLOSE);
    PShape barrel = createShape();
    barrel.beginShape();
    barrel.vertex(80,-24);
    barrel.vertex(100,-24);
    barrel.vertex(100,-14);
    barrel.vertex(90,-14);
    barrel.vertex(90,-10);
    barrel.vertex(80,-10);
    barrel.endShape(CLOSE);
    
    PShape muzzle = createShape();
    muzzle.beginShape();
    muzzle.vertex(100,-20);
    muzzle.vertex(120, -20);
    muzzle.vertex(120, -14);
    muzzle.vertex(100,-14);
    muzzle.endShape(CLOSE);
    PShape mag = createShape();
    mag.beginShape();
    mag.vertex(72,-8);
    mag.vertex(72,0);
    mag.vertex(74,0);
    mag.vertex(74,6);
    mag.vertex(76,6);
    mag.vertex(76,10);
    //mag.vertex(
    mag.vertex(84,10);
    mag.vertex(84,6);
    mag.vertex(82,6);
    mag.vertex(82,0);
    mag.vertex(80,0);
    mag.vertex(80,-8);
    mag.endShape(CLOSE);
    
    fill(0);
    PShape top = createShape(RECT, 52, -24, 2, -5);
    PShape handle = createShape(RECT, 52,-29,24,-2);
    PShape nib = createShape(RECT, 76, -24, 2, -3);
    
    bull.addChild(stock);
    bull.addChild(body);
    bull.addChild(top);
    bull.addChild(handle);
    bull.addChild(nib);
    bull.addChild(barrel);
    bull.addChild(muzzle);
    bull.addChild(mag);
    
    machineGun = bull;
}
void draw() {
  if (neo.health <= 0 && !retry){ matrixDodge = false;
    dying.jump(0);
    background(150);
    textSize(80); textAlign(CENTER);  fill(color(255,0,0));
    text("YOU DIED",width/2,height/2);
    fill(0);textSize(30);
    text("Restarting...", width/2, height/2 + 80);
    textAlign(LEFT);
    retry = true;
  }else if (retry){
    retry = false;
    delay(2500);
    matrixDodge = false; mags = 1;
    setup();
  }
  else if (areas.size() == 0 && enemies.size() == 0){
    floors++;
    rooms++;
    borderLength+=500;
    matrixDodge = false;
    mags+=2;
    setup();
  }
  else if (menu) {
    background(150, .1);
    textSize(32);
    resetColors();
    fill(0);
    ellipse(width/2, height*2/3, 100, 100);
    fill(255);
    text("PLAY", width/2-38, height*2/3 + 10);
    text("Click the button to play", width/2 - 160, height*2/3 - 60);

    textSize(26);
    fill(color(0,255,0));
    text("Directions:", 50, 30);
    textSize(20);
    fill(255);
    text("~Use the wasd keys to move. Press the 'esc' key to quit.", 50, 50);
    text("~Move the mouse to aim. Left Click to shoot. Press 'm' to pause and resume.", 50,70);
    text("~Press 'r' to reload. You may only reload when you have used up all your bullets", 50,90);
    text("~if you die you restart again. if you clear all the rooms you start over with more rooms and floors", 50, 110);
    text("~press the spacebar to enter slow motion mode, press it again to enter normal speed", 50,130);
    
    int xd = 1000;
    fill(0);
    textSize(32);
    text("Tips:",xd,30);
    textSize(20);
    text("-The arm points in the direction of the mouse, NOT THE GUN!",xd, 60);
    text("-Headshots deal double damage!", xd, 80);
    text("-you have unlimited reloads for the handgun", xd, 100);
    text("-you need to aquire magazines for the auto-rifle", xd, 120);

    fill(0);
    rect(50, 140, 200, 130);
    fill(255);
    rect(70, 160, 160, 90);
    fill(0);
    textSize(32);
    text("SCALE: ", 100, 190);
    text(scale, 100, 240);
    textSize(20); fill(255);
    text("Press 'i' to zoom in and 'o' to zoom out.", 50, 290);
    
    //health
    resetColors();
    fill(color(255,0,0));
    text("Your HEALTH is " + neo.health/10, 50, 350);
    for (int h = 0; h <= neo.health; h+=10){
      rect(h*2+50,370,20,50,5,5,5,5);
    }
    //bullets
    fill(color(250,208,56));
    text("You have "+neo.gun.inMag + " bullets in your gun clip",50,500);
    stroke(#E5BF3F); strokeWeight(3);
    line(50,545,20*neo.gun.magCapacity+50,545);
    for (int b = 0; b < neo.gun.inMag; b++){
      rect(b*20 + 50,520,20,50); 
    }
    resetColors();
    //slo mo
     stroke(#00E3FF); strokeWeight(5);
    fill(0,0);
    rect(50, 650, 200, 50);
    fill(#00F4FF);
    text("You have " + slow / 60 + " seconds of slow motion left", 50, 630);
    float s = slow * (200/maxSlow);
    if ( s < 0) {s = 0;}
    rect(50, 650, s, 50);
    //mags
    
    fill(80); stroke(0);
    text("You have " + mags + " magazines for the auto-rifle",50, 770);
    for (int m = 0; m < mags;m++){
     rect(50, 790, 20,50);
    }
    
    resetColors();
    //gun facts
    rectMode(CENTER); fill(#86582A); stroke(#5D3D1C); strokeWeight(2);
    rect(width/2, 320, 100,60);
    rect(width/2, 500, 160,100);
    shape(handGun, width/2 - 20, 328);
    shape(machineGun, width/2 - 60, 510);
    rectMode(CORNER);
    resetColors();
    text("HandGun", width/2 - 50, 280);
    text("Auto-Rifle", width/2 - 55, 440);
    
    if (mousePressed && sqrt(sq(mouseX - width/2)+sq(mouseY-height*2/3)) <= 90) {
      menu = false;
    }
    rmenu = frameCount;
  } else {
     //println(keys[0]+":"+keys[1]+":"+keys[2]);
    framerate = 60;
    bSpeed = 35;
    neo.speed= 8;
    enemySpeed = 6;
    
    neo.gun.fireRate = neo.gun.actualFr;
    if (keys[0]&&keys[2]&& mousePressed && mouseButton == RIGHT){ //god mode
      godMode = !godMode;
    //bSpeed = 60
    }
    if (godMode){
      neo.gun.inMag = 1000;
      neo.gun.fireRate = 5;
      neo.speed=30;
      neo.health = 2000;
    }
    if (slow <= 0) {matrixDodge = false;}
    if (matrixDodge && slow > 0){
      neo.gun.fireRate-=5;
      framerate = 20;
      bSpeed = 15;
      neo.speed=15;
      slow-=1;
    }else if (slow < maxSlow && !matrixDodge){slow+=.5;}
    
    if (neo.health < 100 && frameCount - healthRegen >240){
      neo.health+=10;
      healthRegen = frameCount;
    }
    
    if (mousePressed && mouseButton == RIGHT){reloading = true;}
    
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
    if (abs(offsetX) > 2) {
      ax+= offsetX;
    } 
    if (abs(offsetY) > 2) {
      ay+=offsetY;
    } //println("a:"+ax+":"+ay);
    translate(ax, ay); //println(offsetX+":"+offsetY); //should be 760 340
    //cannot use b/c of mouse aiming
    //translate(dx,dy); //println(dx+":"+dy);
    placeBackground();
    textSize(20);
    fill(0);
    neo.shoot(); //machine gun
    if (reloading){neo.gun.reload();}
    for (Cartridge c : cartridges) {
      c.display();
      if (c.dead) {
        cartridges.remove(c); 
        break;
      }
    }
    for (Room r: areas){
     if (neo.isTouching(r)){r.spawnEnemies();areas.remove(r);break;} 
    }
    for (Bullet b : bullets) {
      boolean dead = false;
      color c = color(0);
      for (Wall w : walls) {
        if (b.isTouching(w)) {
          dead = true; 
          c = color(150);
          break;
        }
      }
      for (Enemy e : enemies) {
        if (b.isTouching(e) && b.good) {
          if (b.isTouchingHead(e)){e.health-=b.damage;headshot = frameCount;}
          e.health -= b.damage;
          hit.jump(0);
          dead = true; 
          c = color(255);
          break;
        }
      }
      if (b.isTouching(neo) && !b.good) {
        //println(b.damage);
        if (b.isTouchingHead(neo)){neo.health-=b.damage;badHeadshot = frameCount;}
        neo.health -= b.damage;
        userHurt.jump(0);
        dead = true;
        c = color(255); 
      }
      if (dead) {
        b.velocity.normalize();
        int factor = 15;
        effects.add(new Effect(b.x+b.velocity.x*15, b.y+b.velocity.y*15, 10, c));
        //whiz.play();
        bullets.remove(b);
        break;
      }
      b.move();
      b.display();
    }
    for (Enemy e : enemies) {
      if (e.health<=0) {
        //dying.jump(1);
        if ((int)random(4) == 0){mags++;}
        effects.add(new Effect(e.x+35, e.y+90, 80, color(255)));
        enemies.remove(e);
        break;
      }
      e.move();
      e.shoot();
      e.display();
    }
    for (Wall w : walls) {
      w.display();
    }
    //neo.moveDis(); for the panning thing (maybe later)
    neo.display();
    //if (mousePressed){effects.add(new Effect(mouseX-dx, mouseY-dy,10));} //proper usage of dx dy on mouse
    for (Effect e : effects) {
      e.display();
      if (e.particles.size() == 0) {
        effects.remove(e); 
        break;
      }
    }
    //areas.get(0).dis();
    /*for (Room r: areas){
      r.dis();
    }*/
    displayHeadbar(); //println(neo.gun.damage);
    //if (reloading)println(frameCount);
  }
}
interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
interface Collideable { //must have h for height and w for width
  boolean isTouching(Collideable other); //they will all be rectangles
  float getX(); //top left corner 
  float getY();
  //float getAngle(); //gets the angle it is rotated by (for bullets mainly);
  float getH();
  float getW();

  /*possible collisons NO Master Collideable List!!!!!
   1. bullet hits wall (bullet checks and explodes manually)
   2. bullet hits person (same as above)
   3. person hits wall (person will have to check
   */
}
void keyPressed() {
  switch(key) {
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
    if (scale <= 1.2) {
      scale+=.1;
    }
    break;
  case 'o':
    if (scale >= .2) {
      scale-=.1;
    } /*else if (scale >= .02) {
      scale-=.01;
    }*/
    break;
  case 'm':
    menu=!menu;
    break;
  case ' ':
    matrixDodge = !matrixDodge;
    //framerate = 10;
    //bSpeed = 10;
    //neo.speed=10;
    break;
  case 'e':
    neo.swapGun();
    break;
  }
  //println(key+"");
}
void keyReleased() {
  switch(key) {
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
  case ' ':
    //matrixDodge = false;
    //framerate = 60;
    //bSpeed = 35;
    //neo.speed= 7;
    break;
  case 'r':
    if (neo.gun.inMag <= neo.gun.magCapacity){reloading = true;}
    break;
  }
}
void mouseClicked(){
 if (mouseButton == CENTER){neo.swapGun();} 
}
void mouseWheel(MouseEvent event){
  if (event.getCount() < 0){ 
    if (scale <= 1.2) {
      scale+=.1;
    }
  }else if(event.getCount() > 0){
    if (scale >= .2) {
      scale-=.1;
    }
  }
}
float pyth(float a, float b) {
  return sqrt(sq(a)+sq(b));
}
void rescale(float scale) {
  //translate(width/2 - (width/2*scale),height/2 - (height/2*scale));
  float cx = width/2+35; 
  float cy = height/2+90;
  translate(cx, cy);
  scale(scale);
  translate(-cx, -cy);
}
void resetColors(){
  stroke(0); strokeWeight(1);
  fill(0);
}
