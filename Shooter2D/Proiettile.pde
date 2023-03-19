class Proiettile extends Rectangle{
  
  GameState gameState;
  
  boolean isOn;
  
  int vel;
  
  public Proiettile(int vel, GameState gameState){
    super(gameState.player.x - 5, gameState.player.y - 5, 10, 10);
    isOn = true;
    this.vel = vel;
    this.gameState = gameState;
  }
  
  void update(){
    y -= vel;
  }
  
  void show(){
    fill(255, 0, 0);
    stroke(20);
    strokeWeight(w / 8);
    rect(x, y, w, h);
  }
  
  void shoot(){
    if(isOn){
      update();
      checkBordi();
      show();
    }
  }
  
  void checkBordi(){
    if(y < 0){
      isOn = false;
      gameState.player.combo = 0;
      gameState.player.health -= 5;
      hit.play();
    }
  }
}
