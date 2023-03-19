class Player {
  
  boolean intersects;
  
  float x, y, w, h;
  
  Player(int x, int y){
    this.x = x;
    this.y = y;
    w = 15;
    h = 25;
  }
  
  void show(){
    fill(30, 30, 200, 200);
    stroke(10, 10, 180);
    rect(x, y, w, h);
  }
  
}
