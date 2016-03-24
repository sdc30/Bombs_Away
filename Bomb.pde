class Bomb {
  int x_pos, y_pos, damage, radius, range, fuseTime, time, endX, endY, speed, count, 
    bmb_XSZ, bmb_YSZ;
  //float  h_dis, v_dis;
  ArrayList<Float> bmb_X = new ArrayList<Float>();
  ArrayList<Float> bmb_Y = new ArrayList<Float>();

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

  public void drawB(float x, float y) {
    ellipseMode(CENTER);
    fill(0);

    ellipse(x, y, radius, radius);
  }

  public void addXY(float x, float y) {

    bmb_X.add(x);
    bmb_Y.add(y);

    bmb_XSZ =  bmb_X.size();
    bmb_YSZ =  bmb_Y.size();
  }

  public void usedBomb(Tank t) {

    t.bl.remove(t.bl.size()-1);
  }
}