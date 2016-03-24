ArrayList<Plane> planes = new ArrayList<Plane>(1); 
Tank tank1, tank2;

boolean isPaused;
PImage t1, t2, p, bg;
Logic l;
boolean p1Line = false, p2Line = false;
Bomb b;
void setup() {
  t1 = loadImage("tank1.gif");
  t2 = loadImage("tank2.gif");
  p = loadImage("jet1.gif");
  bg = loadImage("back.jpg");
  size(1000, 1000);
  l = new Logic(1000, 1000);
  for (int i = 0; i < 3; i++) {
    planes.add(new Plane(getRand1(), getRand1(), 3, rand(), t1.width/2, t1.height/2, i));

  }

  tank1 = new Tank(100, 750, 3, 3);
  tank1.setBounds(-50, 350);
  tank1.imgW = t1.width/2;
  tank1.imgH = t1.height/2;

  tank2 = new Tank(750, 750, 3, 1);
  tank2.setBounds(550, 900);
  tank2.imgW = t2.width/2;
  tank2.imgH = t2.height/2;

  for (int i = 0; i < 10; i++) {
    tank1.bl.add(new Bomb(10, 25, 2, 5, 10, 120));
  } 

  for (int i = 0; i < 10; i++) {
    tank2.bl.add(new Bomb(10, 25, 2, 5, 10, 120));
  }
}

void draw() {


  background(bg);
  imgUpdate();
  check();
  
}

void keyPressed(KeyEvent e) {

  if (key == CODED) 
    switch(keyCode) {

    case UP: 

      break;
    case DOWN: 
      Bomb bmb = tank1.bl.get(tank1.bl.size()-1);
      
      float angle1 = atan2(tank1.gl.p4 - tank1.gl.p2 , tank1.gl.p3 - tank1.gl.p1);
      // System.out.println("" + tank1.gl.p1 + " : " + tank1.gl.p2 + " : " + tank1.gl.p3 + " : " + tank1.gl.p4 );
      float t = 0;
      
      
      do {
         pushMatrix();
         translate(tank1.x_pos+tank1.imgW, tank1.y_pos+tank1.imgH);
         l.displacement(bmb, t+=.25, angle1);
         bmb.drawB();
         popMatrix();
        //System.out.println("" + xd);
        
        checkTwo(bmb);
       
        
      }  while (t < bmb.time);
     
      //checkTwo();
      break;
    case LEFT: 
      tank1.x_pos -= tank1.speed;
      l.tankBounds(tank1, 0);
      //System.out.println("" + tanks.get(0).x_pos);
      break;
    case RIGHT: 
      tank1.x_pos += tank1.speed;
      l.tankBounds(tank1, 1); 
      //System.out.println("" + tanks.get(0).x_pos);
      break;
    } else if (key == 'w') {
    tank1.setGunLine(tank1.x_pos + tank1.imgW, 
      tank1.y_pos + tank1.imgH, 
      tank1.line_x, 
      tank1.line_y = tank1.line_y-=50);
  } else if (key == 's') {
    tank1.setGunLine(tank1.x_pos + tank1.imgW, 
      tank1.y_pos + tank1.imgH, 
      tank1.line_x, 
      tank1.line_y = tank1.line_y+=50);
    //tanks.get(0).gl.drawL();
  } else if (key == 'a') {
    tank1.setGunLine(tank1.x_pos + tank1.imgW, 
      tank1.y_pos + tank1.imgH, 
      (tank1.line_x = tank1.line_x-=50), 
      tank1.line_y);
    //tanks.get(0).gl.drawL();
  } else if (key == 'd') {
    tank1.setGunLine(tank1.x_pos + tank1.imgW, 
      tank1.y_pos + tank1.imgH, 
      (tank1.line_x = tank1.line_x+=50), 
      tank1.line_y);
    //tanks.get(0).gl.drawL();
  } else if (key == '1') {
    p1Line = !p1Line;
  } //else if (key == '2') {
  //  p2Line = !p2Line;
  //}
}

void imgUpdate() {
  image(t1, tank1.x_pos, tank1.y_pos);
  image(t2, tank2.x_pos, tank2.y_pos);
  if (p1Line)
    tank1.gl.drawL();
  if (p2Line)
    tank2.gl.drawL();
  for (Plane plane : planes) { 
    image(p, plane.x_pos = l.movement(plane.x_pos, plane.x_pos+plane.speed), plane.y_pos);
  }
}

int getRand1() {
  // return random sizes
  return (int) random(0, 600);
}

int rand() {

  return (int) random(1, 5);
}

void check() {

  if (mousePressed) {
    tank2.setGunLine(tank2.x_pos + tank2.imgW, 
      tank2.y_pos + tank2.imgH, 
      (tank2.line_x = mouseX), 
      (tank2.line_y = mouseY));
    switch(mouseButton) {

    case LEFT: 
      tank2.x_pos -= tank2.speed;
      l.tankBounds(tank2, 0);
      break;
    case RIGHT: 
      tank2.x_pos += tank2.speed;
      l.tankBounds(tank2, 1);
      break;
    case CENTER: 
      p2Line = !p2Line;
       Bomb b = tank1.bl.get(tank2.bl.size()-1);
      
      float angle1 = atan2(tank2.gl.p4 - tank2.gl.p2 , tank2.gl.p3 - tank2.gl.p1);
      // System.out.println("" + tank1.gl.p1 + " : " + tank1.gl.p2 + " : " + tank1.gl.p3 + " : " + tank1.gl.p4 );
      float t = 0;
      pushMatrix();
      translate(tank2.x_pos+tank2.imgW, tank2.y_pos+tank2.imgH);
      
      do {
        l.displacement(b, t+=.25, angle1);
        //System.out.println("" + xd);
        
        
        b.drawB();
        
      }  while (t < 2*b.time);
      popMatrix();

      break;
    }
  }
}

void checkTwo(Bomb bomb) {
 
  //for(int i = 0; i < tank1.bl.size(); i++) {
    //Bomb b = tank1.bl.get(i);
    for (Plane plane : planes) { 
      l.collision(plane, bomb);
      
    }
  //}
  
  //for(int i = 0; i < tank2.bl.size(); i++) {
    //Bomb b = tank2.bl.get(i);
    //for (Plane plane : planes) { 
      //l.collision(plane, b);
    //}
  //}
  
}

void mouseWheel(MouseEvent e) {

  float count = e.getCount();

  if (count < 0) {
  } else if (count > 0) {
  }
}