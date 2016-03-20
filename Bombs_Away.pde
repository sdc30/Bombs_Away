ArrayList<Plane> planes = new ArrayList<Plane>(1);
ArrayList<Tank> tanks = new ArrayList<Tank>(2);
int timeLeft, difficulty;
boolean isPaused;
PImage t1, t2, p, bg;
Logic l;
volatile boolean mouseDown = false;

void setup() {
  t1 = loadImage("tank1.gif");
  t2 = loadImage("tank1.gif");
  p = loadImage("jet.gif");
  bg = loadImage("back.jpg");
  size(1000, 1000);
  l = new Logic(1000, 1000);
  for(int i = 0; i < 3; i++) {
    planes.add(new Plane(getRand1(), getRand1(), 3, rand()));
  }
  
  //for(Tank t: tanks) {
    
    
  //}
    
      tanks.add(new Tank(100, 750, 3, 3));
        tanks.get(0).setBounds(-50, 350);
      tanks.add(new Tank(750, 750, 3, 1));
        tanks.get(1).setBounds(550, 900);
  
}

void draw() {
  background(bg);
  imgUpdate();
  check();
}

void keyPressed(KeyEvent e) {
 
    if(key == CODED)
      switch(keyCode) {
       
        case UP: 
                 break;
        case DOWN: 
                   break;
        case LEFT: tanks.get(0).x_pos -= tanks.get(0).speed;
                   l.tankBounds(tanks.get(0), 0);
                   System.out.println("" + tanks.get(0).x_pos);
                   break;
        case RIGHT: tanks.get(0).x_pos += tanks.get(0).speed;
                    l.tankBounds(tanks.get(0), 1);
                    System.out.println("" + tanks.get(0).x_pos);
                    break;
      }
    
}

void imgUpdate() {
  image(t1, tanks.get(0).x_pos, tanks.get(0).y_pos);
  image(t2, tanks.get(1).x_pos, tanks.get(1).y_pos);
  for(Plane plane: planes)
    image(p, plane.x_pos = l.movement(plane.x_pos, plane.x_pos+plane.speed), plane.y_pos);
  
}

int getRand1(){
  // return random sizes
   return (int) random(0, 600); 
}

int rand() {
  
  return (int) random(1, 5);
}

void check() {
  
  if(mousePressed)
     switch(mouseButton)  {
     
      case LEFT: tanks.get(1).x_pos -= tanks.get(1).speed;
                   l.tankBounds(tanks.get(1), 0);
                   System.out.println("" + tanks.get(1).x_pos);
                   break;
      case RIGHT: tanks.get(1).x_pos += tanks.get(1).speed;
                    l.tankBounds(tanks.get(1), 1);
                    System.out.println("" + tanks.get(1).x_pos);
                    break;
      case CENTER: System.out.println("center");
                   break;
      
    } 
  
}