class ShotState {

    // "sinked" = colpito e affondato
    // "hit" = colpito
    // "water" =missato
    // "what are you doing?" = hai già sparato qua (non deve neanche succedere)
    // "sinked and defeated" = colpito e affondato e VINTO

    GLabel feedback;
    BattagliaNavale b;

    boolean on;
    boolean win;
    String data = ""; // feedback del colpo

    int map_offx, map_offy;
    Box[][] boxes = new Box[n][n];

    public ShotState(int map_offx, int map_offy, BattagliaNavale b) {
        this.map_offx = map_offx;
        this.map_offy = map_offy;
        createBoxes();
        on = false;
        win = false;
        this.b = b;
        G4P.setCtrlMode(GControlMode.CORNER);
        feedback = new GLabel(b, map_offx, map_offy + dimX * n, dimX * n, 50, "*nessun messaggio*");
        feedback.setFont(new Font("Arial", Font.PLAIN, 20));
        this.close();
    }

    void update() {
        if (!on) return;
    }

    void show() {
        if (!on) return;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                boxes[i][j].show();
            }
        }
        feedback.draw();
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
        if (mapx != -1 && mapy != -1 && boxes[mapx][mapy].state == -1) {
            json = setAction("fire&cell=" + char(65 + mapx) + "" + (mapy+1), notulol);
            if (json.getBoolean("error")) {
                if (json.getString("info") != null && json.getString("info").equals("Not your turn to play")) {
                    feedback.setText("Is not your turn!!");
                } else if (json.getString("info") != null && json.getString("info").equals("Action fire not allowd on state 5")) {
                    if (win) return;
                    else feedback.setText("Sadly, you apparently lost");
                }
            } else {
                shot.play();
            }
            if (json.getString("data") != null && json.getString("data").equals("water")) {
                boxes[mapx][mapy].state = 0;
            } else if (json.getString("data") != null && json.getString("data").equals("hit")) {
                boxes[mapx][mapy].hit();
            } else if (json.getString("data") != null && (json.getString("data").equals("sinked") || json.getString("data").equals("sinked and defeated"))) {
                boxes[mapx][mapy].hit();
                boxes[mapx][mapy].sink();
                for (int i = mapx + 1; i < n; i++) {
                    if (i < n && boxes[i][mapy].state == 1) {
                        boxes[i][mapy].sink();
                    } else break;
                }
                for (int i = mapx - 1; i >= 0; i--) {
                    if (i >= 0 && boxes[i][mapy].state == 1) {
                        boxes[i][mapy].sink();
                    } else break;
                }
                for (int i = mapy + 1; i < n; i++) {
                    if (i < n && boxes[mapx][i].state == 1) {
                        boxes[mapx][i].sink();
                    } else break;
                }
                for (int i = mapy - 1; i >= 0; i--) {
                    if (i >= 0 && boxes[mapx][i].state == 1) {
                        boxes[mapx][i].sink();
                    } else break;
                }
                if (json.getString("data") != null && json.getString("data").equals("sinked and defeated")) {
                    println("HAI VINTOOO");
                    win = true;
                    feedback.setText("YOU WON!");
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

    void open() {
        on = true;
        feedback.setEnabled(true);
        feedback.setVisible(true);
    }

    void close() {
        on = false;
        feedback.setEnabled(false);
        feedback.setVisible(false);
    }
}
