class Apple extends Cell {

    boolean intersect;

    Apple() {
        super(-1, -1);
        generateCoord();
    }

    void show() {
        fill(255, 10, 10, 150);
        strokeWeight(2);
        stroke(150, 10, 10);
        rect(x*gridW + 5, y*gridH + 5, gridW - 10, gridH - 10);
    }

    void die() {
        generateCoord();
    }

    void generateCoord() {
        int newX, newY;
        do {
            newX = (int) random(w);
            newY = (int) random(h);
            intersect = false;
            for (int i = 0; i < snake.body.size(); i++) {
                if (snake.body.get(i).x == newX && snake.body.get(i).y == newY) intersect = true;
            }
        } while (intersect);
        setCoord(newX, newY);
    }
}
