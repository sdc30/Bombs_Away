class Tank {
  int health, x_pos, y_pos, bombCount, arc, score, speed, bound_left, bound_right, line_x, line_y, 
    imgW, imgH, tankTime, count;
  gunLine gl;
  healthBar hb;
  ArrayList<Bomb> bl;

  boolean fired = false;
  Bomb currentBomb;

  public Tank(int x, int y, int bombs, int spd) {
    health = 100;

    bombCount = bombs;
    speed = spd;
    line_x = x_pos = x;
    line_y = y_pos = y;
    gl = new gunLine(0, 0, 0, 0);
    bl = new ArrayList<Bomb>();
    tankTime = 0;

    hb = new healthBar(x, y+imgH+5, x+imgW, y+imgH+5, 1);
  }

  public void setBounds(int left, int right) {
    bound_left = left;
    bound_right = right;
  }

  public void setGunLine(int p1, int p2, int p3, int p4) {
    gl.setInitPoint(p1, p2);
    gl.setFinalPoint(p3, p4);
  }

  public void fire(int x, int y) {
    if (bl.size()-1 > 0) {
      Bomb b = bl.get(bl.size()-1);
    }
  }


  public void timeReset() {

    tankTime = 0;
  }

  public void countReset() {
    count = 0;
  }

  public void negateFire() {

    fired = !fired;
  }

  public void hit() {

    score += 1;
  }
}