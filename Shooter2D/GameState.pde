class GameState{
  
  Target target;
  Player player;
  Line line1; 
  Shooter2D game;
  
  PImage sfondo = loadImage("sfondo_spazio.png");
  
  boolean isOn;
  
  boolean gameOver;
  
  boolean alreadyExit;
  
  public GameState(Shooter2D game){
    this.game = game;
    if(game.menuState.difficulty == 1){
      player = new Player(50, width / 2, height - 55, 3, 5, this);
      target = new Target(width / 2 - 25, 0, 1, this);
      line1 = new Line(3, height / 2, 40, 2, player);
    } else if(game.menuState.difficulty == 2){
      player = new Player(50, width / 2, height - 55, 4, 4, this);
      target = new Target(width / 2 - 25, 0, 2, this);
      line1 = new Line(4, height / 2, 50, 2, player);
    } else if(game.menuState.difficulty == 3){
      player = new Player(50, width / 2, height - 55, 5, 4, this);
      target = new Target(width / 2 - 25, 0, 3, this);
      line1 = new Line(100, height / 2, 40, 3, player);
    }
    isOn = false;
    gameOver = false;
  }
  
  void update(){
    checkInputs();
    if(player.health <= 0 && !gameOver){
      gameOver = true;
      delay(100);
    }
    if(!gameOver){
      target.update();
      player.update();
      line1.update();
    }
  }
  
  void show(){
    //Sfondo
    imageMode(CORNER);
    image(sfondo, 0, 0, width, height);
    
    //Pavimento
    fill(0, 50, 0);
    noStroke();
    rect(0, height - 30, width, 30);
      
    target.show();
    player.show();
    line1.show();
    if(gameOver){
      showGameOver();
    }
      
    //ScoreDisplay
    fill(150, 40, 40);
    textSize(15);
    text("Score: "+player.score, 10, height / 2 - 100);
    text("Combo: "+player.combo, 10, height / 2 - 80);
    textSize(12);
    text("Press space to Exit", 10, height / 2 - 65);
  }
  
  void checkInputs(){
    if(!alreadyExit){
      if(keyCode == ' '){
        this.isOn = false;
        game.menuState.isOn = true;
        music.stop();
        alreadyExit = true;
      }
    }
    if(!(keyCode == ' ')){
      alreadyExit = false;
    }
  }
  void showGameOver(){
    fill(255, 0, 0);
    textSize(45);
    text("GaMeOvEr!", width / 2 - 115, height / 2 - 105);
    textSize(30);
    text("Your Score: "+player.score, width / 2 - 100, height / 2 - 75);
    textSize(25);
    text("Click the mouse to restart the game", width / 2 - 200, height / 2 + 90);
    
    if(mousePressed){
      this.isOn = false;
      game.menuState.isOn = true;
      resetGame();
      delay(100);
    }
  }
  
  void resetGame(){
    gameOver = false;
    player.health = 50;
    player.score = 0;
    player.x = width / 2;
    target.x = width / 2;
  }
  
}
