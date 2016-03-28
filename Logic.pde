static class Logic {
  public static int wd, ht;
  public static float gravity = 9.8;
  public static volatile boolean gameOver = false;
  boolean isPaused = true;
  boolean p1Line = true, p2Line = true;

  public Logic(int w, int h) {
    wd = w;
    ht = h;
  }

  public int movement(int x, int x_next) {

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

    if (i == 1) { 
      if (t.x_pos >= t.bound_right)
        t.x_pos = t.bound_right;
    } else { 
      if (t.x_pos <= t.bound_left)
        t.x_pos = t.bound_left;
    }
  }


  public void displacement(Tank tank, Bomb b, float t, float angle) {
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
    //System.out.println("collision p id " + p.id);
    boolean hit = false;

    //if (p.id == 1) {

    //  System.out.println("\n bmb (x,y) " + b.bmb_X.get(i) + " : " + b.bmb_Y.get(i) );
    //  System.out.println("\n dist " + dist(p.x_pos, p.y_pos, b.bmb_X.get(i), b.bmb_Y.get(i)) );
    //  System.out.println("\n (x, x+w, y, y+h) " + p.x_pos + " : " + (p.x_pos + p.imgW) + " : " + p.y_pos + " : " + (p.y_pos + p.imgH) );
    //}

    if (b.bmb_X.get(i) >= p.x_pos && b.bmb_X.get(i) <= (p.x_pos + p.imgW)) {
      if (b.bmb_Y.get(i) >= p.y_pos && b.bmb_Y.get(i) <= (p.y_pos + p.imgH)) {

        
        hit = true;
      }
    }

    return hit;
  }


  //public boolean collision(Tank t, Bomb b) {
  //  System.out.println("collision p id " + p.id);
  //  boolean hit = false;


  //  if (b.bmb_X.get(i) >= p.x_pos && b.bmb_X.get(i) <= (p.x_pos + p.imgW)) {
  //    if (b.bmb_Y.get(i) >= p.y_pos && b.bmb_Y.get(i) <= (p.y_pos + p.imgH)) {


  //      hit = true;
  //    }
  //  }

  //  return hit;
  //}


  public void planeDropBomb(Plane p) {
  }


  //void tankHit(Plane p, Tank t) {

  //  if(collision(p, 

  //}


  boolean planeHit(Plane p, Tank t) {
    //System.out.println("planeHit");
    boolean hit = false;
    //System.out.println("planeHit tank count " + t.count);
    for (int i = 0; i < t.count; i++) { 
      //System.out.println("planeHit Loop at " + i);
      if (collision(p, t.currentBomb, i) && !hit) {
        p.health -= t.currentBomb.damage;
        if (p.health <= 0) { 
           t.hit(); 
           p.alive = false;
        }
        hit = true;
      }
    }
    return hit;
  }
}