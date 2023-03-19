class Snake {
    
    int x, y;
    int initX, initY;
    int base_length;
    
    int points;
    
    private boolean increase_difficulty;
    
    int rainbow_index;
    final int rainbow_rate = 1;

    private Move nextMove;
    private Move lastMove;
    private final Move default_move =  Move.RIGHT;

    boolean alive;

    ArrayList<Cell> body = new ArrayList<Cell>(3);

    boolean up = false, right = true, left = false, down = false;

    Snake(int x, int y, int len) {
        this.x = x;
        this.y = y;
        initX = x;
        initY = y;
        base_length = len;
        for(int i = 0; i < len; i++) {
            body.add(new Cell(x - i, y));
        }
        nextMove = Move.STILL;
        lastMove = Move.STILL;
        alive = true;
        rainbow_index = 1;
        increase_difficulty = false;
    }

    void move(Move posMove) {
        switch(posMove) {
        case UP:
            if(lastMove != Move.DOWN) nextMove = Move.UP;
            break;
        case DOWN:
            if(lastMove != Move.UP) nextMove = Move.DOWN;
            break;
        case RIGHT:
            if(lastMove != Move.LEFT) nextMove = Move.RIGHT;
            break;
        case LEFT:
            if(lastMove == Move.STILL) nextMove = default_move;
            else if(lastMove != Move.RIGHT) nextMove = Move.LEFT;
            break;
        case STILL:
            nextMove = Move.STILL;
        }
    }

    boolean checkDied() {
        for (int i = 0; i < body.size()-1; i++) {

            if ((x > w-1 && nextMove == Move.RIGHT) ||
                (x < 0 && nextMove == Move.LEFT) ||
                (y > h-1 && nextMove == Move.DOWN) ||
                (y < 0 && nextMove == Move.UP)) {
                alive = false;
                gameOver = true;
                return true;
            }

            if (i > 0) {
                if (x == body.get(i).x && y == body.get(i).y) {
                    alive = false;
                    gameOver = true;
                    return true;
                }
            }
        }
        return false;
    }

    boolean eatsApple() {
        if (x == apple.x && y == apple.y) {
            apple.die();
            /*if(increase_difficulty)*/ difficulty--;
            increase_difficulty = increase_difficulty ? false : true;
            points++;
            if(difficulty < minimumDifficulty) difficulty = minimumDifficulty;
            return true;
        } else {
            return false;
        }
    }

    void update() {
        if(frameCount % rainbow_rate == 0 && alive) {
            rainbow_index += 3;
            if(rainbow_index > 360) {
                rainbow_index = 0;   
            }
        }
        if (frameCount - lastUpdate > difficulty && alive) {
            lastUpdate = frameCount;
            switch(nextMove) {
                case UP:
                    y--;
                    break;
                case DOWN:
                    y++;
                    break;
                case LEFT:
                    x--;
                    break;
                case RIGHT:
                    x++;
                    break;
                case STILL:
                    break;
            }
            if(checkDied()) return;
            lastMove = nextMove;
            if(nextMove != Move.STILL) {
                if (!eatsApple()) body.remove(body.size() - 1);
                body.add(0, new Cell(x, y));
            }
            
        }
    }

    void show() {
        colorMode(HSB, 360);
        for (int i = 0; i < body.size(); i++) {
            int n = (rainbow_index + (360000-(i*8)))%360; // il numero è alto semplicemente perche non voglio che diventi negativo
            if(i == 0) body.get(i).showAsHead(lastMove);
            else body.get(i).show(n);
        }
        colorMode(RGB);
    }

    Snake reset() {
        return new Snake(initX, initY, base_length);
    }
}
