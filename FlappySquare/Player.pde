class Player{
  
  boolean isAlive, onGround;
  
  int x, y;
  float vel, acc;
  int size;
  
  Player(int x, int y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
    vel = 0;
    acc = 0.4;
    isAlive = true;
    onGround = false;
  }
  
  void update(){
    vel += acc;
    y += vel;
    checkBordi();
  }
  
  void show(){
    stroke(230, 100, 100);
    strokeWeight(3);
    fill(250, 10, 10);
    //pushMatrix();
    rect(x, y, size, size);
  }
  
  void checkBordi(){
    if(y + size > height){
      y = height - size;
      vel = 0;
      isAlive = false;
      onGround = true;
    }
    if(y < 0){
      y = 0;
      vel = 0;
      isAlive = false;
    }
  }
  
  void jump(){
    vel = -9;
  }
}
