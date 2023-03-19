class MenuState{
  
  Shooter2D game;
  
  Rectangle rec1, rec2;
  
  boolean isLeft, isRight;
  
  int difficulty = 1;
  
  boolean alreadyPressed;
  
  boolean isOn;
  
  String message;
  
  int bordo_lato = 50;
  
  public MenuState(Shooter2D game){
    this.game = game;
    rec1 = new Rectangle(width / 4 - (width / 4 - bordo_lato), 100, (width / 4 - bordo_lato) * 2, height - 200);
    rec2 = new Rectangle(rec1.x + width / 2, 100, rec1.w, rec1.h);
    isOn = true;
  }
  
  void update(){
    checkInputs();
  }
  
  void show(){
    
    if(isLeft){
      noFill();
      stroke(250);
      strokeWeight(10);
      rect(rec1.x - 13, rec1.y - 13, rec1.w + 26, rec1.h + 26);
      textSize(50);
      fill(250);
      if(difficulty == 1){
        text("Easy", width / 4 - 50, height / 2 + 13);
      } else if(difficulty == 2){
        textSize(45);
        text("Medium", width / 4 - 90, height / 2 + 13);
      } else if(difficulty == 3){
        text("Hard", width / 4 - 50, height / 2 + 13);
      }
      
    } else {
      noFill();
      stroke(250);
      strokeWeight(10);
      rect(rec1.x, rec1.y, rec1.w, rec1.h);
      textSize(45);
      fill(250);
      if(difficulty == 1){
        text("Easy", width / 4 - 40, height / 2 + 13);
      } else if(difficulty == 2){
        textSize(40);
        text("Medium", width / 4 - 80, height / 2 + 13);
      } else if(difficulty == 3){
        text("Hard", width / 4 - 40, height / 2 + 13);
      }
    }
    
    noFill();
    stroke(250);
    strokeWeight(10);
    if(isRight){
      rect(rec2.x - 13, rec2.y - 13, rec2.w + 26, rec2.h + 26);
      textSize(50);
      text("Play!", width * 3/4 - 50, height / 2 + 13);
    } else {
      rect(rec2.x, rec2.y, rec2.w, rec2.h);
      textSize(45);
      text("Play!", width * 3/4 - 40, height / 2 + 13);
    }
    strokeWeight(3);
    line(width / 2, 0, width / 2, height);
  }
  
  void checkInputs(){
    if(mouseX < width / 2){
      isLeft = true;
      isRight = false;
    } else if(mouseX > width / 2){
      isRight = true;
      isLeft = false;
    } else {
      isRight = false;
      isLeft = false;
    }
    
    if(mousePressed && isLeft && !alreadyPressed){
      alreadyPressed = true;
      difficulty += 1;
      if(difficulty > 3){
        difficulty = 1;
      }
    } else { 
      if(!mousePressed){
        alreadyPressed = false;
      }
      if(mousePressed && isRight && !alreadyPressed){
        this.isOn = false;
        game.gameState = new GameState(game);
        game.gameState.isOn = true;
        delay(100);
        music.loop();
      }
    }
  }
}
