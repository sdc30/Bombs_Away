class Plane {
  int health, x_pos, y_pos, bombCount, arc, speed;
  
  
  public Plane(int x, int y, int bombs, int spd) {
    health = 100;
    x_pos = x;
    y_pos = y;
    bombCount = bombs;
    speed = spd;
    
  }
  
  public void position(int x, int y) {
    x_pos = x;
    y_pos = y;
  }
  

}