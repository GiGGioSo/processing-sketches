class Rectangle{
  
  int x, y, w, h;
  
  Circle c1, c2, c3, c4;
  
  public Rectangle(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    c1 = new Circle(x - 1, y - 1, 0);
    c2 = new Circle(x + w + 1, y - 1, 0);
    c3 = new Circle(x + w + 1, y + h + 1, 0);
    c4 = new Circle(x - 1, y + h + 1, 0);
  }
  
  void checkCollision(){
    //Bordo sinistro
    if(ball.position.x + ball.r >= x && ball.position.x - ball.r <= x+w && ball.position.y - ball.r <= y+h && ball.position.y + ball.r >= y){
      if((ball.position.y - ball.r <= y+h || ball.position.y + ball.r >= y) && (ball.position.x <= x + w && ball.position.x >= x)){
        ball.velocity.y *= -0.85;
        /*if(ball.vel.y > 0){
          ball.pos.y = y + h + ball.r;
        } else {
          ball.pos.y = y - ball.r;
        }*/
        ball.position = new PVector(ball.prev_x, ball.prev_y);
      } else if(ball.position.x + ball.r >= x || ball.position.x - ball.r <= x+w){
        ball.velocity.x *= -0.85;
        /*if(ball.vel.x > 0){
          ball.pos.x = x + w + ball.r;
        } else {
          ball.pos.x = x - ball.r;
        }*/
        ball.position = new PVector(ball.prev_x, ball.prev_y);
      }
    }
    
    c1.checkCollision(ball);
    c2.checkCollision(ball);
    c3.checkCollision(ball);
    c4.checkCollision(ball);
  }
  
  void show(){
    fill(150, 150, 200, 100);
    stroke(255, 100, 100);
    strokeWeight(4);
    rect(x, y, w, h);
    c1.show();
    c2.show();
    c3.show();
    c4.show();
  }
}
