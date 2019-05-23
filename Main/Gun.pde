class Gun{
  float x,y;
  float damage;
  PShape gunny;
  PVector velocity;
  Bullet bType;
  float angle;
  Gun(float x, float y, float d, PVector v){
    this.x = x; this.y = y;
    damage = d; velocity = v; 
    
    gunny = createShape();
    gunny.beginShape();
    vertex(64, -10);
    vertex(64 + 20, -10);
    vertex(64 + 20, 0);
    vertex(
    
    stroke(0);
  }
  PShape getShape(){
    return gunny;
  }
  void shoot(){
    
  }
}