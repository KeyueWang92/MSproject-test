import org.gicentre.geomap.*;
import java.util.*;
GeoMap geoMap = new GeoMap(650,20,500,350,this);

int TIME, line_TIME, pie_TIME, map_TIME;
String PARTY, STATE, STATE_MAP;
HashMap<String, Integer> time_to_int;
Parser p;
Map map;
Pie pie_chart;
Line_Chart lc;
Candidate can;
//Candidate can2;
boolean loop, selected_mode;
int count; //for the loop rate
int can_hover;

void setup(){
  frameRate(10);
  size(1200,800);
  TIME = 8;
  PARTY = "ALL_PARTY";
  STATE = "ALL_STATE";
  p = new Parser("./data.csv");
  map = new Map(geoMap);
  pie_chart = new Pie(p);
  lc = new Line_Chart(p);
  can = null;
  //can2 = null;
  loop = false;
  selected_mode = false;
  count = 0;
}

void draw(){
  fill(255);
  stroke(255);
  rect(0, 0, width, height);
  map.draw();
  pie_chart.draw();
  lc.draw();
  fill(230);
  noStroke();
  rect(620,720,80,30);
  fill(100);
  text("see the trend",620,730);
  if (loop == true) {
    PARTY = "ALL_PARTY";
    STATE = "ALL_STATE";
    STATE_MAP = "";
    can = null;
    selected_mode = false;
    lc.reset();
    if (count <= 80) {
      TIME = count/10;
      count++;
    } else {
      count = 0;
      loop = false;
    }
  }
  can_hover = lc.hover_button();
  can_hover = can_hover == -1 ? pie_chart.hover() : can_hover;
}


void mousePressed(){
  if(mouseButton == LEFT){
    can = pie_chart.clicked();
    //can2 = lc.clicked();
    selected_mode = lc.clicked();
    if (selected_mode) can = null;
    TIME = lc.click_time();
    if(can != null){
      PARTY = can.party;
      STATE = can.state;
      STATE_MAP = "";
    }
    //else if(can2 != null){
    //  PARTY = "ALL_PARTY"; 
    //  STATE = can2.state;
    //  STATE_MAP = "";
    //}
    else if (mouseX >= 620 && mouseX <= 700 && mouseY >= 720 && mouseY <= 750) {
      println("loop");
      loop = true;
      TIME = 0;
      line_TIME = 8;
      PARTY = "ALL_PARTY";
      STATE = "ALL_STATE";
      STATE_MAP = "";
      can = null;
      selected_mode = false;
      lc.reset();
    }
    //get the clicked candidate from pie chart
    else if (map.clicked() != null){
      STATE = map.clicked();
      STATE_MAP = map.clicked();
      PARTY = "ALL_PARTY";
    }else if(map.clicked() == null){
      if(can != null){
        STATE = can.state;
        PARTY = can.party;
      }else{
        STATE = "ALL_STATE";
        PARTY = "ALL_PARTY";
      }
      STATE_MAP = "";
    }
    println(STATE);
  }else if (mouseButton == RIGHT){
    //reset all
    PARTY = "ALL_PARTY";
    STATE = "ALL_STATE";
    STATE_MAP = "";
    can = null;
    //can2 = null;
    TIME = 8;
    loop = false;
    selected_mode = false;
    lc.reset();
  }
  
  int id = geoMap.getID(mouseX, mouseY);
  if (id != -1){
    if(map.statefunding.containsKey(id)){
      println("$"+map.statefunding.get(id)/1000000+"M");
      //STATE = Selected_state(id)
      //textAlign(CENTER,CENTER);
      //textSize(30);
      //fill(#ff2088);
      //text("$"+map.statefunding.get(id)/1000000+"M", 900,150);
    }
  }
}