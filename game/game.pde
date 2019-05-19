User neo;
int tick = 0;
ArrayList<Person> persons;
ArrayList<Wall> walls;
ArrayList<Moveable> movies;
ArrayList<Displayable> dis;
ArrayList<Bullet> bullets;
void setup(){
  size(displayWidth, displayHeight);
  neo = new User(width/2,height/2);
  persons = new ArrayList<Person>();
  //persons.add(neo); //user will now be seperately operated on
  
  walls = new ArrayList<Wall>();
  generateTerrain();
  
  dis = new ArrayList<Displayable>();
  dis.addAll(persons);
  //dis.addAll(walls); walls only need to be placed once
  
  movies = new ArrayList<Moveable>();
  movies.addAll(persons);
  
}
void draw(){
  background(255);
  
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
  ++tick;
}
interface Displayable{
  void display();
}
interface Moveable{
  void move();
}
