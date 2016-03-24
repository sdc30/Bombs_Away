class Plane {
  int health, x_pos, y_pos, bombCount, arc, speed, imgW, imgH, id;
  

  public Plane(int x, int y, int bombs, int spd, int w, int h, int id_) {
    health = 100;
    x_pos = x;
    y_pos = y;
    bombCount = bombs;
    speed = spd;
    imgW = w;
    imgH = h;
    id = id_;
  }

  public void position(int x, int y) {
    x_pos = x;
    y_pos = y;
  }
}