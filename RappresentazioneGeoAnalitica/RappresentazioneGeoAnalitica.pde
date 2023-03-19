/*

  In questo programma ho rappresentato una parabola a cui si puo cambiare i parametri.
  La mia volontà era quella di poter zoommare verso il mouse, ma mi sono reso conto che
  è veramente complicato e quindi si puo' zoommare solo verso il centro.
  Con il tasto sinistro si zoomma in, destro out.

*/

final int unit = 10;
Parabola delta;

float scale = 1;

void setup(){
  size(840, 840);
  delta = new Parabola("Gio", 1, -5, 6);
}

void draw(){
  background(180);
  translate(width / 2, height / 2);
  scale(scale);
  showContorni();
  delta.update();
  delta.show();
  
}

void mousePressed(){
  if(mouseButton == RIGHT){
    scale -= 0.1;
  } else if(mouseButton == LEFT){
    scale += 0.1;
  }
}

void showContorni(){
  
  //Assi cartesiani
  line(-height*2, 0, +height*2, 0); //Asse X
  line(0, -height*2, 0, height*2); //Asse Y
  
  //Lineeette
  for(int i = -height*2; i < height*2; i+=unit){ //Asse X
    line(i, - 3, i, + 3);
  }
  for(int i = -height*2; i < height*2; i+=unit){ //Asse X
    line(- 3, i, + 3, i);
  }
}
