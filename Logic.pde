static class Logic {
    public static int wd, ht;
    public static float gravity = -9.8;
    
    public Logic(int w, int h) {
      wd = w;
      ht = h;
    }
    
    public int movement(int x, int x_next) {
      
      if(x >= x_next) { // left
        if(x <= 0) {
          x_next = wd;
        }
      }
      else if(x <= x_next) {// right
        if(x >= wd) {
          x_next = 0; 
        }
      }
      else{}
          //System.out.println(x + " " + x_next);
      return x_next;
    }


    public void tankBounds(Tank t, int i) {
        
        if(i == 1) { 
          if(t.x_pos >= t.upBound)
            t.x_pos = t.upBound;
        }
        else{ 
          if(t.x_pos <= t.lowBound)
            t.x_pos = t.lowBound;
        }
        
        
        
    }
}