class Parser{
  private String[] lines;
  public String[] headers;
  public Candidate[] candidates;
  public int[][] colors = {{255,204,204},{255,179,179},{255,166,166},{255,153,153},{255,128,128},{255,102,102},
                          {255,90,90},{255,77,77},{255,51,51},{255,64,64},
                          {255,26,26},{255,13,13},{255,0,0},{243,0,0},{230,0,0},{217,0,0},{204,0,0},
                          {204, 217, 255},{179, 198, 255},{153, 179, 255},{128, 159, 255},{102, 140, 255},
                          {173,235,173},{133,224,133},{92,214,92}};
  Parser(String filename) {
    lines = loadStrings(filename);
    candidates = new Candidate[lines.length-1];
    headers = split(lines[0], ",");
    for(int i = 1; i < lines.length; i++){
      String[] data = split(lines[i], ",");
      String lastname = data[0].substring(1);
      String firstname = data[1].substring(0,data[1].length()-1);
      String state = data[2];
      String party = data[3];
      //skip party2
      float[] funding = new float[9];
      funding[0] = float(data[5]);
      funding[1] = float(data[6]);
      funding[2] = float(data[7]);
      funding[3] = float(data[8]);
      funding[4] = float(data[9]);
      funding[5] = float(data[10]);
      funding[6] = float(data[11]);
      funding[7] = float(data[12]);
      funding[8] = float(data[13]);
      candidates[i-1] = new Candidate(lastname, lastname+firstname, state, party, funding);
    }
  }
  
  float[][] get_fundings(){
    float[][] fundings = new float[this.candidates.length][9];
    for (int i = 0; i < fundings.length; i++){
      for (int j = 0; j < 9; j++){
        fundings[i][j] = this.candidates[i].funding[j];
      }
    }
    return fundings;
  }
  
  String[] get_months(){
    String[] months = new String[9];
    for (int i = 0; i < 9; i++){
      months[i] = this.headers[i+4];
    }
    return months;
  }
}

class Candidate{
  private String name;
  private String lastname;
  private String state;
  private String party;
  private float[] funding;
  boolean selected;
  Candidate(String lastname, String name, String state, String party, float[] funding){
    this.lastname = lastname;
    this.name = name;
    this.state = state;
    this.party = party;
    this.funding = funding;
    this.selected = false;
  }
  public String getName(){
    return this.name;
  }
  public String getState(){
    return this.state;
  }
  public String getParty(){
    return this.party;
  }
  public float[] getFunding(){
    return this.funding;
  }
}