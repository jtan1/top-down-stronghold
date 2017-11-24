import java.awt.event.KeyEvent;

// Images
public PImage imgField, imgCheval, imgPortcullis, imgMoat, imgRamparts, imgDrawbridge, imgSallyPort, imgRockWall, imgRoughTerrain, imgLowBarB, imgLowBarR, 
  imgBFullLight, imgBDamagedLight, imgRFullLight, imgRDamagedLight, imgDeadLight,
  imgBFullBar, imgBDamagedBar, imgRFullBar, imgRDamagedBar, imgDeadBar;

// Objects
Robot Robots[] = new Robot[2];
int DefID[][] = new int[2][4];
ArrayList<Integer> availablePositions = new ArrayList<Integer>();
Defense Defenses[][] = new Defense[2][5];
ArrayList<Boulder> Boulders = new ArrayList<Boulder>();
Barrier Barriers[] = new Barrier[30];

// Internal Variables
int defSeed, defChoice;
int startTime, currentTime;
boolean isAuto = true;
boolean runTimer = false;

void setup() {
  size(1298, 838);
  
  imgField = loadImage("/assets/img/field.png");
  imgCheval = loadImage("/assets/img/cheval.png");
  imgPortcullis = loadImage("/assets/img/portcullis.png");
  imgMoat = loadImage("/assets/img/moat.png");
  imgRamparts = loadImage("/assets/img/ramparts.png");
  imgDrawbridge = loadImage("/assets/img/drawbridge.png");
  imgSallyPort = loadImage("/assets/img/sallyport.png");
  imgRockWall = loadImage("/assets/img/rockwall.png");
  imgRoughTerrain = loadImage("/assets/img/roughterrain.png");
  imgLowBarB = loadImage("/assets/img/lowbarblue.png");
  imgLowBarR = loadImage("/assets/img/lowbarred.png");
  
  imgBFullLight = loadImage("/assets/img/blight.png");
  imgBDamagedLight = loadImage("/assets/img/blight_damaged.png");
  imgRFullLight = loadImage("/assets/img/rlight.png");
  imgRDamagedLight = loadImage("/assets/img/rlight_damaged.png");
  imgDeadLight = loadImage("/assets/img/deadlight.png");
  
  imgBFullBar = loadImage("/assets/img/bbar.png");
  imgBDamagedBar = loadImage("/assets/img/bbar_damaged.png");
  imgRFullBar = loadImage("/assets/img/rbar.png");
  imgRDamagedBar = loadImage("/assets/img/rbar_damaged.png");
  imgDeadBar = loadImage("/assets/img/deadbar.png");
  
  Robots[0] = new Robot(696f, 364f, 0f, true);
  Robots[1] = new Robot(601f, 473f, 180f, false);
  
  for(int[] defIDSide : DefID) {
    defSeed = floor(random(0, 24));
    for(int i = 0; i < defIDSide.length; i++) {
      availablePositions.add(i);
    }
    for(int i = 0; i < defIDSide.length; i++) {
      defChoice = defSeed % (defIDSide.length - i);
      defIDSide[i] = 2 * availablePositions.get(defChoice) + floor(random(0, 2));
      availablePositions.remove(defChoice);
    }
  }
  
  Defenses[0][0] = new Defense(431f, 685f, 0, 8, true);
  Defenses[0][1] = new Defense(431f, 578f, 1, DefID[0][0], true);
  Defenses[0][2] = new Defense(431f, 471f, 2, DefID[0][1], true);
  Defenses[0][3] = new Defense(431f, 364f, 3, DefID[0][2], true);
  Defenses[0][4] = new Defense(431f, 257f, 4, DefID[0][3], true);
  Defenses[1][0] = new Defense(866f, 152f, 0, 8, false);
  Defenses[1][1] = new Defense(866f, 257f, 1, DefID[1][0], false);
  Defenses[1][2] = new Defense(866f, 364f, 2, DefID[1][1], false);
  Defenses[1][3] = new Defense(866f, 471f, 3, DefID[1][2], false);
  Defenses[1][4] = new Defense(866f, 578f, 4, DefID[1][3], false);
  
  Boulders.add(new Boulder(649f, 259f, 0f, 0f));
  Boulders.add(new Boulder(649f, 419f, 0f, 0f));
  Boulders.add(new Boulder(649f, 579f, 0f, 0f));
  
  Barriers[0] = new Barrier(0f, 99f, 1297f, 99f, true);
  Barriers[1] = new Barrier(1297f, 99f, 1297f, 738f, true);
  Barriers[2] = new Barrier(1297f, 738f, 0f, 738f, true);
  Barriers[3] = new Barrier(0f, 738f, 0f, 99f, true);
  Barriers[4] = new Barrier(0f, 341f, 7f, 344f, true);
  Barriers[5] = new Barrier(37f, 361f, 47f, 367f, true);
  Barriers[6] = new Barrier(47f, 367f, 47f, 384f, true);
  Barriers[7] = new Barrier(47f, 409f, 47f, 426f, true);
  Barriers[8] = new Barrier(47f, 426f, 37f, 432f, true);
  Barriers[9] = new Barrier(7f, 449f, 0f, 452f, true);
  Barriers[10] = new Barrier(51f, 365f, 96f, 339f, true);
  Barriers[11] = new Barrier(51f, 428f, 96f, 454f, true);
  Barriers[12] = new Barrier(381f, 204f, 480f, 204f, true);
  Barriers[13] = new Barrier(381f, 311f, 480f, 311f, true);
  Barriers[14] = new Barrier(381f, 418f, 480f, 418f, true);
  Barriers[15] = new Barrier(381f, 525f, 480f, 525f, true);
  Barriers[16] = new Barrier(381f, 632f, 480f, 632f, true);
  Barriers[17] = new Barrier(1297f, 385f, 1290f, 388f, true);
  Barriers[18] = new Barrier(1260f, 405f, 1250f, 411f, true);
  Barriers[19] = new Barrier(1250f, 411f, 1250f, 428f, true);
  Barriers[20] = new Barrier(1250f, 453f, 1250f, 470f, true);
  Barriers[21] = new Barrier(1250f, 470f, 1260f, 476f, true);
  Barriers[22] = new Barrier(1290f, 493f, 1297f, 496f, true);
  Barriers[23] = new Barrier(1201f, 383f, 1246f, 409f, true);
  Barriers[24] = new Barrier(1246f, 472f, 1201f, 498f, true);
  Barriers[25] = new Barrier(816f, 204f, 915f, 204f, true);
  Barriers[26] = new Barrier(816f, 311f, 915f, 311f, true);
  Barriers[27] = new Barrier(816f, 418f, 915f, 418f, true);
  Barriers[28] = new Barrier(816f, 525f, 915f, 525f, true);
  Barriers[29] = new Barrier(816f, 631f, 915f, 631f, true);
  
  textAlign(CENTER, CENTER);
}

void draw() {
  imageMode(CORNER);
  image(imgField, 0, 0);
  
  fill(0);
  
  textSize(32);
  if(runTimer) {
    currentTime = 150 - ((millis() - startTime) / 1000);
    if(isAuto) {
      text(currentTime - 135, 649, 783);
      if(currentTime == 135) {
        isAuto = false;
      }
    }
    else {
      text(currentTime, 649, 783);
    }
    if(currentTime == 0) {
      runTimer = false;
      if(pow(Robots[0].x - 1297, 2) + pow(Robots[0].y - 440, 2) < 10000) {
        if(Robots[0].isScaled) {
          Robots[1].totalScore += 15;
        }
        else {
          Robots[1].totalScore += 5;
        }
        
        if(Robots[1].bouldersScored >= 8) {
          Robots[1].totalScore += 25;
        }
      }
      if(pow(Robots[1].x, 2) + pow(Robots[1].y - 397, 2) < 10000) {
        if(Robots[1].isScaled) {
          Robots[0].totalScore += 15;
        }
        else {
          Robots[0].totalScore += 5;
        }
        
        if(Robots[0].bouldersScored >= 8) {
          Robots[0].totalScore += 25;
        }
      }
    }
  }
  else {
    text(0, 649, 783);
  }
  //// sdfsdfsdf
  //text(Robots[1].input.mag, 700, 200);
  //text(Robots[1].input.dir, 700, 300);
  //text(Robots[1].vel.mag, 700, 400);
  //text(Robots[1].vel.dir, 700, 500);
  //text(Robots[1].proj.mag, 700, 600);
  //text(Robots[1].proj.dir, 700, 700);
  //// sdfsdfsdf
  textSize(28);
  text(Robots[0].totalScore, 833, 783);
  text(Robots[1].totalScore, 464, 783);
  
  if(((millis() % 30000 < 16) || (millis() - Robots[1].boulderTimestamp > 4999 && millis() - Robots[1].boulderTimestamp < 5016)) && runTimer) {
    Boulders.add(new Boulder(1282f, 687f, random(12, 22), 180 + random(-3, 3)));
  }
  if(((millis() % 30000 < 16) || (millis() - Robots[0].boulderTimestamp > 4999 && millis() - Robots[0].boulderTimestamp < 5016)) && runTimer) {
    Boulders.add(new Boulder(15f, 149f, random(12, 22), random(-3, 3)));
  }

  for(Defense[] defense_side : Defenses) {
    for(Defense defense : defense_side) {
      defense.display();
      imageMode(CORNER);
      if(defense.isBlue) {
        switch(defense.health) {
        case 2:
          image(imgBFullBar, 236, 819 - 17 * defense.pos);
          break;
        case 1:
          image(imgBDamagedBar, 236, 819 - 17 * defense.pos);
          break;
        default:
          image(imgDeadBar, 236, 819 - 17 * defense.pos);
          break;
        }
      }
      else {
        switch(defense.health) {
        case 2:
          image(imgRFullBar, 974, 751 + 17 * defense.pos);
          break;
        case 1:
          image(imgRDamagedBar, 974, 751 + 17 * defense.pos);
          break;
        default:
          image(imgDeadBar, 974, 751 + 17 * defense.pos);
          break;
        }
      }
    }
  }
  
  for(Boulder boulder : Boulders) {
    boulder.display();
    
    for(Barrier barrier : Barriers) {
      if(boulder.isColliding(barrier)) {
        boulder.performCollision(barrier.getAngle());
      }
    }
    
    if(boulder.isColliding(46, 397, 15) || boulder.isColliding(22, 353, 15) || boulder.isColliding(22, 440, 15)) {
      boulder.y = -1000;
      Robots[0].boulderTimestamp = millis();
      if(isAuto) {
        Robots[0].totalScore += 10;
      }
      else {
        Robots[0].totalScore += 5;
      }
      Robots[0].bouldersScored++;
    }
    else if(boulder.isColliding(1251, 440, 15) || boulder.isColliding(1275, 397, 15) || boulder.isColliding(1275, 483, 15)) {
      boulder.y = -1000;
      Robots[1].boulderTimestamp = millis();
      if(isAuto) {
        Robots[1].totalScore += 10;
      }
      else {
        Robots[1].totalScore += 5;
      }
      Robots[1].bouldersScored++;
    }
  }
  
  for(Barrier barrier : Barriers) {
    barrier.display();
  }
  
  for(Robot robot : Robots) {
    for(Boulder boulder : Boulders) {
      if(boulder.isColliding(robot) && !robot.hasBoulder) {
        boulder.y = -1000;
        robot.hasBoulder = true;
      }
    }
    
    robot.velMultiplier = 1;
    for(Defense[] defense_side : Defenses) {
      for(Defense defense : defense_side) {
        defense.touchingFront = defense.isColliding(robot.RobotEdges[0]);
        defense.touchingBack = defense.isColliding(robot.RobotEdges[2]);
        
        if((robot.facingRight && defense.isBlue) || (robot.facingLeft && !defense.isBlue)) {
          if(defense.crossingStage == 0 && !defense.touchingFront && defense.touchingBack) {
            defense.crossingStage = 1;
          }
          else if(defense.crossingStage == 2 && defense.touchingFront && !defense.touchingBack) {
            defense.crossingStage = 3;
          }
        }
        if((robot.facingLeft && defense.isBlue) || (robot.facingRight && !defense.isBlue)) {
          if(defense.crossingStage == 0 && defense.touchingFront && !defense.touchingBack) {
            defense.crossingStage = 1;
          }
          else if(defense.crossingStage == 2 && !defense.touchingFront && defense.touchingBack) {
            defense.crossingStage = 3;
          }
        }
        if(defense.touchingFront && defense.touchingBack) {
          robot.velMultiplier = 0.90;
          if(defense.crossingStage == 1) {
            defense.crossingStage = 2;
          }
        }
        if(defense.crossingStage == 3 && !defense.touchingFront && !defense.touchingBack && defense.health > 0) {
          defense.crossingStage = 0;
          defense.health--;
          if(isAuto) {
            robot.totalScore += 10;
          }
          else {
            robot.totalScore += 5;
          }
          if(defense.health == 0) {
            robot.defensesBreached++;
            if(robot.defensesBreached == 4) {
              robot.totalScore += 20;
            }
          }
        }
      }
    }
    
    robot.display();
  }
}

void keyPressed() {
  setKey(keyCode, true);
}

void keyReleased() {
  setKey(keyCode, false);
}

boolean setKey(int button, boolean state) {
  switch(button) {
  case KeyEvent.VK_W:
    return Robots[1].isAccel = state;
  case KeyEvent.VK_A:
    return Robots[1].isTurnL = state;
  case KeyEvent.VK_S:
    return Robots[1].isDecel = state;
  case KeyEvent.VK_D:
    return Robots[1].isTurnR = state;
  case KeyEvent.VK_Q:
    Robots[1].fireBoulder();
    return true;
  case KeyEvent.VK_E:
    if(pow(Robots[1].x, 2) + pow(Robots[1].y - 397, 2) < 10000) {
      Robots[1].decel = 0;
      Robots[1].angAccel = 0;
      return Robots[1].isScaled = true;
    }
    return false;
  
  case KeyEvent.VK_I:
    return Robots[0].isAccel = state;
  case KeyEvent.VK_J:
    return Robots[0].isTurnL = state;
  case KeyEvent.VK_K:
    return Robots[0].isDecel = state;
  case KeyEvent.VK_L:
    return Robots[0].isTurnR = state;
  case KeyEvent.VK_U:
    Robots[0].fireBoulder();
    return true;
  case KeyEvent.VK_O:
    if(pow(Robots[0].x - 1297, 2) + pow(Robots[0].y - 440, 2) < 10000) {
      Robots[0].decel = 0;
      Robots[0].angAccel = 0;
      return Robots[0].isScaled = true;
    }
    return false;
  
  case KeyEvent.VK_ENTER:
    if(!runTimer) {
      startTime = millis();
      return runTimer = true;
    }
  default:
    return true;
  }
}