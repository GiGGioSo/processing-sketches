/*

  In questo programma ho usato per la prima volta vari 'Stati',
  cioè vari momenti nel gioco : nel primo bisogna muovere il mouse
  e scegliere una direzione sciacciando tasto sinistro, mentre nel secondo
  è la palla a muoversi in base a dove si ha premuto il mouse.
  
  Consiglio di provare un po' tutte le angolazioni a cui la palla puo' cadere.

*/



FirstState s1;
SecondState s2;

final float g = 0.12;

void setup(){
  size(720, 640);
  s1 = new FirstState();
  s2 = new SecondState();
}

void draw(){
  background(100);
  s1.update();
  s1.show();
  s2.update();
  s2.show();
}

void mousePressed(){
  s1.isOn = false;
  s2.tookVector(s1.dir);
  s2.isOn = true;
}
