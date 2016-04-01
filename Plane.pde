/**********
 Cartwright, Stephen D
 Art 297A Stone
Bombs Away: Plane class - holds different information related to planes 


*********/

/*
Variables 
  - int x_pos, y_pos are x, y coordinates of the bomb at any given time
  - int bombCount: current count of plane's bombs
  - int speed: given speed of plane
  - int imgW, imgH: width, height of plane
  - int id: unique plane id # 
  - boolean alive: if the plane is not destroyed
  - Bomb currentBomb: current bomb associated with plane
  - healthBar hb: planes health bar  
*/


class Plane {
  volatile int health, x_pos, y_pos, bombCount, speed, imgW, imgH, id, count, dropX, dropY, delay;
  volatile boolean alive;
  Bomb currentBomb;
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
    currentBomb = new Bomb(25, 15, 2, 5, 10, 120);
      currentBomb.setID((int)random(1, 100000));
    hb = new healthBar(x, y+imgH+5, x+imgW, y+imgH+5, 1);
  }

  public void position(int x, int y) {
    // update plane position 
    x_pos = x;
    y_pos = y;
  }

  public int dropBomb(int x, int y, int id) {
    // drop the bomb at current positon
    // update position and draw with offset from plane
    // return the next y position
    setDropX(x);
    y += y_pos + imgH/2;
    currentBomb.position(x, y);
    currentBomb.setID(id);
    currentBomb.drawB(x, y);
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
    // new delay for dropping bomb
    delay = (int)random(50, 500);
  }


  public boolean hit() {
    
    return true;
  }
}