class CountDownClock{
  
  boolean running;
  float time;
  int min;
  int sec;
  int cent;
  float useTime;
  float currentTime;
  float startTime;
  
  public CountDownClock(float startTime){
    running = false;
    time = startTime;
    this.startTime = startTime;
  }
  
  public void update(){
    if(running){
      time -= (millis() - currentTime)/1000;
      currentTime = millis();
    }
    if(time < 0){
      time = 0;
      running = false;
    }
    useTime = round(clock.time*100)/100.;
    min = int(time/60);
    sec = int(time - min*60);
    cent = int((useTime - (min*60 + sec))*100);
    if(cent == 10) cent = 1;
  }
  
  public void ferma(){
    running = false;
  }
  
  public void parti(){
    running = true;
    currentTime = millis();
  }
  
  void reset(){
    time = startTime;
    ferma();
  }
  
  @Override
  String toString(){
    String Min, Sec, Cent;
    if(time > 60){
      if(min < 10) Min = "0"+str(min); else Min = str(min);
      if(sec < 10) Sec = "0"+str(sec); else Sec = str(sec);
      return Min+":"+Sec;
    } else {
      if(sec < 10) Sec = "0"+str(sec); else Sec = str(sec);
      if(cent < 10) Cent = "0"+str(cent); else Cent = str(cent);
      return Sec+":"+Cent;
    }
  }
}
