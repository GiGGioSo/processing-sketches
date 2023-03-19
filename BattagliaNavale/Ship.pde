class Ship {
    
    color c = color(250, 20, 20);
    
    int indx = -1, indy = -1; // coordinate sulla griglia di gioco
    int x, y; // effettive coordinate sullo schermo
    int startx, starty; // posizione iniziale per in caso rimettere la nave dov'era
    
    int len; // lunghezza della barca
    boolean vertical; // true se posta verticalmente, false se posta orrizontalmente
    boolean initial_vertical;
    boolean positioned;
    
    public Ship(int x, int y, int len, boolean vertical) {
        this.x = x;
        this.y = y;
        startx = x;
        starty = y;
        this.len = len;
        this.vertical = vertical;
        initial_vertical = vertical;
        positioned = false;
    }
    
    void update() {
    }
    
    void show() {
        stroke(0, 0, 0);
        strokeWeight(2);
        fill(c);
        rect(x, y, dimX, dimY);
        for(int i = 1; (len > 1) && (i < len); i++) {
            if(vertical) {
                rect(x, y + i * dimY, dimX, dimY);
            } else {
                rect(x + i * dimX, y, dimX, dimY);
            }
        }
    }
    
    void turn() {
        if(vertical) vertical = false;
        else vertical = true;
    }
    
    void setCenter(int x, int y) {
        this.x = x - dimX / 2;
        this.y = y - dimY / 2;
    }
    
    boolean containsMouse(int mx, int my) {
        boolean contains = false;
        if(vertical) {
            if(mx < x + dimX && mx > x && my < y + dimY * len && my > y) contains = true;
        } else {
            if(mx < x + dimX * len && mx > x && my < y + dimY && my > y) contains = true;
        }
        return contains;
    }
    
}
