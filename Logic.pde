static class Logic {
  public static int wd, ht;
  public static float gravity = 9.8;
  public static volatile boolean gameOver = false;
  boolean isPaused = true;
  boolean p1Line = false, p2Line = false;

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
    
  
  public void displacement(Bomb b, float t, float angle) {
    float ax = 0, ay = gravity;
    
    float vxI =  b.speed * cos(angle);
    float vyI =  b.speed * sin(angle);


    float x = vxI * t + .5*ax*(t*t);
    float y = vyI * t + .5*ay*(t*t);

    
    b.addXY(x, y);

  }
  
  public int collision(Plane p, Bomb b, int i) {
    //System.out.println("" + p.x_pos + " : " + p.y_pos + " : " + b.bmb_X.get(i)+ " : " + -b.bmb_Y.get(i) );
    //System.out.println("" + dist(p.x_pos, p.y_pos, b.bmb_X.get(i), -b.bmb_Y.get(i)) );
   int j = 0;
   
   float circX = abs(b.bmb_X.get(i) - p.x_pos - p.imgW/2);
   float circY = abs(b.bmb_Y.get(i) - p.y_pos - p.imgH/2);
    
   if( circX > (p.imgW/2 + b.radius) || circY > (p.imgH/2 + b.radius)) j = 0;
   else if (circX <= p.imgW/2 || circY <= p.imgH/2) j = 1;
   
   float corner = dist(circX, circY, p.imgW/2, p.imgH/2);
   
    /*
    if(b.bmb_X.get(i) >= p.x_pos && b.bmb_X.get(i) <= (p.x_pos + p.imgW)) {
      if(-b.bmb_Y.get(i) >= p.y_pos && -b.bmb_Y.get(i) <= (p.y_pos + p.imgH)) {
          //System.out.println("" + dist(b.bmb_X.get(i), -b.bmb_Y.get(i), p.x_pos, p.y_pos));
        j = 1;
      }
    }*/
    
    if(corner <= b.radius*b.radius) j = 1;
    
    return j;
  }
  
  
  public void planeDrop(Plane p) {
    
    
  
  }
  
   


}