/**********
 Cartwright, Stephen D
 Art 297A Stone
Bombs Away: healthBar class - holds different information related to vehicle health bars


*********/

/*
Variables 
  - int p1..p4: starting x,y ending x,y 
  - int colour: current color at any time
  - color: colors for health bar
  - final int r, y, g: given values for the health bar of vehicle 
  green full, yellow medium, red low, black next to death
  
*/


class healthBar {

  public int p1, p2, p3, p4, colour;
  public color green, yellow, red;
  public final int r = 2, y = 3, g = 4;

  public healthBar(int x1, int y1, int x2, int y2, int c) {
    p1 = x1;
    p2 = y1;
    p3 = x2;
    p4 = y2;
    colour = c;
    green = color(0, 255, 0);
    yellow = color(255, 255, 0);
    red = color(255, 0, 0);
  }

  public void setInitPoint(int x, int y) {
    // update initali x, y
    p1 = x;
    p2 = y;
  }

  public void setFinalPoint(int x, int y) {
    // update final x, y
    p3 = x;
    p4 = y;
  }

  public void setPoints(int x1, int y1, int x2, int y2) {
    // update both x,y pairs together
    p1 = x1;
    p2 = y1;
    p3 = x2;
    p4 = y2;
  }

  public void drawHealthBar(int colour) {
    // draw the health bar at p1..p4 with correct color
    strokeWeight(2);
    colour = abs(colour);

    //System.out.println("colour " + colour);
    switch(colour) {

    case g: 
      stroke(green);
      break;
    case y: 
      stroke(yellow);
      break;
    case r: 
      stroke(red);
      break;
    default: 
      stroke(0);
      break;
    }
    //System.out.println("p1 " + p1 + " p2 " + p2);
    line(p1, p2, p3, p4);

    strokeWeight(0);
    stroke(0);
  }
}