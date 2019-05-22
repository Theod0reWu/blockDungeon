User neo;
ArrayList<Person> persons;
ArrayList<Wall> walls;
ArrayList<Moveable> movies;
ArrayList<Displayable> dis;
ArrayList<Bullet> bullets;
ArrayList<Effect> effects;
Boolean[] keys;
float dx, dy;
void setup(){
  size(displayWidth, displayHeight);
  neo = new User(width/2,height/2);
  persons = new ArrayList<Person>();
  //persons.add(neo); //user will now be seperately operated on
  
  bullets = new ArrayList<Bullet>();
  
  walls = new ArrayList<Wall>();
  generateTerrain();
  
  movies = new ArrayList<Moveable>();
  movies.addAll(persons);
  
  keys = new Boolean[]{false,false,false,false}; // [w,a,s,d]
  
  effects = new ArrayList<Effect>(); //always last implements seperately in the draw
  
  dis = new ArrayList<Displayable>();
  dis.addAll(persons);
  dis.addAll(walls); 
  dis.addAll(bullets);
  
  //effects.add(new Effect(width/2,height/2,10));
  //frameRate(1000);
}
void draw(){
  background(255);
  //keys  println(keys);
  if (keys[0]){neo.y-=10;}
  if (keys[1]){neo.x-=10;}
  if (keys[2]){neo.y+=10;}
  if (keys[3]){neo.x+=10;}
  
  dx = width/2 - neo.x;
  dy = height/2 - neo.y; //offset by this much (used for mouse too
  translate(dx,dy);
  textSize(20);
  fill(0);
  text(""+mouseX+":"+mouseY,20,20);
  
  for(Bullet b: bullets){
    b.move();
    b.display();
  }
  
  for (Moveable m: movies){
    m.move();
  }
  for (Displayable d: dis){
    d.display();
  }
  neo.moveDis();
  
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