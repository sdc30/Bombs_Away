class Bomb {
  int x_pos, y_pos, damage, radius, range, fuseTime, time, endX, endY, speed, count;
  float  h_dis, v_dis;
  

  public Bomb(int dmg, int rd, int rg, int ft, int tm, int spd) {
    damage = dmg;
    radius = rd;
    range = rg;
    fuseTime = ft;

    time = tm;
    speed = spd;
  }
  
  public void position(int x, int y) {
    x_pos = x;
    y_pos = y;
    //drawB(x_pos, y_pos);
    //drawB();
  }
  
  public void end(int x, int y) {
    endX = x;
    endY = y;
  }
  
  public void drawB() {
    ellipseMode(CENTER);
    fill(0);
    
    //constrain(h_dis, 0, endX);
    //constrain(v_dis, 0, endY);
    
    ellipse(h_dis, v_dis, radius, radius);
    //ellipseMode(CENTER);
  }
  
}