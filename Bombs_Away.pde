import java.util.Timer;
import java.util.TimerTask;

ArrayList<Plane> planes = new ArrayList<Plane>(1); 
Tank tank1, tank2;

Timer timer = new Timer();
static int interval = 120, delay = 1000, period = 1000, bombDelay = 20;

final int game = 0, pause = 1, gameOver = 2;
volatile int state = pause, tank1posX, tank2posX, tank1posY, tank2posY, planeCount;

PFont f1, f2;
PImage t1, t2, p1, p2, bg, pbg;
Logic l;

Bomb b, bmb, b_2;
int tankCounter = 0, bombCount = 10;
void setup() {
  //f1 = createFont("Arial", 16, true);
  f2 = createFont("Impact", 24, true);
  t1 = loadImage("tank1.gif");
  t2 = loadImage("tank2.gif");
  p1 = loadImage("jet1.gif");
  p2 = loadImage("jet2.gif");
  pbg = loadImage("pause.png");
  bg = loadImage("background.jpg");
  size(1000, 1000);
  l = new Logic(1000, 1000);
  b_2 = new Bomb(25, 5, 2, 5, 10, 120);


  tank1 = new Tank(100, 650, 10, 3);
  tank1.setBounds(-50, 350);
  tank1.imgW = t1.width;
  tank1.imgH = t1.height;
  tank1.setGunLine(tank1.x_pos+(tank1.imgW/2), tank1.y_pos+(tank1.imgH/2), tank1.x_pos+(tank1.imgW/2), tank1.y_pos+(tank1.imgH/2));

  tank2 = new Tank(750, 650, 10, 1);
  tank2.setBounds(550, 900);
  tank2.imgW = t2.width;
  tank2.imgH = t2.height;
  tank2.setGunLine(tank2.x_pos+(tank2.imgH/2), tank2.y_pos+(tank2.imgH/2), tank2.x_pos+(tank2.imgH/2), tank2.y_pos+(tank2.imgH/2));

  loadBombs();
  loadPlanes();

  timer.scheduleAtFixedRate(new TimerTask() {
    public void run() {
      if (interval == 0) {
        timer.cancel();
        state = gameOver;
      } else --interval;
      //System.out.println("" + interval);
    }
  }
  , delay, period);
}

void draw() {

  tank1posX = tank1.x_pos + tank1.imgW; 
  tank2posX = tank2.x_pos + tank2.imgW;
  tank1posY = tank1.y_pos + tank1.imgH; 
  tank2posY = tank2.y_pos + tank2.imgH;
  if (planeCount == 0) loadPlanes();
  if (interval % 10 == 0) {

    b_2.resetBombs(tank1, bombCount);
    b_2.resetBombs(tank2, bombCount);

    loadBombs();
  }
  if (tank1.health <= 0 || tank2.health <= 0) state = gameOver;

  switch (state) {

  case game:   
    background(bg);
    imgUpdate();
    mouseAction();
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
      if (tank2.tankTime <= tank2.currentBomb.time && tankCounter < tank2.currentBomb.bmb_X.size()) {

        tank2.currentBomb.drawB(tank2.currentBomb.bmb_X.get(tankCounter), tank2.currentBomb.bmb_Y.get(tankCounter));
        tankCounter++;
      } else {
        tankCounter = 0;
        tank2.timeReset(); 
        tank2.negateFire();
      }
    }


    break;
  case pause: 
    background(pbg);
    break;
  case gameOver:
    background(255);
    text("Tank 1 Score: " + tank1.score, width/2, height/2);
    text("Tank 2 Score: " + tank2.score, width/2, height/2+20);
    if (interval == 0 && tank1.score > tank2.score) 
      text("You Won!! Well...Player 1 actually won", width/2, height/2+40);
    else if (interval == 0 && tank1.score < tank2.score)
      text("You Won!! Well...Player 2 actually won", width/2, height/2+40);
    else if (interval == 0 && tank1.score < tank2.score)
      text("You Won!! Well...No one actually won..", width/2, height/2+40);
    else if (tank1.health <= 0 || tank2.health <= 0) 
      text("You Died!! Nooooo..Oh well.. next time, champ: ", width/2, height/2+40);
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

        bmb = tank1.bl.get(tank1.bl.size()-1);
        bmb.usedBomb(tank1);
        tank1.bombCount--;

        float angle1 = atan2(tank1.gl.p4 - tank1.gl.p2, tank1.gl.p3 - tank1.gl.p1);
        float t = 0;


        do {

          l.displacement(tank1, bmb, t, angle1);
          t +=.5;
          tank1.count++;
        } while (t <= bmb.time);

        tank1.currentBomb = bmb;
        tank1.negateFire();

        for (Plane p : planes) {  

          //System.out.println("" + p.id);
          if (l.planeHit(p, tank1)) break;
        }
        tank1.countReset();
      }
      break;
    case LEFT: 
      tank1.x_pos -= tank1.speed;
      tank1.gl.setInitPoint(tank1.x_pos+tank1.imgW/2, tank1.y_pos+tank1.imgH/2);
      l.tankBounds(tank1, 0);

      break;
    case RIGHT: 
      tank1.x_pos += tank1.speed;
      tank1.gl.setInitPoint(tank1.x_pos+tank1.imgW/2, tank1.y_pos+tank1.imgH/2);
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
  // draw tank p1
  image(t1, tank1.x_pos, tank1.y_pos);
  tank1.hb.setPoints(tank1.x_pos, tank1posY+5, tank1posX, tank1posY+5); 
  tank1.hb.drawHealthBar(tank1.health/25);
  // draw tank p2
  image(t2, tank2.x_pos, tank2.y_pos);
  tank2.hb.setPoints(tank2.x_pos, tank2posY+5, tank2posX, tank2posY+5); 
  tank2.hb.drawHealthBar(tank2.health/25);

  // if tank p1 laser toggle on 
  if (l.p1Line)
    tank1.gl.drawL();
  // if tank p2 laser toggle on 
  if (l.p2Line)
    tank2.gl.drawL();

  try {
    for (Plane plane : planes)
      if (!plane.alive) {
        planes.remove(plane);
        planeCount--;
      }
  } 
  catch(Exception e) {
  }


  // cycle through and draw planes 
  for (Plane plane : planes) { 

    if (plane.alive) {
      plane.hb.setPoints(plane.x_pos, plane.y_pos+plane.imgH+5, plane.x_pos+plane.imgW, plane.y_pos+plane.imgH+5);
      //System.out.println("p id/p health " + plane.id + " " + plane.health);
      plane.hb.drawHealthBar(plane.health/25);
      if (plane.id % 2 == 0) {
        image(p1, plane.x_pos = plane.x_pos+plane.speed, plane.y_pos);
        if (plane.dropY <= height && plane.delay == 0) {
          plane.dropY = plane.dropBomb(plane.x_pos-plane.speed*plane.count, plane.count, plane.currentBomb.id);
          l.tankHit(plane.currentBomb, tank1); 
          l.tankHit(plane.currentBomb, tank2);

          plane.count++;
        } else if (plane.dropY > height && plane.delay == 0) {
          plane.delayReset();
          plane.currentBomb.setID((int)random(0, 100000));
        } else {
          plane.delay--; 
          plane.countReset();
          plane.x_pos = l.movement(plane.x_pos, plane.x_pos+plane.speed);
        }
      }
      if (plane.id % 2 == 1) {
        image(p2, plane.x_pos = plane.x_pos-plane.speed, plane.y_pos);
        if (plane.dropY <= height && plane.delay == 0) {
          plane.dropY = plane.dropBomb(plane.x_pos+plane.speed*plane.count, plane.count, plane.currentBomb.id);
          l.tankHit(plane.currentBomb, tank1); 
          l.tankHit(plane.currentBomb, tank2);

          plane.count++;
        } else if (plane.dropY > height && plane.delay == 0) {
          plane.delayReset();
          plane.currentBomb.setID((int)random(0, 100000));
        } else {
          plane.delay--; 
          plane.countReset();
          plane.x_pos = l.movement(plane.x_pos, plane.x_pos-plane.speed);
        }
      }


      fill(0);
      text("" + plane.id, plane.x_pos+plane.imgW, plane.y_pos+plane.imgH);
    }
  }

  drawScore();
}

int getRand1() {
  // return random sizes
  return (int) random(0, 300);
}

int rand() {

  return (int) random(1, 5);
}

void mouseAction() {

  if (mousePressed) {
    tank2.setGunLine(tank2.x_pos + tank2.imgW/2, 
      tank2.y_pos + tank2.imgH/2, 
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
    }
  }
}


void mousePressed() {

  if (mousePressed) {
    tank2.setGunLine(tank2.x_pos + tank2.imgW/2, 
      tank2.y_pos + tank2.imgH/2, 
      (tank2.line_x = mouseX), 
      (tank2.line_y = mouseY));
    switch(mouseButton) {

    case CENTER: 
      l.p2Line = !l.p2Line;
      if (tank2.bl.size() > 0) { 

        bmb = tank2.bl.get(tank2.bl.size()-1);
        bmb.usedBomb(tank2);
        tank2.bombCount--;

        float angle1 = atan2(tank2.gl.p4 - tank2.gl.p2, tank2.gl.p3 - tank2.gl.p1);
        float t = 0;


        do {

          l.displacement(tank2, bmb, t, angle1);
          t +=.5;
          tank2.count++;
        } while (t <= bmb.time);

        tank2.currentBomb = bmb;
        tank2.negateFire();

        for (Plane p : planes) {  

          //System.out.println("" + p.id);
          if (l.planeHit(p, tank2)) break;
        }
        tank2.countReset();
      }

      break;
    }
  }
}



//void mouseWheel(MouseEvent e) {

//  float count = e.getCount();

//  if (count < 0) {
//  } else if (count > 0) {
//  }
//}

//void mousePressed() {

//  System.out.println( "pointer x: " + mouseX + " y: " + mouseY);
//}

void loadBombs() {

  for (int i = 0; i < tank1.bombCount; i++) {
    tank1.bl.add(new Bomb(25, 5, 2, 5, 10, 120));
  } 

  for (int i = 0; i < tank2.bombCount; i++) {
    tank2.bl.add(new Bomb(25, 5, 2, 5, 10, 120));
  }
}

void loadPlanes() {
  planeCount = rand();
  for (int i = 0; i < planeCount; i++) {
    planes.add(new Plane(getRand1(), getRand1(), 3, rand(), p1.width, p1.height, i));
  }
}

void drawScore() {

  fill(255, 0, 0);
  textFont(f2);
  text("Tank 1: " + tank1.score, 10, 950);
  text("Bombs Left: " + tank1.bombCount, 10, 980);
  text("Tank 2: " + tank2.score, 800, 950);
  text("Bombs Left: " + tank2.bombCount, 800, 980);
  text("TIME LEFT: " + interval, (width-100)/2, 20);
}