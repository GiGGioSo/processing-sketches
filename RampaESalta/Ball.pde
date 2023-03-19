class Ball{
  
  final static int r = 20;
  
  PVector pos, vel, acc;
  
  boolean isLeft, alreadyJumped, stopped;
  
  Ball(int x, int y){
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    if(x < width / 2){
      isLeft = true;
    } else {
      isLeft = false;
    }
    alreadyJumped = false;
  }
  
  void update(){
    if(!stopped) {
      vel.add(acc);
    }
    pos.add(vel);
    checkJump();
    checkBordi();
  }
  
  void show(){
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  void setAcc(PVector piano){
    acc = piano.copy();
    acc.setMag(g * sin(piano.heading()));
  }
  
  void checkJump(){
    if(!alreadyJumped){
      if(((isLeft && pos.x > width/2) || (!isLeft && pos.x < width/2)) && pos.y + r > height / 2){
        if(isLeft){
          vel.x -= 2.5;
        } else {
          //vel.x += 2.5;
        }
        vel.y = -4;
        acc = new PVector(0, g);
        alreadyJumped = true;
      }
    }
  }
  
  void checkBordi(){
    if(alreadyJumped){
      if(pos.x - r < 0){
        pos.x = r;
        vel.x *= -0.8;
      }
      if(pos.x + r > width){
        pos.x = width - r;
        vel.x *= -0.8;
      }
      if(pos.y + r > height){
        pos.y = height - r;
        vel.y *= -0.6;
        vel.x *= 0.4;
      }
    } else {
      if(pos.x - r < 0){
        pos.x = r;
        vel.mult(-0.6);
        if(vel.mag() < 0.2) {
          stopped = true;
          vel.setMag(0);
        }
      }
      if(pos.x + r > width){
        pos.x = width - r;
        vel.mult(-0.6);
        if(vel.mag() < 0.2) {
          stopped = true;
          vel.setMag(0);
        }
      }
      if(pos.y + r > height){
        pos.y = height - r;
        acc.x = 0;
        vel.x *= 0.7;
        vel.y *= -0.7;
        alreadyJumped = true;
      }
    }
  }
}
