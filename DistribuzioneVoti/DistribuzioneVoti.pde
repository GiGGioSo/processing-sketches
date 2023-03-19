/*
  
  Questo programma l'ho creato per mio fratello. Aveva fatto una simulazione di un esame e voleva un grafico fatto rapidamente che potesse mostrare l'andamento generale.
  
  All'interno dell'array 'dati' sono presenti tutti i risultati ottenuti dai partecipante alla simulazione.
  
  Il codice l'ho scritto di fretta quindi risulta poco leggibile anche a me. Aggiungerò qualche descrizione accanto alle variabile per cercare di rendere il programma più leggibile.
  
*/

float dati[] = {
  24.4,
  16.2,
  3,
  31.6,
  20.3,
  24.1,
  42.7,
  45.3,
  26,
  43.8,
  30.9,
  30.5,
  -6,
  9.5,
  25.7,
  51.4,
  12.6,
  8.3,
  5.4,
  46.8,
  30,
  37,
  21.7,
  27.8,
  22.9,
  15.8,
  28.4,
  33.1,
  25.2,
  19.7,
  7,
  51.5,
  30.9,
  34.5,
  48.1,
  64.3,
  20.9,
  39.5,
  10.5,
  35.5,
  12.6,
  15.3,
  25.1,
  8.1,
  -6,
  51.9,
  3.8,
  2.7,
  29.6,
  23.1,
  28.3,
  10.4,
  57.8,
  23.2,
  14.8,
  24.4,
  34.9,
  38.2,
  16.4,
  52.6,
  -0.6,
  12.1,
  18.2,
  17.2,
  40.9,
  51.9,
  23.5,
  76.7,
  14.9,
  32.7,
  25.9,
  35.4,
  25.9,
  22.5,
  -2.1,
  32.1,
  39.4,
  38.8,
  6.2,
  38.4,
  35.2,
  25.8,
  32.2,
  11.5,
  45.7,
  24.1,
  19.7,
  37.6,
  10.8,
  -3.1,
  15.9,
  7.7,
  21.9,
  16.8,
  11,
  16
};

int numx;
float intervallox;
int counter = 0;
int intervalloy;
int som;
float boh = 5; // questa variabile indica l'intervallo per cui vengono raggruppati i voti; per esempio : quando vale 5 significa che si divide tutto in intervalli di 5 e si raggruppano
               // i voti all'interno di quell'intervallo. Più questa variabile aumenta più il grafico risulterà meno specifico.

void setup(){
  size(960, 720);
  numx = width / dati.length;
  intervallox = width / 100; // Questa variabile regola la "larghezza" degli intervalli, però non è molto ben implementata, quindi
                             // se cambiata porterà il programma a non funzionare correttamente
                             
  intervalloy = height / 30; // Questa variabile regola l'"altezza" degli intervalli, a differenza della larghezza, questa si puo cambiare. Con l'aumento del denominatore
                             // si otterrà un generale abbassamento del grafico. Consiglio di aumentare questa variabile (quindi abbassare il denominatore) nel caso in cui si vuole aumentare 'boh' e viceversa.
}

void draw(){
  fill(0, 0 ,0);
  line(width * 1/10, 0, width * 1/10, height);
  line(0, height - 100, width, height -100);
  text("Intevallo : " + str(boh), width - 100, 20); 
  
  noFill();
  beginShape();
  
  vertex(0, height);
  
  for(float i = 0; i <= 100; i+=boh){ // range voti
    
    text(str(i-10), i*width/100, height - 88);
    
    for(int s = 0; s < dati.length; s++){
      if(getInd(dati[s]) == i){
        
        counter++;
      }
      
    }
    if(counter != 0){
        vertex(i*intervallox + width/200*boh, height - counter * intervalloy - 100);
        fill(0, 0, 0);
        text(str(counter), i*intervallox + width/200*boh, height - counter*intervalloy - 85);
        noFill();
      }
    som+=counter;
    println(counter);
    counter = 0;
  }
  
  stop();
  
  endShape();
  
}

float getInd(float i){
  return (int)((i + 10) / boh) * boh;
}
