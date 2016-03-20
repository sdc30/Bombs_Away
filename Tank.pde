class Tank {
  int health, x_pos, y_pos, bombCount, arc, score, speed, upBound, lowBound;
 
  
  public Tank(int x, int y, int bombs, int spd) {
    health = 100;

    bombCount = bombs;
    speed = spd;
    x_pos = x;
    y_pos = y;
  }
  
  public void setBounds(int l, int u) {
    lowBound = l;
    upBound = u;
    
    
  }

}