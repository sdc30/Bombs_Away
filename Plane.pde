class Plane {
  volatile int health, x_pos, y_pos, bombCount, arc, speed, imgW, imgH, id, count, dropX, dropY, delay;
  volatile boolean alive;
  Bomb b = new Bomb(25, 15, 2, 5, 10, 120);
  healthBar hb;

  public Plane(int x, int y, int bombs, int spd, int w, int h, int id_) {
    health = 100;
    x_pos = x;
    y_pos = y;
    bombCount = bombs;
    speed = spd;
    imgW = w;
    imgH = h;
    id = id_;
    count = 0;
    delay = 15;
    alive = true;
    hb = new healthBar(x, y+imgH+5, x+imgW, y+imgH+5, 1);
  }

  public void position(int x, int y) {
    x_pos = x;
    y_pos = y;
  }

  public int dropBomb(int x, int y) {

    y += y_pos + imgH/2;

    b.drawB(x, y);
    return y;
  }

  public void countReset() {
    count = 0;
    dropY = 0;
  }

  public void setDropX(int x) {

    dropX = x;
  }

  public void delayReset() {

    delay = (int)random(50, 500);
  }


  public boolean hit() {

    return true;
  }
}