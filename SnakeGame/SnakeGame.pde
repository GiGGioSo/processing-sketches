/*


 COMANDI:
 movimento con le freccette.
 si parte da ferrmi.
 quando si muore bisogna premere SPACE per resettare la partita.
 
 KNOWN BUGS:
 che io sappia, solo uno: ogni tanto il pezzo di cibo si genera sopra il serpente. Non ho la più pallida idea del perchè, se trova il motivo sarebbe molto bello se me lo riferisse.
 
 NOTE A CASO:
 1- non c'è un vero motivo per cui la testa è un cuore, volevo solo usare le curve bezier.
 2- mi rendo conto che il codice è disorginato e non un granchè generalizzato, ma essendo la fine di questo progetto non importa un granchè
 3- ho perso fin troppo tempo per fare il sistema di colori (di cui sono piuttosto soddisfatto ora), all'inizio avevo l'idea ma l'avevo fatto in modo sbagliatissimo e poi l'ho corretto, ed è per questo che è disordinato.
 
 P.S. : avevo già fatto per conto mio il gioco snake, ma faceva un po' schifo.
        Ho cambiato il modo con cui decido dove muovere il serpente, per evitare anche vari bug e sinceramente così è molto più bello e mi ha permesso di usare le Enum, che uso raramente.
        (Il bug era che, se all'interno del tempo che il serpente stava a fare uno scatto, io gli davo due precisi input, il serpente
        finiva per girarsi su se stesso e quindi morire lentamente inevitabilmente)
 
        La grafica non è il massimo, ma volendo si potrebbe aggiungere qualche immagine o suono.
        
        per la maggior parte delle cose basta modif icare i parametri iniziali, si può modificare numero di righe e spazio del campo di gioco (non può essere più grande dello schermo però)
 
        
        
 */
 
PShape head;
 
int gameW = 800;
int gameH = 800;
 
final int w = 10;
final int h = 10;

float gridW, gridH;
Apple apple;
Snake snake;

boolean gameOver;

final int minimumDifficulty = 4;
final int startingDifficulty = 20;
int difficulty;

long lastUpdate = 0;

void setup() {
    size(800, 900, P2D);
    if(gameW > width) gameW = width;
    if(gameH > height) gameH = height;
    gridW = gameW / w;
    gridH = gameH / h;
    snake = new Snake(2, 5, 3);
    apple = new Apple();
    gameOver = false;
    createHead();
    difficulty = startingDifficulty;
}

void draw() {
    background(100);
    fill(0);
    snake.update();
    snake.show();
    apple.show();
    drawGUI();
    if(gameOver) gameOverGUI();
}

void drawGUI() {
    stroke(200);
    strokeWeight(1);
    line(0, 0, gameW-1, 0);
    line(gameW-1, 0, gameW-1, gameH-1);
    line(gameW-1, gameH-1, 0, gameH-1);
    line(0, gameH-1, 0, 0);
    textSize(30);
    fill(170);
    text("Score : " + snake.points, 10, gameH + 50);
}

void keyPressed() {
    
    if(key == CODED) {
        switch(keyCode) {
        case UP:
            snake.move(Move.UP);
            break;
        case LEFT:
            snake.move(Move.LEFT);
            break;
        case DOWN:
            snake.move(Move.DOWN);
            break;
        case RIGHT:
            snake.move(Move.RIGHT);
            break;
        default:
            println("ERROR : 'keyCode' not recognised!");
            break;
        }
    }
    
    if (key == ' ' && gameOver) {
        resetGame();
    }
}

void gameOverGUI() {
    fill(170);
    textSize(45);
    text("GAME OVER", gameW/2 - 125, gameH/2 - 20);
    textSize(20);
    text("press SPACE to restart", gameW/2 - 100, gameH/2 + 10);
}

void resetGame() {
    snake = snake.reset();
    apple.generateCoord();
    lastUpdate = 0;
    difficulty = startingDifficulty;
    gameOver = false;
}

void createHead() {
    head = createShape();
    head.beginShape();
    head.fill(20, 200);
    head.stroke(0);
    head.strokeWeight(18);
    head.vertex(0, 100);
    head.bezierVertex(190, -40, 50, -150, 0, -50);
    head.bezierVertex(-50, -150, -190, -40, 0, 100);
    head.endShape();
}
