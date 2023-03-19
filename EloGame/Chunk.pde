class Chunk {
  
  Block[][] terrain = new Block[16][];
  
  int offset;
  float x;
  
  Chunk(int offset, float x){
    this.offset = offset;
    this.x = x;
    generateTerrain();
  }
  
  private void generateTerrain(){
    
    for(int i = 0; i < 16; i++){
      int alt = (int)map(noise((offset + i) * scale), 0, 1, 2, height / unit - 1);
      terrain[i] = new Block[alt];
      
      for(int j = 0; j < alt; j++){
        
        terrain[i][j] = new Block((int)x + i*unit, height - j*unit);
        
      }
    }
  }
  
  void show(){
    for(int i = 0; i < 16; i++){
      for(int j = 0; j < terrain[i].length; j++){
        terrain[i][j].show();
      }
    }
  }
  
  void moveBy(float move){
    for(int i = 0; i < 16; i++){
      for(int j = 0; j < terrain[i].length; j++){
        terrain[i][j].x += move;
      }
    }
  }
}
