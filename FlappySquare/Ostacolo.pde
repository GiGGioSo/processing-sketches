class Ostacolo{
  int x, w;
  
  int sopra, sotto, spazio, vel;
  
  Ostacolo(int vel){
    spazio = (int) (height / 3 * 0.8);
    sopra = (int) random(100, height - spazio);
    sotto = sopra + spazio;
    x = width;
    w = 50;
    this.vel = vel;
  }
  
  void update(){
    x -= vel;
  }
  
  void show(){
    fill(250);
    stroke(150);
    strokeWeight(2);
    rect(x, 0, w, sopra);
    rect(x, sotto, w, height - sotto);
  }
  
  boolean isOutOfBounds(){
    if(x < - width / 2){
      return true;
    } else {
      return false;
    }
  }
  
  void hits(Player p){
    if(p.isAlive){
      if(p.y + p.size > sotto || p.y < sopra){
        if(p.x < x+w && p.x + p.size > x){
          player.isAlive = false;
          player.vel = -7;
          tubi.haveToMove = false;
        }
      }
    }
  }
}
