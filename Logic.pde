static class Logic {
  public static int wd, ht;
  public static float gravity = 9.8;
  public static volatile boolean gameOver = false;

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
    //System.out.println(x + " " + x_next);
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
    
  
  public void displacement(Bomb b, float t, float angle) {
    float ax = 0, ay = gravity;
    
    float vxI =  b.speed * cos(angle);
    float vyI =  b.speed * sin(angle);
    
    //System.out.println("" + vxI  + " : " + vyI );
    

    float x = vxI * t + .5*ax*(t*t);
    float y = vyI * t + .5*ay*(t*t);
    
    
   //b.h_dis = constrain(x, 0, 1000);
   //b.v_dis = constrain(y, 0, 1000);
    
    
    b.h_dis = x;
    b.v_dis = y;
    //System.out.println("" + b.h_dis  + " : " +  b.v_dis);
    //return y;
  }
  
  public void collision(Plane p, Bomb bmb) {
    if(dist(p.x_pos, p.y_pos, bmb.h_dis, -bmb.v_dis) < bmb.radius) {
      //System.out.println("yes");
      //System.out.println("" + p.id + " : " + p.x_pos + " : " + p.y_pos + " : " + bmb.h_dis + " : " + bmb.v_dis);
      //System.out.println("" + dist(p.x_pos, p.y_pos, bmb.h_dis, bmb.v_dis));
     
    }
     //System.out.println("" + p.id + " : " + p.x_pos + " : " + p.y_pos + " : " + bmb.h_dis + " : " + bmb.v_dis);
     //System.out.println("" + dist(p.x_pos, p.y_pos, bmb.h_dis, bmb.v_dis));
    
  }
}