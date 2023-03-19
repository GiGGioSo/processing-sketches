/*
  In questo programma ho simulato un canestro. La palla essendo un cerchio crea dei problemi con la collisione sugli spigoli dei quadrati.
  Per giocare bisogna schiacciare con il tasto sinistro del mouse e in base alla distanza del puntatore dalla palla, la palla verrà lanciato più o meno forte.
  
  Ogni classe che ho creato si spiega da se con il nome datogli.
  
  Il codice per collisione tra sfere l'ho preso da un forum di processing, per poi accorgermi che in realtà non mi serviva.
*/

Ball ball;
Canestro canestro;

void setup(){
  size(720, 560);
  ball = new Ball(50, height - 50, 4, 20);
  canestro = new Canestro(width * 3/4, 200, 100);
}

void draw(){
  background(50);
  ball.update();
  canestro.update();
  ball.show();
  canestro.show();
}
