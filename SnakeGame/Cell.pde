class Cell {
    float x, y;

    Cell(int x, int y) {
        setCoord(x, y);
    }

    void show(int c) {
        stroke(c, 255, 255);
        strokeWeight(4);
        fill(c, 255, 255, 200);
        ellipse((x+0.5) * gridW, (y+0.5) * gridH, gridW * 9/10, gridH * 9/10);
    }

    void showAsHead(Move move) {
        switch(move) {
            case UP:
                shape(head, (x+0.5) * gridW, (y+0.5) * gridH, gridW, gridH);
                break;
            case DOWN:
                head.rotate(PI);
                shape(head, (x+0.5) * gridW, (y+0.5) * gridH, gridW, gridH);
                head.rotate(-PI);
                break;
            case LEFT:
                head.rotate(-HALF_PI);
                shape(head, (x+0.5) * gridW, (y+0.5) * gridH, gridW, gridH);
                head.rotate(HALF_PI);
                break;
            case RIGHT:
                head.rotate(HALF_PI);
                shape(head, (x+0.5) * gridW, (y+0.5) * gridH, gridW, gridH);
                head.rotate(-HALF_PI);
                break;
            case STILL:
                head.rotate(HALF_PI);
                shape(head, (x+0.5) * gridW, (y+0.5) * gridH, gridW, gridH);
                head.rotate(-HALF_PI);
                break;
        }
    }

    void setCoord(int x, int y) {
        this.x = x;
        this.y = y;
    }
}
