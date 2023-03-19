class Ball extends Circle{
  
  int initial_x, initial_y;
  
  PVector acc, mouse;
  float vel_release, vel_max, vel_base;
  float dist_base;
  int d, r;
  boolean gravityOn;
  float prev_x, prev_y;
  
  boolean alreadyReleased;
  
  public Ball(int x, int y, int vel_base, int radius){
    super(x, y, radius);
    initial_x = x;
    initial_y = y;
    prev_x = x;
    prev_y = y;
    acc = new PVector(0, 0.3);
    this.vel_base = vel_base;
    vel_max = 12;
    r = radius;
    d = r * 2;
    dist_base = width / 6;
    gravityOn = true;
    alreadyReleased = false;
  }
  
  void update(){
    prev_x = position.x;
    prev_y = position.y;
    position.add(velocity);
    if(gravityOn){
      velocity.add(acc);
      velocity.limit(vel_max);
    }
    checkBordi();
    checkInputs();
  }
  
  void show(){
    fill(200, 0, 40, 100);
    stroke(255, 0, 0);
    strokeWeight(5);
    ellipse(position.x, position.y, d, d);
  }
  
  void checkBordi(){
    if(position.x < 0){
      position.x = 0;
      velocity.x *= -0.85;
    }
    if(position.x > width){
      position.x = width;
      velocity.x *= -0.85;
    }
    if(position.y > height){
      position.y = height;
      velocity.y *= -0.7;
    }
  }
  
  void reset(){
    position = new PVector(initial_x, initial_y);
    velocity.mult(0);
  }
  
  void checkInputs(){
    if(mousePressed){
      gravityOn = false;
      alreadyReleased = false;
      velocity.mult(0);
      mouse = new PVector(mouseX, mouseY);
      mouse.sub(position);
      vel_release = map(mouse.mag(), 0, dist_base, 0, vel_base);
      mouse.setMag(vel_release);
      mouse.limit(vel_max);
      
      //Disegno linea guida
      pushMatrix();
      translate(position.x, position.y);
      mouse.mult(20);
      line(0, 0, mouse.x, mouse.y);
      mouse.div(20);
      popMatrix();
      
    } else {
      if(!alreadyReleased){
        alreadyReleased = true;
        gravityOn = true;
        if(mouse != null){
          velocity = mouse;
        }
      }
    }
  }
}
