/**********
 Cartwright, Stephen D
 Art 297A Stone
 Bombs Away! runs and holds different information pertaining to the game
 
 Instructions:
 Player 1
 use WASD to move gun laser for up down left right resp.
 left and right arrow keys to move, and down key to fire 
 
 Player 2
 mouse left and right button to move / and or aim and center wheel to fire
 
 key 1, 2 to toggle gun laser
 
 
 r key to resume, p to pause
 **********/

/*
Variables 
  - height, width for screen size
  - ArrayList<Plane> hold all active planes
  - Tank holds player 1, 2 tanks information
  - static int interval: game length, delay 1000 ms = 1 s, bombDelay: wait to drop another bomb, 
    tankCounter: options for tank, maxBombCount: max bombs tank holds, keyCounter: input from keyboard 
  - final int start...gameOver hold game states
  - volatile int: hold information for game state and vehicle positions
  - boolean init: bool to initialize something
  - Timer timer: game timer
  - PFont f2: game text font
  - PImage: hold imgaes for planes, tanks, backgrounds
  - Logic l: instance of logic class
  - rand for random sizes or numbers in general
  - Bomb b, bmb, b_2: instances of bombs
  
*/



import java.util.Timer;
import java.util.TimerTask;

ArrayList<Plane> planes = new ArrayList<Plane>(1); 
Tank tank1, tank2;

Timer timer = new Timer();
static int interval = 180, delay = 1000, period = 1000, bombDelay = 20, tankCounter = 0, maxBombCount = 10, keycounter = 1;
final int start = 0, intro = 1, game = 2, pause = 3, gameOver = 4;
volatile int state = start, tank1posX, tank2posX, tank1posY, tank2posY, planeCount;


boolean init = true;

PFont f2;
PImage t1, t2, p1, p2, bg, pbg;

Logic l;

Bomb b, bmb, b_2;


void setup() {

  f2 = createFont("Impact", 24, true);
    textFont(f2);
    
  t1 = loadImage("tank1.gif");
  t2 = loadImage("tank2.gif");
  
  p1 = loadImage("jet1.gif");
  p2 = loadImage("jet2.gif");
  
  pbg = loadImage("pause.png");
  bg = loadImage("background.jpg");
  size(1000, 1000);
  
  // new logic instance, bomb instance
  l = new Logic(1000, 1000);
  b_2 = new Bomb(25, 5, 2, 5, 10, 120);
  

  // set up player 1 tank bounds, image width and height, and it's gun laser
  tank1 = new Tank(100, 650, 10, 3);
  tank1.setBounds(-50, 310);
  tank1.imgW = t1.width;
  tank1.imgH = t1.height;
  tank1.setGunLine(tank1.x_pos+(tank1.imgW/2), tank1.y_pos+(tank1.imgH/2), tank1.x_pos+(tank1.imgW/2), tank1.y_pos+(tank1.imgH/2));
  
  // set up player 2 tank bounds, image width and height, and it's gun laser
  tank2 = new Tank(750, 650, 10, 1);
  tank2.setBounds(550, 900);
  tank2.imgW = t2.width;
  tank2.imgH = t2.height;
  tank2.setGunLine(tank2.x_pos+(tank2.imgH/2), tank2.y_pos+(tank2.imgH/2), tank2.x_pos+(tank2.imgH/2), tank2.y_pos+(tank2.imgH/2));

  // create bombs for tanks and create new planes
  loadBombs();
  loadPlanes();
  
  // create game timer and count down
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

  // update player positions instantly
  tank1posX = tank1.x_pos + tank1.imgW; 
  tank2posX = tank2.x_pos + tank2.imgW;
  tank1posY = tank1.y_pos + tank1.imgH; 
  tank2posY = tank2.y_pos + tank2.imgH;

  // if all enemy planes are down we make more muwahwhaha
  if (planeCount == 0) loadPlanes();
  // if enough time has passed give players more bombs
  if (interval % 10 == 0) {    
    loadBombs();
  }
 
 
  // if a player dies end the game
  if (tank1.health <= 0 || tank2.health <= 0) state = gameOver;
 
  // control the game state
  switch (state) {

  case game:   
    background(bg);
    imgUpdate();
    mouseAction();
    // did player 1 fire a bomb
    if (tank1.fired) {
       //System.out.format("tank1: bc %d, list size %d\n", tank1.bombCount, tank1.bl.size());
      // draw loop controlled time less than current bomb position fuse time? 
      // and the counter position for coordinates in the list of x values for bomb (y values are same size : pick one)
      if (tank1.tankTime <= tank1.currentBomb.time && tankCounter < tank1.currentBomb.bmb_X.size()) {
        // draw the bomb at the current position; update counter
        tank1.currentBomb.drawB(tank1.currentBomb.bmb_X.get(tankCounter), tank1.currentBomb.bmb_Y.get(tankCounter));
        tankCounter++;
      } else {
        // or the flight is over since bomb "exploded"
        // reset bomb list counter, time, and turn off the tank 'didFire' boolean
        tankCounter = 0;
        tank1.timeReset(); 
        tank1.negateFire();
      }
    } else if (tank2.fired) {
      // do every above step for player 2's bomb
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
  case start: 
    background(pbg);
    fill(255, 0, 0);
    text("Press r key!", (width-200)/2, height-100);
    break;

  case intro: 
    background(255);
    fill(255, 0, 0);
    text("Instructions", 100, height/2-150);
    text("Player 1\nUse WASD to move gun laser for up down left right resp.\nUse left and right arrow keys to move, and down key to fire.\n", 150, height/2-50);
    text("Player 2\nMouse left and right button to move / and or aim and center wheel to fire.\n 1, 2 key to toggle gun laser\n", 150, height/2+75);
    text("Health bars are displayed below the players and enemies,\n and bombs replenish every 10 seconds\n", 150, height/2+200);
    text("r key to resume, p to pause", 150, height/2+275);
    text("r key to Start!!", 150, height/2+325);
    break;  
  case gameOver:
    background(255);
    fill(255, 0, 0);
    text("Tank 1 Score: " + tank1.score, (width-100)/2, height/2);
    text("Tank 2 Score: " + tank2.score, (width-100)/2, height/2+20);
    if (interval == 0 && tank1.score > tank2.score) 
      text("You Won!! Well...Player 1 actually won", (width-100)/2, height/2+40);
    else if (interval == 0 && tank1.score < tank2.score)
      text("You Won!! Well...Player 2 actually won", (width-100)/2, height/2+40);
    else if (interval == 0 && tank1.score < tank2.score)
      text("You Won!! Well...No one actually 'won'..", (width-100)/2, height/2+40);
    else if (tank1.health <= 0 || tank2.health <= 0) 
      text("You Died!! Nooooo..Oh well. Next time, champ!", (width-100)/2, height/2+40);
    break;

  case pause:
    background(255);
    fill(255, 0, 0);
    text("PAUSED", (width-100)/2, height/2);
  default :
  }
}

void keyPressed(KeyEvent e) {

  if (key == CODED) 
    switch(keyCode) {

    case UP: 


      break;
    case DOWN: 
      // pick a new bomb and make sure we have one
      
      if (tank1.bl.size() > 0) { 
      // new bomb is removed from list and count decremented
      
       
        bmb = tank1.bl.get(tank1.bl.size()-1);
        bmb.usedBomb(tank1);
        --tank1.bombCount;
      // get angle from gun laser to target x,y position and reset flight time
        float angle1 = atan2(tank1.gl.p4 - tank1.gl.p2, tank1.gl.p3 - tank1.gl.p1);
        float t = 0;

     // calculate bomb flightpath while it's less than the fuse time
        do {

          l.displacement(tank1, bmb, t, angle1);
          t +=.5;
          tank1.count++;
        } while (t <= bmb.time);
        
     // set tanks current bomb to this one
        tank1.currentBomb = bmb;
     // we fired the tank now
        tank1.negateFire();
     
     
     // Loop to check if we hit a plane: for all planes
        for (Plane p : planes) {  

          
          if (l.planeHit(p, tank1)) break;
        }
     // reset the tank counter
        tank1.countReset();
      }
      break;
    case LEFT: 
    
    // move player 1 position by speed
      tank1.x_pos -= tank1.speed;
    // set gun laser at tanks position
      tank1.gl.setInitPoint(tank1.x_pos+tank1.imgW/2, tank1.y_pos+tank1.imgH/2);
    // run tank bounds 
      l.tankBounds(tank1, 0);

      break;
    case RIGHT: 
    
    // same as case LEFT:
      tank1.x_pos += tank1.speed;
      tank1.gl.setInitPoint(tank1.x_pos+tank1.imgW/2, tank1.y_pos+tank1.imgH/2);
      l.tankBounds(tank1, 1); 
      break;
    } else if (key == 'w') {
      
    // move player 1 gun laser end point up
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
    // toggle player 1 gun line; basically always on 
    l.p1Line = !l.p1Line;
  } else if (key == '2') {
    l.p2Line = !l.p2Line;
  } else if (key == 'r') {

    state = (keycounter)%3;
    keycounter++;
  } else if (key == 'p') {
    if (state == pause) state = game;
    else state = pause;
  }
}

void imgUpdate() {
  // draw tank p1
  image(t1, tank1.x_pos, tank1.y_pos);
  // set player 1 health bar points 
  tank1.hb.setPoints(tank1.x_pos, tank1posY+5, tank1posX, tank1posY+5); 
  tank1.hb.drawHealthBar(tank1.health/25);
  // draw tank p2
  image(t2, tank2.x_pos, tank2.y_pos);
  // set player 2 health bar points
  tank2.hb.setPoints(tank2.x_pos, tank2posY+5, tank2posX, tank2posY+5); 
  tank2.hb.drawHealthBar(tank2.health/25);

  // if tank p1 laser toggle on 
  if (l.p1Line)
    tank1.gl.drawL();
  // if tank p2 laser toggle on 
  if (l.p2Line)
    tank2.gl.drawL();
  // check to see if a plane is destroyed
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
      // update plane health bars 
      plane.hb.setPoints(plane.x_pos, plane.y_pos+plane.imgH+5, plane.x_pos+plane.imgW, plane.y_pos+plane.imgH+5);
      plane.hb.drawHealthBar(plane.health/25);
      
      // plane id even ? draw it going one way, opposite the od id'd planes (for variety purposes)
      if (plane.id % 2 == 0) {
        image(p1, plane.x_pos = plane.x_pos+plane.speed, plane.y_pos);
        // setup the plane bomb dropping params
        // if the bomb is dropped at a specific point and we're done delaying since the last bomb drop
        if (plane.dropY <= height && plane.delay == 0) {
          // draw a bomb 'drop' it at this point 
          plane.dropY = plane.dropBomb(plane.x_pos-plane.speed*plane.count, plane.count, plane.currentBomb.id);
          // check if we hit either player
          l.tankHit(plane.currentBomb, tank1); 
          l.tankHit(plane.currentBomb, tank2);

          plane.count++;
        } else if (plane.dropY > height && plane.delay == 0) {
          // else check if the bomb is off screen and we're done waiting; give bomb an id
          plane.delayReset();
          plane.currentBomb.setID((int)random(1, 100000));
        } else {
          // else delay to drop another bomb and fly the plane elsewhere
          plane.delay--; 
          plane.countReset();
          plane.x_pos = l.movement(plane.x_pos, plane.x_pos+plane.speed);
        }
      }
      // draw odd numbered planes and implement same logic as above
      if (plane.id % 2 == 1) {
        image(p2, plane.x_pos = plane.x_pos-plane.speed, plane.y_pos);
        if (plane.dropY <= height && plane.delay == 0) {
          plane.dropY = plane.dropBomb(plane.x_pos+plane.speed*plane.count, plane.count, plane.currentBomb.id);
          l.tankHit(plane.currentBomb, tank1); 
          l.tankHit(plane.currentBomb, tank2);

          plane.count++;
        } else if (plane.dropY > height && plane.delay == 0) {
          plane.delayReset();
          plane.currentBomb.setID((int)random(1, 100000));
        } else {
          plane.delay--; 
          plane.countReset();
          plane.x_pos = l.movement(plane.x_pos, plane.x_pos-plane.speed);
        }
      }

      // draw plane id's 
      //fill(0);
      //text("" + plane.id, plane.x_pos+plane.imgW, plane.y_pos+plane.imgH);
    }
  }

  drawScore();
}

int getRand1() {
  // return random sizes; heights for planes in this case
  return (int) random(0, 300);
}

int rand() {
  // number of new planes to draw in this case
  return (int) random(1, 5);
}

void mouseAction() {
// player 2 mouse guy 
  if (mousePressed) {
    // draw a gun laser from tank to mouseX, mouseY
    tank2.setGunLine(tank2.x_pos + tank2.imgW/2, 
      tank2.y_pos + tank2.imgH/2, 
      (tank2.line_x = mouseX), 
      (tank2.line_y = mouseY));
    switch(mouseButton) {
   // update player 2 positions with clicks
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
// check if the center wheel is clicked.. if used in the other method it would continually run while the 
// mouse button is down so.. not good for us
  if (mousePressed) {
    tank2.setGunLine(tank2.x_pos + tank2.imgW/2, 
      tank2.y_pos + tank2.imgH/2, 
      (tank2.line_x = mouseX), 
      (tank2.line_y = mouseY));
    switch(mouseButton) {
   // do the calculations for player 2's current bomb as in player 1's case with the same logic
   // and calculate the angle, time, displacement, and whether or not it hits a plane 
    case CENTER: 
      l.p2Line = !l.p2Line;
      if (tank2.bl.size() > 0) { 

        bmb = tank2.bl.get(tank2.bl.size()-1);
        bmb.usedBomb(tank2);
        --tank2.bombCount;

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



void loadBombs() {
  
  // if init it's the first loading or time is now up to refresh bombs for players 1, 2
  if (tank1.bombCount == 0 || init) {
    for (int i = 0; i < maxBombCount; i++) {
      tank1.bl.add(new Bomb(25, 5, 2, 5, 10, 120));
    } 
        
    b_2.resetBombs(tank1, maxBombCount);
    
    init = false;
  }
  if (tank2.bombCount == 0 || init) {
    for (int i = 0; i < maxBombCount; i++) {
      tank2.bl.add(new Bomb(25, 5, 2, 5, 10, 120));
    }
    
    b_2.resetBombs(tank2, maxBombCount);
    
    init = false;
  }
}


// load a random number of planes for our game
void loadPlanes() {
  planeCount = rand();
  for (int i = 0; i < planeCount; i++) {
    planes.add(new Plane(getRand1(), getRand1(), 3, rand(), p1.width, p1.height, i+1));
  }
}

void drawScore() {

  fill(255, 0, 0);

  text("Tank 1: " + tank1.score, 10, 950);
  text("Bombs Left: " + tank1.bombCount, 10, 980);
  text("Tank 2: " + tank2.score, 800, 950);
  text("Bombs Left: " + tank2.bombCount, 800, 980);
  text("TIME LEFT: " + interval, (width-100)/2, 20);
}