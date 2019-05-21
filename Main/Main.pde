User neo;
ArrayList<Person> persons;
ArrayList<Wall> walls;
ArrayList<Moveable> movies;
ArrayList<Displayable> dis;
ArrayList<Bullet> bullets;
Boolean[] keys;
void setup(){
  size(displayWidth, displayHeight);
  neo = new User(width/2,height/2);
  persons = new ArrayList<Person>();
  //persons.add(neo); //user will now be seperately operated on
  
  walls = new ArrayList<Wall>();
  generateTerrain();
  
  dis = new ArrayList<Displayable>();
  dis.addAll(persons);
  dis.addAll(walls); 
  
  movies = new ArrayList<Moveable>();
  movies.addAll(persons);
  
  keys = new Boolean[]{false,false,false,false}; // [w,a,s,d]
  
  //frameRate(1000);
}
void draw(){
  background(255);
  //keys
  println(keys);
   if (keys[0]){neo.y-=10;}
   if (keys[1]){neo.x-=10;}
   if (keys[2]){neo.y+=10;}
   if (keys[3]){neo.x+=10;}
  
  translate(width/2 - neo.x,height/2 - neo.y);
  textSize(20);
  fill(0);
  text(""+mouseX+":"+mouseY,20,20);
  for (Moveable m: movies){
    m.move();
  }
  for (Displayable d: dis){
    d.display();
  }
  neo.moveDis();
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