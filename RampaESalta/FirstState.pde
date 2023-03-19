class FirstState{
  
  boolean isOn;
  
  PVector mouse, center, dir;
  
  FirstState(){
    center = new PVector(width / 2, height / 2);
    isOn = true;
  }
  
  void update(){
    if(isOn){
      mouse = new PVector(mouseX, mouseY);
      dir = PVector.sub(mouse, center);
    }
  }
  
  void show(){
    if(isOn){
      pushMatrix();
      translate(width / 2, height / 2);
      line(0, 0, dir.x, dir.y);
      popMatrix();
    }
  }
  
}
