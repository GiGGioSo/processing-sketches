class Rectangle{
  int x, y, w, h;
  
  public Rectangle(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  boolean intersect(Rectangle other){
    return !(x > other.x + other.w ||
     x + w < other.x ||
     y > other.y + other.h ||
     y + h < other.y);
  }
}
