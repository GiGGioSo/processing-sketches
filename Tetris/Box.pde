class Box{
  int x, y;
  int indX, indY;
  boolean isFull;
  boolean isOn;
  
  Box(int indX, int indY){
    this.indX = indX;
    this.indY = indY;
    calcolateCoords();
    isFull = false;
    isOn = true;
  }
  
  void add(int x, int y){
    indX += x;
    indY += y;
    calcolateCoords();
  }
  
  void calcolateCoords(){
    x = 50 + indX * boxWidth;
    y = indY * boxWidth;
  }
}
