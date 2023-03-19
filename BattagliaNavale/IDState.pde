class IDState {

    GTextField textContainer;
    GButton invio;
    GLabel instructions, feedback;

    boolean on;

    public IDState(int x, int y, BattagliaNavale b) {
        G4P.setCtrlMode(GControlMode.CORNER);
        instructions = new GLabel(b, x, y, 400, 50, "Inserisci l'ID della partita");
        instructions.setFont(new Font("Arial", Font.PLAIN, 20));
        feedback = new GLabel(b, x, y + 500, 400, 50, "");
        feedback.setFont(new Font("Arial", Font.PLAIN, 20));
        textContainer = new GTextField(b, x, y + 120, 300, 50);
        textContainer.setFont(new Font("Arial", Font.PLAIN, 20));
        invio = new GButton(b, x, y + 240, 200, 100, "INVIO");
        invio.setFont(new Font("Arial", Font.PLAIN, 20));
        invio.addEventHandler(b, "buttonPressedEvent");
        on = false;
    }

    void show() {
        if (!on) return;
        instructions.draw();
        feedback.draw();
        textContainer.draw();
        invio.draw();
    }

    /*void buttonPressed(GButton button, GEvent event) {
        if (invio == button && event == GEvent.CLICKED) {
            String text = textContainer.getText();
            boolean isok = true;
            if (text.length() == 7) {
                for (int i = 0; i < 7; i++) {
                    if (i == 3) {
                        if (!text.substring(i, i + 1).equals("-")) {
                            isok = false;
                            break;
                        }
                    } else {
                        try {
                            int a = Integer.parseInt(text.substring(i, i + 1));
                        }
                        catch(Exception e) {
                            isok = false;
                            break;
                        }
                    }
                }
            } else isok = false;
            if (isok) {
                gameID = text;
                json = setAction("delete", notulol);
                json = setAction("register", notulol);
                if (json.getBoolean("error")) {
                    feedback.setText(json.getString("info"));
                    gameID = "";
                } else {
                    idState.close();
                    mapCreator.open();
                }
            } else {
                gameID = "";
                feedback.setText("Invalid ID, reinsert please");
                textContainer.setText("");
            }
        }
    }*/
    
    void buttonPressed(GButton button, GEvent event) {
        if (invio == button && event == GEvent.CLICKED) {
            String text = textContainer.getText();
            String[] m=match(text,"[0-9]{3}-[0-9]{3}");
            if(m!=null){
                gameID = text;
                json = setAction("delete", notulol);
                json = setAction("register", notulol);
                if (json.getBoolean("error")) {
                    feedback.setText(json.getString("info"));
                    gameID = "";
                } else {
                    idState.close();
                    mapCreator.open();
                }
            } else {
                gameID = "";
                feedback.setText("Invalid ID, reinsert please");
                textContainer.setText("");
            }
        }
    }
    
    void open() {
        on = true;
        textContainer.setEnabled(true);
        invio.setEnabled(true);
        instructions.setEnabled(true);
        feedback.setEnabled(true);
        textContainer.setVisible(true);
        invio.setVisible(true);
        instructions.setVisible(true);
        feedback.setVisible(true);
    }
    
    void close() {
        on = false;
        textContainer.setEnabled(false);
        invio.setEnabled(false);
        instructions.setEnabled(false);
        feedback.setEnabled(false);
        textContainer.setVisible(false);
        invio.setVisible(false);
        instructions.setVisible(false);
        feedback.setVisible(false);
    }
}
