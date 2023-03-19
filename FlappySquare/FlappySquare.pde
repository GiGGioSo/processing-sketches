/*

  Semplice programma che emula flappy bird, ma usando i quadrati e i rettangoli, perché più semplici da gestire.
  L'unica parte interessante è quella della generazione dei tubi infinita e la casualità con cui si creano
  
  COMANDI :
  Tasto sinistro = jump;
  Tasto destro = reset game;

*/

Player player;
Tubi tubi;

void setup(){
  size(720, 600);
  player = new Player(200, height / 2, 30);
  tubi = new Tubi();
}

void draw(){
  if(!player.onGround){
    background(100);
    tubi.move();
    player.update();
    player.show();
  }
}


void mousePressed(){
  if(player.isAlive && mouseButton == LEFT){
    player.jump();
  } else if(!player.isAlive && mouseButton == RIGHT){
    resetGame();
  }
}

void resetGame(){
  frameCount = 0;
  player = new Player(200, height / 2, 30);
  tubi = new Tubi();
}
