import java.util.Timer;
import java.util.TimerTask;

ArrayList<Plane> planes = new ArrayList<Plane>(1); 
Tank tank1, tank2;

Timer timer = new Timer();
static int interval = 100, delay = 1000, period = 1000;


PImage t1, t2, p, bg;
Logic l;

Bomb b;
Bomb bmb;
int tankCounter = 0;
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
    tank1.bl.add(new Bomb(25, 25, 2, 5, 10, 120));
  } 

  for (int i = 0; i < 10; i++) {
    tank2.bl.add(new Bomb(25, 25, 2, 5, 10, 120));
  }

  timer.scheduleAtFixedRate(new TimerTask() {
    public void run() {
      if (interval == 1) timer.cancel();
      else --interval;
      //System.out.println("" + interval);
    }
  }
  , delay, period);
}

void draw() {


  background(bg);
  imgUpdate();
  //check();
  if (tank1.fired) {
    pushMatrix();
    translate(tank1.x_pos+tank1.imgW, tank1.y_pos+tank1.imgH);
    if (tank1.tankTime <= tank1.currentBomb.time && tankCounter < tank1.currentBomb.bmb_X.size()) {

      tank1.currentBomb.drawB(tank1.currentBomb.bmb_X.get(tankCounter), tank1.currentBomb.bmb_Y.get(tankCounter));
      tankCounter++;
    } else {
      tankCounter = 0;
      tank1.timeReset(); 
      tank1.negateFire();
    }
    popMatrix();
  } else if (tank2.fired) {
  }
}

void keyPressed(KeyEvent e) {

  if (key == CODED) 
    switch(keyCode) {

    case UP: 

      break;
    case DOWN: 
      if (tank1.bl.size() > 0) { 
        bmb = tank1.bl.get(tank1.bl.size()-1);
        bmb.usedBomb(tank1);


        float angle1 = atan2(tank1.gl.p4 - tank1.gl.p2, tank1.gl.p3 - tank1.gl.p1);
        // System.out.println("" + tank1.gl.p1 + " : " + tank1.gl.p2 + " : " + tank1.gl.p3 + " : " + tank1.gl.p4 );
        float t = 0;


        do {

          l.displacement(bmb, t, angle1);
          t +=.25;
          tank1.count++;
        } while (t < bmb.time);

        tank1.currentBomb = bmb;
        tank1.negateFire();
        planeHit(tank1);
        
      }
      break;
    case LEFT: 
      tank1.x_pos -= tank1.speed;
      l.tankBounds(tank1, 0);

      break;
    case RIGHT: 
      tank1.x_pos += tank1.speed;
      l.tankBounds(tank1, 1); 
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
  } else if (key == 'a') {
    tank1.setGunLine(tank1.x_pos + tank1.imgW, 
      tank1.y_pos + tank1.imgH, 
      (tank1.line_x = tank1.line_x-=50), 
      tank1.line_y);
  } else if (key == 'd') {
    tank1.setGunLine(tank1.x_pos + tank1.imgW, 
      tank1.y_pos + tank1.imgH, 
      (tank1.line_x = tank1.line_x+=50), 
      tank1.line_y);
  } else if (key == '1') {
    l.p1Line = !l.p1Line;
  } //else if (key == '2') {
  //  p2Line = !p2Line;
  //}
}

void imgUpdate() {
  image(t1, tank1.x_pos, tank1.y_pos);
  image(t2, tank2.x_pos, tank2.y_pos);
  if (l.p1Line)
    tank1.gl.drawL();
  if (l.p2Line)
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

void mouseAction() {

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
      l.p2Line = !l.p2Line;
      Bomb b = tank1.bl.get(tank2.bl.size()-1);

      float angle1 = atan2(tank2.gl.p4 - tank2.gl.p2, tank2.gl.p3 - tank2.gl.p1);
      float t = 0;
      pushMatrix();
      translate(tank2.x_pos+tank2.imgW, tank2.y_pos+tank2.imgH);

      do {
        l.displacement(b, t+=.25, angle1);
      } while (t < b.time);
      popMatrix();

      break;
    }
  }
}

void planeHit(Tank t) {

  for (Plane plane : planes) {
    for (int i = 0; i < t.count; i++) {

      if (l.collision(plane, t.currentBomb, i) == 1) {

        t.hit();
        break;
      }
    }
  } 
  System.out.println("" + t.score);
  t.countReset();
}

void mouseWheel(MouseEvent e) {

  float count = e.getCount();

  if (count < 0) {
  } else if (count > 0) {
  }
}

void mousePressed() {

  //System.out.println( "pointer x: " + mouseX + " y: " + mouseY);
}