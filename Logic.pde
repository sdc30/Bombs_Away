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
    
/*  
  public void displacement(Bomb b, float t, float angle) {
    float ax = 0, ay = gravity;
    
    float vxI =  b.speed * cos(angle);
    float vyI =  b.speed * sin(angle);


    float x = vxI * t + .5*ax*(t*t);
    float y = vyI * t + .5*ay*(t*t);

    
    b.addXY(x, y);

  }
 */ 
   public void displacement2(Tank tank, Bomb b, float t, float angle) {
    float ax = 0, ay = gravity;
    
    float x0 = tank.x_pos + tank.imgW/2;
    float y0 = tank.y_pos + tank.imgH/2;
    
    float vxI = b.speed * cos(angle);
    float vyI = b.speed * sin(angle);


    float x = vxI * t + .5*ax*(t*t);
    float y = vyI * t + .5*ay*(t*t);

    
    b.addXY(x+x0, y+y0);

   }
/*  
  public boolean collision(Plane p, Bomb b, Tank t, int i) {
    float x = t.x_pos + t.imgW/2;
    float y = t.y_pos + t.imgH/2;
    
    if(p.id == 1) {
     
     System.out.println("\n bmb (x,y) " + b.bmb_X.get(i)+x + " : " + -b.bmb_Y.get(i)+y );
     System.out.println("\n dist " + dist(p.x_pos, p.y_pos, b.bmb_X.get(i)+x, -b.bmb_Y.get(i)+y) );
     System.out.println("\n (x, x+w, y, y+h) " + p.x_pos + " : " + (p.x_pos + p.imgW) + " : " + p.y_pos + " : " + (p.y_pos + p.imgH) );

    }
   boolean hit = false;
  
   //float circX = abs(b.bmb_X.get(i) - p.x_pos - p.imgW/2);
   //float circY = abs(b.bmb_Y.get(i) - p.y_pos - p.imgH/2);
    
   //if( circX > (p.imgW/2 + b.radius) || circY > (p.imgH/2 + b.radius)) j = 0;
   //else if (circX <= p.imgW/2 || circY <= p.imgH/2) j = 1;
   
   //float corner = dist(circX, circY, p.imgW/2, p.imgH/2);
   
    
    if(b.bmb_X.get(i)+x >= p.x_pos && b.bmb_X.get(i)+x <= (p.x_pos + p.imgW)) {
      if(-b.bmb_Y.get(i)+y >= p.y_pos && -b.bmb_Y.get(i)+y <= (p.y_pos + p.imgH)) {
          //System.out.println("" + dist(b.bmb_X.get(i), -b.bmb_Y.get(i), p.x_pos, p.y_pos));
        hit = true;
        System.out.println("hit");
      }
    }
    
    //if(corner <= b.radius*b.radius) j = 1;
    
    return hit;
  }
  
  */
  
  
   public boolean collision2(Plane p, Bomb b, int i) {
     
     boolean hit = false;
        
            if(p.id == 1) {
     
               System.out.println("\n bmb (x,y) " + b.bmb_X.get(i) + " : " + b.bmb_Y.get(i) );
               System.out.println("\n dist " + dist(p.x_pos, p.y_pos, b.bmb_X.get(i), b.bmb_Y.get(i)) );
               System.out.println("\n (x, x+w, y, y+h) " + p.x_pos + " : " + (p.x_pos + p.imgW) + " : " + p.y_pos + " : " + (p.y_pos + p.imgH) );

            }
    
    if(b.bmb_X.get(i) >= p.x_pos && b.bmb_X.get(i) <= (p.x_pos + p.imgW)) {
      if(b.bmb_Y.get(i) >= p.y_pos && b.bmb_Y.get(i) <= (p.y_pos + p.imgH)) {
          
        hit = true;
        System.out.println("hit");
      }
    }
    
    return hit;
     
   }
  
  
  public void planeDrop(Plane p) {
    
    
  
  }
  
   


}