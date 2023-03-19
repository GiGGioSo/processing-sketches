class Box {

    int indx, indy;
    int offx, offy;

    int state; 
    /*   
    -1 = non definito
    0 = acqua
    1 = colpito
    2 = colpito e affondato
    */

    boolean used;
    
    static final int explotion_play_time = 1 * fps; //in secondi
    long startTime, currentTime;

    color default_color = color(230, 230, 250);
    color used_color = color(250, 20, 20);
    color water_color = color(0, 150, 255);
    color hit_color = color(230, 80, 20);
    color sinked_color = color(255, 0, 0);


    public Box(int indx, int indy, int offx, int offy) {
        this.indx = indx;
        this.indy = indy;
        this.offx = offx;
        this.offy = offy;
        state = -1;
        used = false;
    }

    public Box(int indx, int indy) {
        this(indx, indy, 0, 0);
    }

    void show() {
        stroke(0, 0, 0);
        strokeWeight(2);
        if (state == -1) {
            fill(default_color);
        } else if (state == 0) {
            fill(water_color);
        } else if (state == 1) {
            fill(hit_color);
        } else if (state == 2) {
            fill(sinked_color);
        }
        if(used) fill(used_color);
        rect(indx * dimX + offx, indy * dimY + offy, dimX, dimY);
        currentTime = frameCount;
        if(currentTime - startTime < explotion_play_time) {
            image(explotion, indx * dimX + offx, indy * dimY + offy, dimX, dimY);
        } else {
            startTime = 0;
        }
    }
    
    void hit() {
        state = 1;
        startTime = frameCount; 
        hit.play();
    }
    
    void sink() {
        state = 2;
    }
}
