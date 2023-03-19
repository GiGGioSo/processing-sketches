/*
  
  Questo è un programma mai finito, con cui però ho potuto imparare molte cose.
  Ho usato il Perlin Noise per generare terreno infinito automaticamente : prima cosa che ho imparato a fare con questo programma.
  Come seconda cosa ho anche imparato un po di ottimizzazione in quanto ho fatto un meccanismo per cui il terreno viene generato solo quando serve,
  cioè quando il giocatore si muove.
  Inoltre ho anche testato una divisione del terreno ispirata a Minecraft, una divisione in Chunks, cioè 'blocchi' di blocchi da 16, per poter gestire meglio la generazione del terreno.
  Purtroppo non sono riuscito a superare l'ostacolo della collisione del player con il terreno ed è andata a finire che ho lasciato stare.
  
*/

final int startX = 1000;
final int unit = 20;
final float scale = 0.035;
ArrayList<Chunk> map = new ArrayList<Chunk>(0);
Player player;

void setup(){
  size(600, 600);
  player = new Player(width / 2, 10);
  map.add(new Chunk(startX, -11));
}

void draw(){
  background(100);
  
  player.show();
  
  for(int i = 0; i < map.size(); i++){
    map.get(i).show();
  }
  
  generateMap();
  
}

void moveMap(float move){
  for(int i = 0; i < map.size(); i++){
    map.get(i).moveBy(move);
  }
}

void generateMap(){
  boolean generateBehind = true, generateFront = true;
  float lastX = 0, firstX = 0;
  int lastOffset = 0, firstOffset = 0;
  for(int i = 0; i < map.size(); i++){
    if(map.get(i).terrain[0][0].x < -width) generateBehind = false; //Behind
    if(map.get(i).terrain[15][0].x + unit > width * 2) generateFront = false; //Front
    if(map.get(i).terrain[0][0].x < lastX){  //Behind
      lastX = map.get(i).terrain[0][0].x;
      lastOffset = map.get(i).offset;
    }
    if(map.get(i).terrain[15][0].x  + unit > firstX){  //Front
      firstX = map.get(i).terrain[15][0].x + unit;
      firstOffset = map.get(i).offset;
    }
  }
  /*println("lastX : " + lastX + ";   lastOffset : " + lastOffset + ";   Map size : " + map.size() + ";   generateBehind : " + generateBehind);
  println("firstX : " + firstX + ";   firstOffset : " + firstOffset + ";   Map size : " + map.size() + ";   generateFront : " + generateFront);
  print("\n\n\n"); */
  if(generateBehind){
    map.add(new Chunk(lastOffset - 16, lastX - unit * 16));
  }
  if(generateFront){
    map.add(new Chunk(firstOffset + 16, firstX));
  }
  
}

void keyPressed(){
  if(key == 'a') moveMap(20);
  if(key == 'w') player.y -= 5;
  if(key == 's') player.y += 5;
  if(key == 'd') moveMap(-20);
}

void keyReleased(){
  
}
