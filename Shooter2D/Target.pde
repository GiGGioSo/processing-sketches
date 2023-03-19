class Target extends Rectangle{
  
  int vel;
  
  GameState gameState;
  
  boolean alreadyHit = false;
 
  public Target(int x, int y, int vel, GameState gameState){
    super(x, y, 50, 50);
    this.vel = vel;
    this.gameState = gameState;
  }
  
  public void update(){
    x += vel;
    checkBordi();
    isHitten();
  }
  
  public void show(){
    fill(250, 200, 220);
    stroke(200, 180, 200);
    strokeWeight(w / 8);
    rect(x, y, w, h);
  }
  
  public void checkBordi(){
    if(x < 0){
      vel *= -1; 
      x = 0;
    }
    if(x > width - w){
      vel *= -1; 
      x = width - w;
    }
  }
  
  void isHitten(){
    if(gameState.player.proiettile != null){
      if(intersect(gameState.player.proiettile) && gameState.player.proiettile.isOn){
        if(!alreadyHit){
          gameState.player.proiettile.isOn = false;
          gameState.player.score += 10 + gameState.player.combo;
          gameState.player.combo += 1;
          point.play();
          alreadyHit = true;
        }
      } else { 
        alreadyHit = false;
        return;
      }
    }
  }
}
