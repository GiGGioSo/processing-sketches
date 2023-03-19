class Player{
  
  PImage mov_destra = loadImage("movimento_player_destra.png");
  PImage mov_sinistra = loadImage("movimento_player_sinistra.png");
  PImage pianeta = loadImage("player_pianeta.png");
  
  int rotation;
  
  GameState gameState;
  
  Proiettile proiettile;
  
  int score;
  int combo;
  int health;
  int x, y;
  int r;
  int vel_possibile;
  int vel_attuale;
  int vel_proiettile;
  
  public Player(int health, int x, int y, int vel_possibile, int vel_proiettile, GameState gameState){
    this.health = health;
    this.x = x;
    this.y = y;
    this.vel_possibile = vel_possibile;
    this.vel_proiettile = vel_proiettile;
    r = 40;
    this.gameState = gameState;
  }
  
  void update(){
    checkInputs();
    checkBordi();
    this.x += vel_attuale;
    if(vel_attuale < 0){
      if(rotation >= 0){
        rotation -= vel_possibile + 2;
      } else {
        rotation = 360;
      }
    }
    if(vel_attuale > 0){
      if(rotation <= 360){
        rotation += vel_possibile + 2;
      } else {
        rotation = 0;
      }
    }
  }
  
  void show(){
    fill(255, 0, 0);
    stroke(255, 15, 15);
    strokeWeight(r / 8);
    
    //Proiettile
    if(proiettile != null){
      proiettile.shoot();
    }
    //Disegno Player
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(radians(rotation));
    image(pianeta, 0, 0, r + 10, r + 10);
    popMatrix();
    
    //Contorno barra della vita
    stroke(255);
    fill(250);
    strokeWeight(3);
    rect(width / 2 - 200, height - 25, 400, 20);
    
    //Barra della vita
    int healthWidth = int(map(health, 0, 50, 0, 397));
    fill(255, 0, 0);
    noStroke();
    rect(width / 2 - 198, height - 23, healthWidth, 17);
  }
  
  void checkInputs(){
    if(keyPressed && keyCode == RIGHT){
      vel_attuale = vel_possibile;
    }else {
      if(keyPressed && keyCode == LEFT){
        vel_attuale = -vel_possibile;
      }
    }
    
    if(mousePressed){
      if(proiettile == null || !proiettile.isOn){
        proiettile = new Proiettile(vel_proiettile, gameState);
      }
    }
    
  }  
  
  void checkBordi(){
    if(x > width){
      vel_attuale *= -1;
      x = width;
    }
    
    if(x < 0){
      vel_attuale *= -1;
      x = 0;
    }
  }
}
