class ZigL extends Shape{
  
  boolean canRotate;
  
  ZigL(int indX, int indY){
    box = new Box[4];
    rotationCount = 0;
    box[0] = new Box(indX - 1, indY - 1);
    box[1] = new Box(indX, indY - 1);
    box[2] = new Box(indX, indY);
    box[3] = new Box(indX + 1, indY);
    isDead = false;
    skipMove = false;
  }
  
  @Override
  void rotateLeft(){
    if(!isDead && canRotate()){
      if(rotationCount == 0){
        box[0].add(2, 0);
        box[1].add(1, 1);
        box[2].add(0, 0);
        box[3].add(-1, 1);
        increaseRotation();
      } else if(rotationCount == 1){
        box[0].add(0, 2);
        box[1].add(-1, 1);
        box[2].add(0, 0);
        box[3].add(-1, -1);
        increaseRotation();
      } else if(rotationCount == 2){
        box[0].add(-2, 0);
        box[1].add(-1, -1);
        box[2].add(0, 0);
        box[3].add(1, -1);
        increaseRotation();
      } else if(rotationCount == 3){
        box[0].add(0, -2);
        box[1].add(1, -1);
        box[2].add(0, 0);
        box[3].add(1, 1);
        increaseRotation();
      }
    }
  }
  
  boolean canRotate(){
    canRotate = true;
    copy = Util.copyBoxArray(box);
    
    if(!isDead){
      if(rotationCount == 0){
        copy[0].add(0, 2);
        copy[1].add(1, 1);
        copy[2].add(0, 0);
        copy[3].add(1, -1);
      } else if(rotationCount == 1){
        copy[0].add(-2, 0);
        copy[1].add(-1, 1);
        copy[2].add(0, 0);
        copy[3].add(1, 1);
      } else if(rotationCount == 2){
        copy[0].add(-2, 0);
        copy[1].add(-1, -1);
        copy[2].add(0, 0);
        copy[3].add(1, -1);
      } else if(rotationCount == 3){
        copy[0].add(0, -2);
        copy[1].add(1, -1);
        copy[2].add(0, 0);
        copy[3].add(1, 1);
      }
    }
    
    for(int i = 0; i < copy.length; i++){
      if((copy[i].indY > 19 || copy[i].indX < 0 || copy[i].indX > 9)
      || (grid[copy[i].indX][copy[i].indY].isFull)){
        canRotate = false;
      }
    }
    
    return canRotate;
  }
  
  void show(){
    stroke(200, 70, 230);
    strokeWeight(2);
    fill(250, 50, 255);
    for(Box b : box){
      if(b.isOn){
        rect(b.x, b.y, boxWidth, boxWidth);
      }
    }
  }
}
