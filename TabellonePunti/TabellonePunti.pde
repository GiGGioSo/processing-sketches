import processing.serial.*;

//1  Punteggio1 : A = +1,   B = -1;
//2  Set1 : A = +1,   B = -1;
//3  Tempo : A = Start/Stop,   B = Reset;
//4  Punteggio2 : A = +1,   B = -1;
//5  Set2 : A = +1,   B = -1;


// FONTS
PFont fontDelTempo;
PImage background;
int timeFont, pointFont, faulFont, setFont;
boolean prop; //16:9 = true,  4:3 = false;
int timeW;


//Proporzioni
float timex, timey;
float p1x, py, p2x;
float f1x, f2x, fy;
float cx, cy;
float curx, cury;


int num = 1;

//SPORT = 0 : Pallavolo;  SPORT = 1 : Basket;
final int SPORT = 1;

int punti1, punti2, set1, set2;
int currentSet;

CountDownClock clock;

boolean alreadyPressed;

Serial port;

void setup(){
  fullScreen();
  if(width * 9 == height * 16) prop = true; else if(width * 4 == height * 3);
  fill(255);
  timeFont  = 223; //era 160
  pointFont = 325;
  faulFont = 132;
  setFont = 105;
  timex = width * 11/40;
  timey = height * 1/4+10;
  p1x = width * 113/4000;
  py = height * 33/50;
  p2x = width * 2306/4000;
  f1x = width * 135/4000;
  f2x = width * 866/1000;
  fy = height * 222/250;
  curx = width * 458/1000;
  cury = height * 452/1000;
  background = loadImage("TabellonePunti.png");
  fontDelTempo = createFont("FontNeroSfondoBianco.TTF", 1);
  textFont(fontDelTempo);
  resetAll();
  if(SPORT == 1){
    clock = new CountDownClock(90);
  } else {
    clock = new CountDownClock(0);
  }
  //String portName = Serial.list()[32];
  //port = new Serial(this, portName, 9600);
}

void draw(){
  
  image(background, 0, 0, width, height);
  
  drawTime();
  drawPoints();
  drawFauls();
  drawSet();
  
  
  if(clock != null){
    clock.update();
  }
  
  if(!clock.running && clock.time == 0 && SPORT==1){
    set1 = 0;
    set2 = 0;
    currentSet += num;
    num = 0;
  } else num = 1;
  /*
  if(frameCount % 40 == 0){
    println(punti1 + ",  " + punti2);
    println(set1 + ",  " + set2);
    println(clock.useTime + ",  " + currentSet);
  }
  */
}

void serialEvent(Serial p){
  try {
    String fullData = p.readStringUntil('\n');
    if(fullData != null){
      String[] data = split(trim(fullData), ',');
      if(data.length == 2){
        switch(data[0]){
          case "0":
            if(data[1].equals("A")) punti1++; else if(data[1].equals("B")) punti1--;
            break;
          case "1":
            if(data[1].equals("A")) addSet(1, 1); else if(data[1].equals("B")) addSet(1, -1);
            break;
          case "2":
            if(data[1].equals("A")) changeTime(); else if(data[1].equals("B")) clock.reset();
            break;
          case "3":
            if(data[1].equals("A")) punti2++; else if(data[1].equals("B")) punti2--;
            break;
          case "4":
            if(data[1].equals("A")) addSet(2, 1); else if(data[1].equals("B")) addSet(2, -1);
            break;
          default:
            println("ERROR : Messaggio invalido;  data : " + data[0] + "," + data[1]);
        }
      } else {
        println("ERROR : Dati in eccesso;  data length : " + data.length);
      }
    }
  } catch (Exception e){
    e.printStackTrace();
  }
}

//TEST PROGRAMMA//
/*
void evento(String a, String b){
  
      String[] data = new String[2];
      data[0] = a;
      data[1] = b;
      if(data.length == 2){
        switch(data[0]){
          case "1":
            if(data[1].equals("A")) punti1++; else if(data[1].equals("B")) punti1--;
            break;
          case "2":
            if(data[1].equals("A")) addSet(1, 1); else if(data[1].equals("B")) addSet(1, -1);
            break;
          case "3":
            if(data[1].equals("A")) changeTime(); else if(data[1].equals("B")) clock.reset();
            break;
          case "4":
            if(data[1].equals("A")) punti2++; else if(data[1].equals("B")) punti2--;
            break;
          case "5":
            if(data[1].equals("A")) addSet(2, 1); else if(data[1].equals("B")) addSet(2, -1);
            break;
          default:
            println("ERROR : Messaggio invalido;  data : " + data[0] + "," + data[1]);
        }
      } else {
        println("ERROR : Dati in eccesso;  data length : " + data.length);
      }
    
}
*/
//////////////////

void addSet(int ind, int x){
  if(ind == 1){
    set1+=x;
  }  else if(ind == 2){
    set2+=x;
  }
  
  
  if(SPORT == 1){
    if(set1 > 5) set1 = 5;
    if(set2 > 5) set2 = 5;
  }
  
  if(SPORT == 0){
    punti1 = 0;
    punti2 = 0;
    currentSet+=x;
  }
}

void changeTime(){
  if(clock.running) clock.ferma(); else clock.parti();
}

void resetAll(){
  punti1 = 0;
  punti2 = 0;
  set1 = 0;
  set2 = 0;
  currentSet = 1;
}

void drawTime(){
  fill(255, 0, 0);
  textSize(timeFont);
  text(clock.toString(), timex, timey);
}

void drawPoints(){
  fill(255, 0, 0);
  textSize(pointFont); 
  
  // Punti1
  if(punti1 < 10) text("00"+str(punti1), p1x, py); 
  else if(punti1 < 100) text("0"+str(punti1), p1x, py); 
  else text(str(punti1), p1x, py);
  
  //Punti2
  if(punti2 < 10) text("00"+str(punti2), p2x, py); 
  else if(punti2 < 100) text("0" + str(punti2), p2x, py); 
  else text(str(punti2), p2x, py);
}

void drawFauls(){
  fill(255, 0, 0);
  textSize(faulFont);
  
  //Falli & Set 1
  text('0'+str(set1), f1x, fy);
  
  //Falli & Set 2
  text('0'+str(set2), f2x, fy);
}

void drawSet(){
  fill(255, 0, 0);
  textSize(setFont);
  if(currentSet < 10) text('0'+str(currentSet), curx, cury); else text(str(currentSet), curx, cury);
}

void keyPressed(){
  changeTime();
}
