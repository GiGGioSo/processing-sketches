final int gridW = 10, gridH = 20;
final int boxWidth = 40;

int rand;

int count;
boolean alreadyCalled;
int lastCalled;

Box[][] grid;

ArrayList<Shape> shapes = new ArrayList<Shape>();
void setup(){
  size(750, 800);
  grid = new Box[gridW][gridH];
  for(int i = 0; i < gridW; i++){
    for(int j = 0; j < gridH; j++){
      grid[i][j] = new Box(i, j);
    }
  }
  rand = (int) random(3);
  if(rand == 0){
    shapes.add(new Line(5, 1));
  } else if(rand == 1){
    shapes.add(new ZigR(5, 1));
  } else if(rand == 2){
    shapes.add(new ZigL(5, 1));
  }
  count = 0;
}

void draw(){
  background(100);
  
  if(shapes.get(count).isDead){
      rand = (int) random(3);
    if(rand == 0){
      shapes.add(new Line(5, 1));
    } else if(rand == 1){
      shapes.add(new ZigR(5, 1));
    } else if(rand == 2){
      shapes.add(new ZigL(5, 1));
    }
    count++;
  }
  
  for(Shape s : shapes){
    s.update();
    s.show();
  }
  
  checkLines();
  
  
  //Bordo gameSpace
  noFill();
  stroke(250, 10, 10);
  strokeWeight(2);
  rect(50, 0, 400, 800);
  
  //Game grid
  
  
  
  //
  
}

void checkLines(){
  for(int i = 0; i < gridH; i++){
    boolean lineFull = true;
    for(int j = 0; j < gridW; j++){
      if(!grid[j][i].isFull){
        lineFull = false;
      }
    }
    println(i + ", " + lineFull);
    if(lineFull){
      for(int x = 0; x < gridW; x++){
        grid[x][i].isFull = false;
      }
      for(Shape s : shapes){
        s.fallDown(i);
      }
    }
    /*if(frameCount % 30 == 0){
      for(int x = 0; x < gridH; x++){
        if(x < 10){
          print(x + "  : ");
        } else {
          print(x + " : ");
        }
        for(int y = 0; y < gridW; y++){
          if(grid[y][x].isFull)
            print(1 + " ");
          else
            print(0 + " ");
        }
        println();
      }
    }*/
  }
}

void keyReleased(){
  for(Shape s : shapes){
    s.useInput();
  }
}