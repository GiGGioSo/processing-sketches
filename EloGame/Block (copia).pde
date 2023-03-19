class Block{
  
  float x, y, w, h;
  
  Block(int x, int y){
    this.x = x;
    this.y = y;
    w = unit;
    h = unit;
  }
  
  void show(){
    fill(200, 30, 30, 150);
    stroke(180, 10, 10);
    strokeWeight(2);
    rect(x, y, w, h);
  }
}
