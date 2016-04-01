/**********
 Cartwright, Stephen D
 Art 297A Stone
Bombs Away: Bomb class - holds different information related to vehicle bombs 


*********/

/*
Variables 
  - int x_pos, y_pos are x, y coordinates of the bomb at any given time
  - int damage is bomb strength
  - int radius, diameter: radius of bomb explosion, diameter of explosion
  - int time: fuse time of bomb
  - int endX, endY: supposed to be ending positions of the bomb 
  - int count:
  - int id: unique bomb id
  - int bomb_XSZ, bmb_YSZ: list size of positions for the bomb's duration
  - ArrayList<Float> bmb_Y, ArrayList<Float> bmb_X: hold y, x positions of the bomb at each interval
  
*/

class Bomb {
  int x_pos, y_pos, damage, radius, range, fuseTime, time, endX, endY, speed, count, diameter, 
    bmb_XSZ, bmb_YSZ, id;
  
  ArrayList<Float> bmb_X, bmb_Y;

  public Bomb(int dmg, int rd, int rg, int ft, int tm, int spd) {
    damage = dmg;
    radius = rd;
    diameter = 2*radius;
    range = rg;
    //fuseTime = ft;

    time = tm;
    speed = spd;
    bmb_X = new ArrayList<Float>();
    bmb_Y = new ArrayList<Float>();
  }

  public void position(int x, int y) {
    // update bomb position
    x_pos = x;
    y_pos = y;

  }

  public void end(int x, int y) {
    // update ending point of bomb
    endX = x;
    endY = y;
  }

  public void drawB(float x, float y) {
    // draw the bomb with given x, y
    ellipseMode(CENTER);
    fill(0);

    ellipse(x, y, diameter, diameter);
  }

  public void addXY(float x, float y) {
    // create bomb positions for this bomb 
    bmb_X.add(x);
    bmb_Y.add(y);

    bmb_XSZ =  bmb_X.size();
    bmb_YSZ =  bmb_Y.size();
  }

  public void usedBomb(Tank t) {
    // remove a bomb from a tank
    t.bl.remove(t.bl.size()-1);
  }
  
  public void resetBombs(Tank t, int bombs) {
    // replenish bombs
    t.bombCount = bombs;
  }
  
  public void setID(int i) { 
    // set the bomb's id
    id = i;
  }
}