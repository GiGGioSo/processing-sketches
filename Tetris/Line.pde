class Line extends Shape{
  
  
  boolean canRotate;
  
  Line(int indX, int indY){
    box = new Box[4];
    rotationCount = 0;
    box[0] = new Box(indX - 2, indY-1);
    box[1] = new Box(indX - 1, indY-1);
    box[2] = new Box(indX, indY-1);
    box[3] = new Box(indX + 1, indY-1);
    isDead = false;
    skipMove = false;
  }
  
  void rotateLeft(){
    if(!isDead && canRotate()){
      if(rotationCount == 0){
        box[0].add(1, 2);
        box[1].add(0, 1);
        box[2].add(-1, 0);
        box[3].add(-2, -1);
        increaseRotation();
      } else if(rotationCount == 1){
        box[0].add(2, -1);
        box[1].add(1, 0);
        box[2].add(0, 1);
        box[3].add(-1, 2);
        increaseRotation();
      } else if(rotationCount == 2){
        box[0].add(-1, -2);
        box[1].add(0, -1);
        box[2].add(1, 0);
        box[3].add(2, 1);
        increaseRotation();
      } else if(rotationCount == 3){
        box[0].add(-2, 1);
        box[1].add(-1, 0);
        box[2].add(0, -1);
        box[3].add(1, -2);
        increaseRotation();
      }
    }
  }
  
  boolean canRotate(){
    canRotate = true;
    copy = Util.copyBoxArray(box);
    
    if(!isDead){
      if(rotationCount == 0){
        copy[0].add(1, 2);
        copy[1].add(0, 1);
        copy[2].add(-1, 0);
        copy[3].add(-2, -1);
      } else if(rotationCount == 1){
        copy[0].add(2, -1);
        copy[1].add(1, 0);
        copy[2].add(0, 1);
        copy[3].add(-1, 2);
      } else if(rotationCount == 2){
        copy[0].add(-1, -2);
        copy[1].add(0, -1);
        copy[2].add(1, 0);
        copy[3].add(2, 1);
      } else if(rotationCount == 3){
        copy[0].add(-2, 1);
        copy[1].add(-1, 0);
        copy[2].add(0, -1);
        copy[3].add(1, -2);
      }
    }
    
    for(int i = 0; i < copy.length; i++){
      if((copy[i].indY > 19 || copy[i].indX < 0 || copy[i].indX > 9 || copy[i].indY < 0)
      || (grid[copy[i].indX][copy[i].indY].isFull)){
        canRotate = false;
      }
    }
    
    return canRotate;
  }
  
  
  @Override
  void show(){
    stroke(170, 70, 190);
    strokeWeight(2);
    fill(200, 100, 220);
    for(Box b : box){
      if(b.isOn){
        rect(b.x, b.y, boxWidth, boxWidth);
      }
    }
  }
  
  
}
