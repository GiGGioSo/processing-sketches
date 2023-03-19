class Shape{
  boolean isDead;
  boolean skipMove;
  int rotationCount;
  
  Box[] box;
  Box[] copy;
  
  void checkDied(){
    if(max(max(box[0].indY, box[1].indY), max(box[2].indY, box[3].indY)) > 18){
      isDead = true;
    } else {
      copy = Util.copyBoxArray(box);
      for(Box b : copy){
        b.add(0, 1);
        if(grid[b.indX][b.indY].isFull){
          isDead = true;
        }
      }
    }
  }
  
  void useInput(){
    if(keyCode == ' '){
      rotateLeft();
    } else if(key == 'a'){
      moveLeft();
    } else if(key == 'd'){
      moveRight();
    } else if(key == 's'){
      skipMove = true;
    }
  }
  
  void moveDown(){
    if(frameCount % 50 == 0 || skipMove){
      checkDied();
      if(!isDead){
        for(Box b : box){
          b.add(0, 1);
        }
      }
    }
    skipMove = false;
  }
  
  boolean canMoveLeft(){
    boolean canMove = false;
    if(min(min(box[0].indX, box[1].indX), min(box[2].indX, box[3].indX)) > 0){
      canMove = true;
      copy = Util.copyBoxArray(box);
      for(Box b : copy){
        b.add(-1, 0);
        if(grid[b.indX][b.indY].isFull){
          canMove = false;
        }
      }
    }
    
    return canMove;
  }
  
  void moveLeft(){
    if(!isDead && canMoveLeft()){
      for(Box b : box){
        b.add(-1, 0);
      }
    }
  }
  
  boolean canMoveRight(){
    boolean canMove = false;
    if(max(max(box[0].indX, box[1].indX), max(box[2].indX, box[3].indX)) < 9){
      canMove = true;
      copy = Util.copyBoxArray(box);
      for(Box b : copy){
        b.add(1, 0);
        if(grid[b.indX][b.indY].isFull){
           canMove = false;
        }
      }
    }
    
    return canMove;
  }
  
  void moveRight(){
    if(!isDead && canMoveRight()){
      for(Box b : box){
        b.add(1, 0);
      }
    }
  }
  
  void fillSpace(){
    if(isDead){
      for(Box b : box){
        grid[b.indX][b.indY].isFull = true;
      }
    }
  }
  
  
  void increaseRotation(){
    if(rotationCount < 3){
      rotationCount++;
    } else {
      rotationCount = 0;
    }
  }
  
  void rotateLeft(){}
  
  void update(){
    fillSpace();
    moveDown();
  }
  
  void show(){}
  
  void fallDown(int y){
    for(Box b : box){
      if(b.indY < y && isDead){
        b.add(0, 1);
      }
      if(b.indY == y && isDead){
        b.isOn = false;
      }
    }
  }
}