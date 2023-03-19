class Line{
  
  final int HEIGHT = 30;
  
  Rectangle recs[];
  
  int vel;
  
  Player player;
  
  public Line(int num, int y, int w, int vel, Player player){
    this.vel = vel;
    this.player = player;
    if(w * num > width * 1/3){
      num = (width * 1/3) / w;
    }
    int spazioTot = width - w * num;
    int spazioPerLato = spazioTot / (num * 2);
    recs = new Rectangle[num];
    
    for(int i = 0; i < num; i++){
      recs[i] = new Rectangle((w + 2*spazioPerLato) * i, y, w, HEIGHT);
    }
  }
  
  void update(){
    isHitten();
    checkBordi();
    for(Rectangle rec : recs){
      rec.x += vel;
    }
  }
  
  void show(){
    for(Rectangle rec : recs){
      fill(60, 10, 230);
      stroke(10, 5, 240);
      strokeWeight(10);
      rect(rec.x, rec.y, rec.w, rec.h);
    }
  }
  
  void checkBordi(){
    if(recs[0].x < 0 || recs[recs.length - 1].x + recs[recs.length - 1].w > width){
      vel *= -1;
    }
  }
  
  void isHitten(){
    for(Rectangle rec : recs){
      if(player.proiettile != null){
        if(rec.intersect(player.proiettile) && player.proiettile.isOn){
          player.proiettile.isOn = false;
          player.combo = 0;
          player.health -= 5;
          hit.play();
          return;
        }
      }
    }
  }
}
