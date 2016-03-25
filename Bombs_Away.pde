import java.util.Timer;
import java.util.TimerTask;

ArrayList<Plane> planes = new ArrayList<Plane>(1); 
Tank tank1, tank2;

Timer timer = new Timer();
static int interval = 100, delay = 1000, period = 1000;

final int game = 0, pause = 1, gameOver = 2;
volatile int state = pause;

PFont f1, f2;
PImage t1, t2, p1, p2, bg, pbg;
Logic l;

Bomb b;
Bomb bmb;
int tankCounter = 0, c = 0;
void setup() {
  //f1 = createFont("Arial", 16, true);
  f2 = createFont("Arial", 36, true);
  t1 = loadImage("tank1.gif");
  t2 = loadImage("tank2.gif");
  p1 = loadImage("jet1.gif");
  p2 = loadImage("jet2.gif");
  pbg = loadImage("pause.png");
  bg = loadImage("back.jpg");
  size(1000, 1000);
  l = new Logic(1000, 1000);
  for (int i = 0; i < 4; i++) {
    planes.add(new Plane(getRand1(), getRand1(), 3, rand(), p1.width, p1.height, i));
  }
  
  tank1 = new Tank(100, 750, 3, 3);
  tank1.setBounds(-50, 350);
  tank1.imgW = t1.width;
  tank1.imgH = t1.height;
  tank1.setGunLine(tank1.x_pos+(tank1.imgW/2), tank1.y_pos+(tank1.imgH/2), tank1.x_pos+(tank1.imgW/2), tank1.y_pos+(tank1.imgH/2));

  tank2 = new Tank(750, 750, 3, 1);
  tank2.setBounds(550, 900);
  tank2.imgW = t2.width;
  tank2.imgH = t2.height;
  tank2.setGunLine(tank2.x_pos+(tank2.imgH/2), tank2.y_pos+(tank2.imgH/2), tank2.x_pos+(tank2.imgH/2), tank2.y_pos+(tank2.imgH/2));

  for (int i = 0; i < 10; i++) {
    tank1.bl.add(new Bomb(25, 5, 2, 5, 10, 120));
  } 

  for (int i = 0; i < 10; i++) {
    tank2.bl.add(new Bomb(25, 5, 2, 5, 10, 120));
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





  switch (state) {

  case game:   
    background(bg);
    imgUpdate();
    //check();
    if (tank1.fired) {
      
      if (tank1.tankTime <= tank1.currentBomb.time && tankCounter < tank1.currentBomb.bmb_X.size()) {

        tank1.currentBomb.drawB(tank1.currentBomb.bmb_X.get(tankCounter), tank1.currentBomb.bmb_Y.get(tankCounter));
        tankCounter++;
      } else {
        tankCounter = 0;
        tank1.timeReset(); 
        tank1.negateFire();
      }
      
    } else if (tank2.fired) {
    }
    break;
  case pause: 
    background(pbg);
    break;
  case gameOver:
    break;
  default :
  }
}

void keyPressed(KeyEvent e) {

  if (key == CODED) 
    switch(keyCode) {

    case UP: 

      break;
    case DOWN: 
      if (tank1.bl.size() > 0) { 
        c += 1;
        bmb = tank1.bl.get(tank1.bl.size()-1);
        bmb.usedBomb(tank1);


        float angle1 = atan2(tank1.gl.p4 - tank1.gl.p2, tank1.gl.p3 - tank1.gl.p1);
        // System.out.println("" + tank1.gl.p1 + " : " + tank1.gl.p2 + " : " + tank1.gl.p3 + " : " + tank1.gl.p4 );
        float t = 0;


        do {

          l.displacement2(tank1, bmb, t, angle1);
          t +=.5;
          tank1.count++;
        } while (t <= bmb.time);

        tank1.currentBomb = bmb;
        tank1.negateFire();
        planeHit(tank1);
      }
      break;
    case LEFT: 
      tank1.x_pos -= tank1.speed;
      tank1.gl.setInitPoint(tank1.x_pos + tank1.imgW/2, tank1.y_pos + tank1.imgH/2);
      l.tankBounds(tank1, 0);

      break;
    case RIGHT: 
      tank1.x_pos += tank1.speed;
      tank1.gl.setInitPoint(tank1.x_pos + tank1.imgW/2, tank1.y_pos + tank1.imgH/2);
      l.tankBounds(tank1, 1); 
      break;
    } else if (key == 'w') {
    tank1.gl.setFinalPoint(tank1.line_x, 
      tank1.line_y = tank1.line_y-50);
  } else if (key == 's') {
    tank1.gl.setFinalPoint(tank1.line_x, 
      tank1.line_y = tank1.line_y+50);
  } else if (key == 'a') {
    tank1.gl.setFinalPoint((tank1.line_x = tank1.line_x-50), 
      tank1.line_y);
  } else if (key == 'd') {
    tank1.gl.setFinalPoint((tank1.line_x = tank1.line_x+50), 
      tank1.line_y);
  } else if (key == '1') {
    l.p1Line = !l.p1Line;
  } else if (key == '2') {
    l.p2Line = !l.p2Line;
  } else if (key == 'p') {
    state = pause;
  } else if (key == 'r') {

    state = game;
  } else {
  }
}

void imgUpdate() {
  image(t1, tank1.x_pos, tank1.y_pos);
  image(t2, tank2.x_pos, tank2.y_pos);
  if (l.p1Line)
    tank1.gl.drawL();
  if (l.p2Line)
    tank2.gl.drawL();
  for (Plane plane : planes) { 

    if (plane.id % 2 == 0) {
      image(p1, plane.x_pos = plane.x_pos+plane.speed, plane.y_pos);
      if (plane.dropY <= height && plane.delay == 0) {
        plane.dropY = plane.dropBomb(plane.x_pos-plane.speed*plane.count, plane.count);
        plane.count++;
      } else if (plane.dropY > height && plane.delay == 0) {
        plane.delayReset();
      } else {
        plane.delay--; 
        plane.countReset();
        plane.x_pos = l.movement(plane.x_pos, plane.x_pos+plane.speed);
      }
    }
    if (plane.id % 2 == 1) {
      image(p2, plane.x_pos = plane.x_pos-plane.speed, plane.y_pos);
      if (plane.dropY <= height) {
        plane.dropY = plane.dropBomb(plane.x_pos+plane.speed*plane.count, plane.count);
        plane.count++;
      } else if (plane.dropY > height && plane.delay == 0) {
        plane.delayReset();
      } else {
        plane.delay--; 
        plane.countReset();
        plane.x_pos = l.movement(plane.x_pos, plane.x_pos-plane.speed);
      }
    }  


    fill(0);
    text("" + plane.id, plane.x_pos + plane.imgW, plane.y_pos + plane.imgH);
  }
  drawScore();
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

      do {
        l.displacement2(tank2, b, t+=.5, angle1);
      } while (t <= b.time);


      break;
    }
  }
}

void planeHit(Tank t) {
  boolean breakOut = false;
  for (Plane plane : planes) {
    if (breakOut) break;
    for (int i = 0; i < t.count; i++) {
      if (breakOut) break;
      if (l.collision2(plane, t.currentBomb, i)) {

        t.hit();
        breakOut = !breakOut;
      }
    }
  } 
  System.out.println("" + c);
  t.countReset();
}

//void mouseWheel(MouseEvent e) {

//  float count = e.getCount();

//  if (count < 0) {
//  } else if (count > 0) {
//  }
//}

void mousePressed() {

 System.out.println( "pointer x: " + mouseX + " y: " + mouseY);
 
}

void drawScore() {

  fill(0);
  text("Tank 1: " + tank1.score, 100, 950);
  text("Tank 2: " + tank2.score, 900, 950);
  text("TIME LEFT: " + interval, (width-100)/2, 20);
}