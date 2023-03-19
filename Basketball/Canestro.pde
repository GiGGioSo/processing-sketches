class Canestro{
  
  int x, y, w, h;
  int bordiLato;
  Rectangle sinistra, destra, sotto;
  
  public Canestro(int x, int y, int w){
    this.x = x;
    this.y = y;
    this.w = w;
    bordiLato = w/8;
    h = 10;
    sinistra = new Rectangle(x - 15, y - 20, 15, 50);
    destra = new Rectangle(x + w, y - 20, 15, 50);
    sotto = new Rectangle(sinistra.x, sinistra.y + sinistra.h, w + (x-sinistra.x) * 2, 30);
  }
  
  void update(){
    checkCanestro();
    sinistra.checkCollision();
    destra.checkCollision();
    sotto.checkCollision();
  }
  
  void show(){
    //HitBox
    fill(100, 200, 100, 100);
    stroke(120, 220, 120);
    strokeWeight(3);
    rect(x, y, w, h);
    
    //Contorno
    sinistra.show();
    destra.show();
    sotto.show();
    
  }
  
  void checkCanestro(){
    if(((ball.position.x - ball.r < x + w) && (ball.position.x + ball.r > x))
       && ((ball.position.y < y + h) && (ball.position.y > y))
       && ball.velocity.y > 0){
      ball.reset();
    }
  }
}
