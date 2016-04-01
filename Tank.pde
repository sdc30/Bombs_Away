/**********
 Cartwright, Stephen D
 Art 297A Stone
Bombs Away: Tank class - holds different information related to tanks 


*********/

/*
Variables 
  - int x_pos, y_pos are x, y coordinates of the bomb at any given time
  - int bombCount: current count of tank's bombs
  - int speed: given speed of tank
  - int imgW, imgH: width, height of tank
  - int id: unique tank id # 
  - boolean alive: if the plane is not destroyed
  - Bomb currentBomb: current bomb associated with plane
  - healthBar hb: planes health bar  
*/



class Tank {
  int health, x_pos, y_pos, bombCount, arc, score, speed, bound_left, bound_right, line_x, line_y, 
    imgW, imgH, tankTime, count;
  gunLine gl;
  healthBar hb;
  ArrayList<Bomb> bl;
  ArrayList<Integer> hitBy;

  boolean fired = false, hit = false;
  Bomb currentBomb;

  public Tank(int x, int y, int bombs, int spd) {
    health = 100;

    bombCount = bombs;
    speed = spd;
    line_x = x_pos = x;
    line_y = y_pos = y;
    gl = new gunLine(0, 0, 0, 0);
    bl = new ArrayList<Bomb>(bombCount);
    tankTime = 0;
    hitBy = new ArrayList<Integer>(10);
    hitBy.add(-99);
    
    //System.out.format("%d", hitBy.size());
    hb = new healthBar(x, y+imgH+5, x+imgW, y+imgH+5, 1);
  }

  public void setBounds(int left, int right) {
    // boundary for the tank
    bound_left = left;
    bound_right = right;
  }

  public void setGunLine(int p1, int p2, int p3, int p4) {
    // set the gun laser init final points
    gl.setInitPoint(p1, p2);
    gl.setFinalPoint(p3, p4);
  }

  public void fire(int x, int y) {
    // remove bomb from list after firing
    if (bl.size()-1 > 0) {
      Bomb b = bl.get(bl.size()-1);
      try {
       bl.remove(bl.size()-1);
      } 
      catch(Exception e) {
      }
    }
  }


  public void timeReset() {
    // reset tank's time
    tankTime = 0;
  }

  public void countReset() {
    // reset loop counter for bomb list
    count = 0;
  }

  public void negateFire() {
    // negate fire when done drawing bomb
    fired = !fired;
  }

  public void scored() {
    // update score
    score += 1;
  }
  
  public void loadBombs(Bomb b) {
    // add new bombs
    bl.add(b);
  }
  
  public void isHit() {
   // negate if tank is hit
   hit = !hit; 
  }

}