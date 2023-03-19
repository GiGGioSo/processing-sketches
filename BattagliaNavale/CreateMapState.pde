class CreateMapState {

    boolean on;

    int map_offx, map_offy;

    int pickedup_ship = -1;

    Ship[] ships = new Ship[2];
    Box[][] boxes = new Box[n][n];

    public CreateMapState(int offx, int offy) {
        this.map_offx = offx;
        this.map_offy = offy;
        createBoxes();
        createShips();
        close();
    }

    void update() {
        if (!on) return;
        //if(frameCount % 50 == 0) println("pickedup : " + pickedup_ship);

        shipFollowCursor();

        boolean all_positioned = true;
        for (int i = 0; i < ships.length; i++) {
            if (ships[i].positioned == false) {
                all_positioned = false; 
                break;
            }
        }
        if (all_positioned) { // MANDARE MESSAGGIO AL SERVER CON ALL'INTERNO LE INFORMAZIONI RIGUARDO LE BARCHE
            String mymap = "setmap&mymap=";
            boolean first = true;
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (boxes[i][j].used) {
                        if (first) mymap += char(65 + i) + "" + (j+1);
                        else mymap += "-" + char(65 + i) + "" + (j+1);
                        first = false;
                    }
                }
            }
            println(mymap);
            if(setAction(mymap, notulol).getBoolean("error")) {
                mapCreator = new CreateMapState(map_offx, map_offy);
                mapCreator.on = true;
            } else {
                mapCreator.close();
                shotState.open();
            }
        }
    }

    void show() {
        if (!on) return;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                boxes[i][j].show();
            }
        }

        for (int i = 0; i < ships.length; i++) {
            if (!ships[i].positioned && i != pickedup_ship) ships[i].show();
        }
        if (pickedup_ship != -1) ships[pickedup_ship].show();
    }

    void clicked(int mx, int my) {
        if (!on) return;
        int mapx, mapy;
        if (mx < map_offx + n * dimX && mx > map_offx && my < map_offy + n * dimY && my > map_offy) { // cursore all'interno della mappa
            mapx = (mx - map_offx) / dimX;
            mapy = (my - map_offy) / dimY;
        } else {
            mapx = -1;
            mapy = -1;
        }

        if (mouseButton == RIGHT) {
            if (pickedup_ship != -1) {
                ships[pickedup_ship].turn();
            }
        } else if (mouseButton == LEFT) {
            for (int i = 0; i < ships.length; i++) { // scorro su tutte le barche
                if (ships[i].containsMouse(mx, my) && !ships[i].positioned) { // controllo che il mouse, quando è stato schiacciato, sia sopra una barca
                    if (pickedup_ship == -1) pickedup_ship = i; // se nessuna barca al momento è presa, allora la barca viene presa
                    else {
                        if (mapx != -1 && mapy != -1) { // controllo che sia all'interno della mappa
                            ships[pickedup_ship].positioned = true;
                            if ((ships[pickedup_ship].vertical && mapy + ships[pickedup_ship].len > n) 
                                ||(!ships[pickedup_ship].vertical && mapx + ships[pickedup_ship].len > n)) { // caso in cui le barche spogono dal bordo
                                reposition(pickedup_ship);
                            } else {
                                boolean proceed = true;
                                for (int j = 0; j < ships[pickedup_ship].len; j++) { // in base alla lunghezza e alla direzione della barca si controlla che possano essere occupati tot posti
                                    if (ships[pickedup_ship].vertical) { // controlla le caselle vicine per vedere se si puo posizionare la barca o no quando verticale
                                        if (boxes[mapx][mapy].used) proceed = false; // controlla la casella in cui dovrebbe posizionarsi la barca
                                        if (mapx > 0) { // se è staccato dal bordo sinistro, controllo tutte le caselle a sinistra
                                            if (boxes[mapx - 1][mapy + j].used) proceed = false;
                                        }
                                        if (mapx < n-1) { // se è staccato dal bordo destro controllo tutte le caselle a destra
                                            if (boxes[mapx + 1][mapy + j].used) proceed = false;
                                        }

                                        if (mapy > 0) { // controlla la casella in alto, se posso
                                            if (boxes[mapx][mapy - 1].used) proceed = false;
                                        }
                                        if (mapy + ships[pickedup_ship].len < n-1) { // controllo la casella sotto, se posso
                                            if (boxes[mapx][mapy + ships[pickedup_ship].len].used) proceed = false;
                                        }
                                    } else { // controlle le caselle vicine per vedere se si puo posizionare la barca o no quando orizzontale
                                        if (boxes[mapx + j][mapy].used) proceed = false;
                                        if (mapy > 0) { // se è staccato dal bordo sopra, controllo tutte le caselle sopra
                                            if (boxes[mapx + j][mapy - 1].used) proceed = false;
                                        }
                                        if (mapy < n-1) { // se è staccato dal bordo sotto, controllo tutte le caselle sotto
                                            if (boxes[mapx + j][mapy + 1].used) proceed = false;
                                        }

                                        if (mapx > 0) { // controllo la casella a sinistra, se posso
                                            if (boxes[mapx - 1][mapy].used) proceed = false;
                                        }
                                        if (mapx + ships[pickedup_ship].len < n-1) { // controllo la casella a destra, se posso
                                            if (boxes[mapx + ships[pickedup_ship].len][mapy].used) proceed = false;
                                        }
                                    }
                                }
                                if (!proceed) { // se non posso procedere allora riposiziono la barca
                                    reposition(pickedup_ship);
                                }
                                // in base alla lunghezza e alla direzione della barca vengono occupati tot posti sotto o a destra ( in base all'orientamento della barca
                                //il ciclo 'for' viene eseguito solo se la variabile 'proceed' è 'true'
                                for (int j = 0; proceed && j < ships[pickedup_ship].len; j++) {
                                    if (ships[pickedup_ship].vertical) {
                                        boxes[mapx][mapy + j].used = true;
                                    } else {
                                        boxes[mapx + j][mapy].used = true;
                                    }
                                }
                            }
                            pickedup_ship = -1; // la barca non è più quella
                        } else { // la barca è stata posizionata fuori dalla mappa, quindi viene riposizionata e non è più pickedup
                            reposition(i);
                            pickedup_ship = -1;
                        }
                    }
                }
            }
        }
    }

    private void createBoxes() {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                boxes[i][j] = new Box(i, j, map_offx, map_offy);
            }
        }
    }

    private void shipFollowCursor() {
        if (pickedup_ship != -1) {
            ships[pickedup_ship].setCenter(mouseX, mouseY);
        }
    }

    private void createShips() { 
        ships[0] = new Ship(20, dimY + 80, 3, false);
        ships[1] = new Ship(20, dimY * 2 + 120, 2, false);
    }

    private void reposition(int i) {
        ships[i] = new Ship(ships[i].startx, ships[i].starty, ships[i].len, ships[i].initial_vertical);
    }
    
    void open() {
        on = true;
    }
    
    void close() {
        on = false;
    }
}
