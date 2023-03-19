import processing.sound.*;

PShape sec;
PShape square;
float rot_unit = PI/30;
float index_unit = PI/6;
float index_radius = 130;
color bg;

SoundFile tick;

void setup() {
    size(300, 300);
    initializeShape();
    tick = new SoundFile(this, "tick.mp3");
    tick.amp(0.1);
    bg = color(random(255),random(255),random(255));
}

void draw() {
    clear();
    background(bg);
    if (frameCount % 60 == 0) {
        sec.rotate(rot_unit);
        tick.play();
    }
    drawContourn();
    shape(sec);
}

void initializeShape() {
    sec = createShape();
    sec.beginShape();
    sec.fill(0);
    sec.vertex(10, 0);
    sec.vertex(0, 10);
    sec.vertex(-10, 0);
    sec.vertex(0, -120);
    sec.endShape(CLOSE);
    sec.translate(width/2, height/2);
}

void drawContourn() {
    rectMode(CENTER);
    for (int i = 0; i < 60; i++) {
        push();
        noStroke();
        translate(width/2 + cos(rot_unit * i) * index_radius, height/2 + sin(rot_unit * i) * index_radius);
        rotate(rot_unit * i);
        if (i % 5 == 0) {
            fill(255, 0, 0);
            rect(0, 0, 20, 4);
        } else {
            fill(0, 0, 255);
            rect(0, 0, 10, 2);
        }
        pop();
    }
}
