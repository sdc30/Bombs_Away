/**********
 Cartwright, Stephen D
 Art 297A Stone
 Bombs Away: Logic class - holds different information related to game logic 
 
 
 *********/

/*
Variables 
 - int wd, ht: screen width, height
 - float gravity: acceleration of object due to gravity 
 - volatile boolean gameOver: changes when game is over
 - boolean p1Line, p2Line toggle gun lasers
 */

static class Logic {
  public static int wd, ht;
  public static float gravity;
  public static volatile boolean gameOver;
  boolean isPaused;
  boolean p1Line, p2Line;

  public Logic(int w, int h) {
    wd = w;
    ht = h;
    gravity = 9.8;
    gameOver = false;
    isPaused = true;
    p1Line = true;
    p2Line = true;
  }



  public int movement(int x, int x_next) {
    // we check the direction and movement of 
    // the object (left or right) 

    // if it's going to the left make sure it loops around on the opposite side of screen
    // likewise with the right direction back to the left
    if (x >= x_next) { // left
      if (x <= 0) {
        x_next = wd;
      }
    } else if (x <= x_next) {// right
      if (x >= wd) {
        x_next = 0;
      }
    } else {
    }

    return x_next;
  }


  public void tankBounds(Tank t, int i) {
    // make sure we cant move outside our bounds
    // int i made for easy toggle check left or right
    if (i == 1) { 
      if (t.x_pos >= t.bound_right)
        t.x_pos = t.bound_right;
    } else { 
      if (t.x_pos <= t.bound_left)
        t.x_pos = t.bound_left;
    }
  }


  public void displacement(Tank tank, Bomb b, float t, float angle) {
    // calculates, using kinematics equations, the positions of
    // the bomb at given time while adding to the list containing
    // positions to be iterated over
    // make the '(0, 0)' position the tank's cannon 
    float ax = 0, ay = gravity;

    float x0 = tank.x_pos + tank.imgW/2;
    float y0 = tank.y_pos + tank.imgH/2;

    float vxI = b.speed * cos(angle);
    float vyI = b.speed * sin(angle);


    float x = vxI * t + .5*ax*(t*t);
    float y = vyI * t + .5*ay*(t*t);


    b.addXY(x+x0, y+y0);
  }



  public boolean collision(Plane p, Bomb b, int i) {
    // check to see if there is a collision between a plane and bomb
    // using box based detection
    boolean hit = false;
    int w = p.x_pos + p.imgW;
    int h = p.y_pos + p.imgH;
    //if (p.id == 1) {

    //  System.out.println("\n bmb (x,y) " + b.bmb_X.get(i) + " : " + b.bmb_Y.get(i) );
    //  System.out.println("\n dist " + dist(p.x_pos, p.y_pos, b.bmb_X.get(i), b.bmb_Y.get(i)) );
    //  System.out.println("\n (x, x+w, y, y+h) " + p.x_pos + " : " + (p.x_pos + p.imgW) + " : " + p.y_pos + " : " + (p.y_pos + p.imgH) );
    //}

    if (b.bmb_X.get(i) >= p.x_pos && b.bmb_X.get(i) <= w) {
      if (b.bmb_Y.get(i) >= p.y_pos && b.bmb_Y.get(i) <= h) {

        hit = true;
      }
    }

    return hit;
  }


  public boolean collision(int x, int y, Tank t) {
    // check to see if there is a collision between a tank and a bomb
    // using box based detection 

    boolean hit = false;

    int w = t.x_pos + t.imgW;
    int h = t.y_pos + t.imgH;

    if (x >= t.x_pos && x <= w) {
      if (y >= t.y_pos && y <= h) {
        //System.out.format("\nx: %d, y: %d, tankx: %d, tanky: %d, tankxw: %d, tankyh: %d\n", x, y, t.x_pos, t.y_pos, w, h);
        hit = true;
      }
    }

    return hit;
  }


  boolean tankHit(Bomb b, Tank t) {
    // check to see if given tank has been hit 
    // update its health 
    boolean hit = false;

    if (collision(b.x_pos, b.y_pos, t)) {

      for (int i = 0; i < t.hitBy.size(); i++) {
        System.out.format("previous hit: t.hitBy %d, bomb id: %d\n", t.hitBy.get(i), b.id);
        if (t.hitBy.get(i) == b.id) {
          hit = true;
        }
      }


      if (!hit) {
        t.hitBy.add(b.id);
        t.health -= b.damage;
      }
    }
    return hit;
  }

  boolean planeHit(Plane p, Tank t) {
    // check to see if a plane has been hit 
    // update its health 

    boolean hit = false;
    for (int i = 0; i < t.count; i++) { 
      if (collision(p, t.currentBomb, i) && !hit) {
        p.health -= t.currentBomb.damage;
        if (p.health <= 0) { 
          t.scored(); 
          p.alive = false;
        }
        hit = true;
      }
    }
    return hit;
  }
}