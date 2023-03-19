class Tubi{
  
  boolean haveToMove;
  
  ArrayList<Ostacolo> ostacoli;
  
  Tubi(){
    ostacoli = new ArrayList<Ostacolo>();
    ostacoli.add(new Ostacolo(2));
    haveToMove = true;
  }
  
  void move(){
    if(frameCount % 100 == 0){
      ostacoli.add(new Ostacolo(2));
    }
        
    for(int i = 0; i < ostacoli.size(); i++){
      Ostacolo ost = ostacoli.get(i);
      if(haveToMove){
        ost.update();
      }
      ost.hits(player);
      ost.show();
          
      if(ost.isOutOfBounds()){
        ostacoli.remove(i);
      } 
    }
  }
}
