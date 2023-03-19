class Parabola{
  
  int a, b, c;
  
  float delta;
  
  String nome;
  
  float[] zeri = new float[2];
  
  @Override
  String toString(){
    return "Parabola : " + nome + "\t Parametri : (" + a + ", " + b + ", " + c + ") \t " + toZeri();
  }
  
  public Parabola(String nome, int a, int b, int c){
    this.nome = nome;
    this.a = a;
    this.b = b;
    this.c = c;
  }
  
  void update(){
    findZero();
  }
  
  void show(){
    
    noFill();
    beginShape();
    for(float x = - height / 2 + 100; x < height / 2 + 100; x += 0.001){
      float y = - (a * pow(x, 2) + b * x + c);
      vertex(x * unit, y * unit);
    }
    endShape();
  }
  
  void findZero(){
    delta = pow(b, 2) - 4*a*c;
    if(delta > 0){
      zeri[0] = (-b - sqrt(delta)) / 2*a;
      zeri[1] = (-b + sqrt(delta)) / 2*a;
    } else if(delta == 0){
      zeri[0] = -b / (2*a);
      zeri[1] = zeri[0];
    }
  }
  
  String toZeri(){
    return "Zeri della parabola : (" + zeri[0] + ", " + zeri[1] + ")";
  }
}
