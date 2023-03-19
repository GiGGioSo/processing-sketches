class SecondState{
  
  Ball ball;
  
  PVector piano;
  
  boolean isOn;
  
  SecondState(){
    isOn = false;
  }
  
  void update(){
    if(isOn){
      ball.update();
    }
  }
  
  void show(){
    if(isOn){
      pushMatrix();
      translate(width / 2, height / 2);
      line(0, 0, piano.x, piano.y);
      ellipse(0, 0, 10, 10);
      popMatrix();
      ball.show();
    }
  }
  
  void tookVector(PVector p){
    if(piano == null){
      piano = p.copy();
      piano.setMag(width);
      
      PVector m = p.copy();
      if(mouseX < width/2){
        m.rotate(PI / 2);
      } else if(mouseX > width/2){
        m.rotate(- PI / 2);
      }
      m.setMag(Ball.r);
      ball = new Ball(int(mouseX + m.x), int(mouseY + m.y));
      ball.setAcc(p);
    }
  }
}
