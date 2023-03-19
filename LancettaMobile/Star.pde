class Star {

    PShape shape;
    PVector pos;
    PVector vel;
    float acc = 0.97;
    float rot;


    Star(float x, float y, PVector vel) {
        shape = createShape();
        shape.beginShape();
        shape.noStroke();
        shape.vertex(40, 0);
        shape.vertex(10, 10);
        shape.vertex(0, 40);
        shape.vertex(-10, 10);
        shape.vertex(-40, 0);
        shape.vertex(-10, -10);
        shape.vertex(0, -40);
        shape.vertex(10, -10);
        shape.endShape(CLOSE);
        pos = new PVector(x, y);
        this.vel = vel.copy();
        this.vel.mult(0.5);
        shape.translate(pos.x, pos.y);
    }

    Star(PVector pos) {
        this(pos.x, pos.y, new PVector(0, 0));
    }

    void update() {
        vel.mult(acc);
        shape.translate(vel.x, vel.y);
        if (rot > TWO_PI) rot = 0;
    }

    void show() {
        fill(0, 55);
        shape(shape);
    }
}
