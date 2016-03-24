class gunLine {
  public int p1, p2, p3, p4;

  public gunLine(int x1, int y1, int x2, int y2) {
    p1 = x1;
    p2 = y1;
    p3 = x2;
    p4 = y2;
  }

  public void setInitPoint(int x, int y) {
    p1 = x;
    p2 = y;
  }

  public void setFinalPoint(int x, int y) {
    p3 = x;
    p4 = y;
  }
  
  public void drawL() {
    strokeWeight(2);
    stroke(255, 0, 0);
    //System.out.println("" + p1 + ":" + p2 + ":" + p3 + ":" + p4);
    p1 = constrain(p1, 0, 1000);
    p2 = constrain(p2, 0, 1000);
    p3 = constrain(p3, 0, 1000);
    p4 = constrain(p4, 0, 1000);

    line(p1, p2, p3, p4);
  }
}