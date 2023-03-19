/*

  Questo è uno dei pochi programmi che ho totalmente finito.
  Per poterlo usare bisogna importare la libreria del suono di processing.
  Scegliere la difficolta e quindi poi schiacciare "Play".
  A sinistra c'è il punteggio e le combo di colpi colpiti.
  Ci si muove con le freccette (una volta iniziato a muovere non ci si puo fermare e si rimbalza sui bordi);
  Per sparare bisogna usare il tasto sinistro del mouse;
  Con lo spazio si ritorna al menu iniziale (uno volta premuto spazio bisogna schiacciare un qualsiasi altro tasto per cambiare la variabile 'key')
  ABBASSARE IL VOLUME PRIMA DI FARLO PARTIRE, PARTE AL MASSIMO

*/

import processing.sound.*;

GameState gameState;
MenuState menuState;
SoundFile hit, music, point;


void setup(){
  frameRate(80);
  size(640, 400);
  menuState = new MenuState(this);
  hit = new SoundFile(this, "hit.mp3");
  music = new SoundFile(this, "music.mp3");
  point = new SoundFile(this, "point.mp3");
}

void draw(){
  background(150);
  
  if(menuState.isOn){
    menuState.update();
    menuState.show();
  } else if(gameState.isOn){
    gameState.update();
    gameState.show();
  }
  
}
