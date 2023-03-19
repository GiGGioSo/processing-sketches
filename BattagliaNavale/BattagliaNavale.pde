import g4p_controls.*;
import java.awt.Font;
import processing.sound.*;

static final int fps = 30;

//SUONI
SoundFile shot, hit, water;

//IMMAGINI
PImage explotion;

//INFORMAZIONI SERVER
String baseURL = "https://www.liceocopernico.edu.it/oldcop/navalbattle/index.php";
String gameID = "";
String otherIP = "10.0.0.0"; // ip del giocatore fantoccio
JSONObject json;
boolean notulol = false;

int n = 8; // numero caselle per lato
int dimX = 50;
int dimY = 50;

CreateMapState mapCreator;
ShotState shotState;
IDState idState;

void setup() {
    frameRate(fps);
    size(1000, 800);
    background(150);
    shot = new SoundFile(this, "shot.mp3");
    hit = new SoundFile(this, "hit.mp3");
    explotion = loadImage("explotion.png");
    mapCreator = new CreateMapState(400, 50);
    shotState = new ShotState(300, 100, this);
    idState = new IDState(100, 100, this);
    idState.open();
}

void draw() {
    background(150);
    mapCreator.update();
    mapCreator.show();
    shotState.update();
    shotState.show();
    idState.show();
}

void mouseClicked() {
    mapCreator.clicked(mouseX, mouseY);
    shotState.clicked(mouseX, mouseY);
}

JSONObject setAction(String action, boolean impersonate) {
    String url = baseURL+"?id="+gameID;
    String player;
    if (impersonate) {
        url += "&player="+otherIP;
        player = "2 (slave)";
    } else player = "1 (master)";
    url += "&action="+action; 
    JSONObject j = loadJSONObject(url);
    println("Action performed by player " + player + ": " + action);
    if (j.getBoolean("error")) println("| ERROR : " + j.getBoolean("error"));
    println("| INFO : " + j.getString("info"));
    println("| DATA : " + j.getString("data"));
    //DEBUG per il prof
    /*String maps = j.getString("maps");
    if ( maps != null) {
        JSONArray mapsa = parseJSONArray(maps);
        for (int k=0; k<2; k++) {
            JSONArray map = mapsa.getJSONArray(k);
            println("Mappa giocatore "+(k+1)+":");
            for (int r = 0; r < map.size(); r++) {
                JSONArray row = map.getJSONArray(r);
                int[] rowp = row.getIntArray();
                for (int c = 0; c < map.size(); c++) {
                    int s = rowp[c];
                    print(s);
                }
                println();
            }
        }
    }
    */
    return j;
}

void buttonPressedEvent(GButton button, GEvent event) {
    idState.buttonPressed(button, event);
}
