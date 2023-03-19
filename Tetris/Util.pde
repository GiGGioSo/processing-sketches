static class Util{
  
  static Box[] copyBoxArray(Box[] box){
    Tetris t = new Tetris();
    Box[] copy = new Box[box.length];
    
    for(int i = 0; i < box.length; i++){
      copy[i] = t.new Box(box[i].indX, box[i].indY);
    }
    
    return copy;
  }
}
