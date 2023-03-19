PShape figura;
float x, y;
int tail = 600;
boolean attached;

ArrayList<Star> stars;

void setup() {
    size(1000, 1000);
    figura = createShape();
    figura.beginShape();
    figura.noStroke();
    figura.fill(250, 10, 10);
    figura.vertex(40, 0);
    figura.vertex(10, 10);
    figura.vertex(0, 40);
    figura.vertex(-10, 10);
    figura.vertex(-40, 0);
    figura.vertex(-10, -10);
    figura.vertex(0, -40);
    figura.vertex(10, -10);
    figura.endShape(CLOSE);
    stars = new ArrayList<Star>(tail);
    attached = false;
}

void draw() {
    clear();
    background(100);
    x = mouseX;
    y = mouseY;
    println(attached);
    if(attached) {
        stars.add(0, new Star(x, y, new PVector(mouseX-pmouseX, mouseY-pmouseY)));
    } else {
        stars.add(0, new Star(x, y, new PVector(0, 0)));
    }
    if(stars.size() > tail) stars.remove(tail);
    for(int i = 0; i < stars.size(); i++) {
        stars.get(i).update();
        stars.get(i).show();
    }
}

void mousePressed() {
    if(mouseButton == CENTER) attached = attached ? false : true;
}
