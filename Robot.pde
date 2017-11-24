class Robot {
  // Parameters
  private float x;
  private float y;
  private boolean isBlue;
  
  // Internal Usage
  private int fill;
  private float lastBoulderTime = 0;
  private Vector input = new Vector(0, 0);
  private Vector vel = new Vector(0, 0);
  private Vector proj = new Vector(0, 0);
  private float velMultiplier = 1;
  private Barrier RobotEdges[] = new Barrier[4];
  private float[][] Corners = this.getCorners();
  private float[][][] Lines = this.getLines();
  
  // Constants
  private int stroke = 0;
  private int thickness = 1;
  private float robotWidth = 30;
  private float robotHeight = 36;
  private float accel = 0.30;
  private float decel = 0.93;
  private float angAccel = 3.0;
  
  // States
  private boolean isAccel = false;
  private boolean isDecel = false;
  private boolean isTurnL = false;
  private boolean isTurnR = false;
  private boolean hasBoulder = true;
  private boolean facingLeft = false;
  private boolean facingRight = false;
  private boolean inCollision = false;
  private boolean isScaled = false;
  
  // Scoring
  private int totalScore = 0;
  private int defensesBreached = 0;
  private int bouldersScored = 0;
  private int boulderTimestamp = 0;
  
  Robot(float x_, float y_, float angle_, boolean isBlue_) {
    x = x_;
    y = y_;
    isBlue = isBlue_;
    input.dir = angle_;
    if(isBlue) {
      fill = #1F1FFF;
    }
    else {
      fill = #FF1F1F;
    }
    
    for(int i = 0; i < 4; i++) {
      RobotEdges[i] = new Barrier(Lines[i][0][0], Lines[i][0][1], Lines[i][1][0], Lines[i][1][1], true);
    }
    
    this.display();
  }
  
  // Format: [which corner][X or Y]
  float[][] getCorners() {
    return new float[][] {{robotWidth * cos(radians(input.dir + 90)) + robotHeight * cos(radians(input.dir)) + x,
      robotWidth * sin(radians(input.dir + 90)) + robotHeight * sin(radians(input.dir)) + y}, 
    {robotWidth * cos(radians(input.dir - 90)) + robotHeight * cos(radians(input.dir)) + x,
      robotWidth * sin(radians(input.dir - 90)) + robotHeight * sin(radians(input.dir)) + y}, 
    {robotWidth * cos(radians(input.dir - 90)) - robotHeight * cos(radians(input.dir)) + x,
      robotWidth * sin(radians(input.dir - 90)) - robotHeight * sin(radians(input.dir)) + y}, 
    {robotWidth * cos(radians(input.dir + 90)) - robotHeight * cos(radians(input.dir)) + x,
      robotWidth * sin(radians(input.dir + 90)) - robotHeight * sin(radians(input.dir)) + y}};
  }
  
  // Format: [which line][Point 1 or Point 2][X or Y]
  float[][][] getLines() {
    return new float[][][] {{{Corners[0][0], Corners[0][1]}, {Corners[1][0], Corners[1][1]}}, 
      {{Corners[1][0], Corners[1][1]}, {Corners[2][0], Corners[2][1]}}, 
      {{Corners[2][0], Corners[2][1]}, {Corners[3][0], Corners[3][1]}}, 
      {{Corners[3][0], Corners[3][1]}, {Corners[0][0], Corners[0][1]}}};
  }
  
  void display() {
    if(runTimer) {
      moveRobot();
    }
    
    facingLeft = (input.dir % 360 >= 160 && input.dir % 360 <= 200);
    facingRight = (input.dir % 360 >= 340 || input.dir % 360 <= 20);
    
    Corners = getCorners();
    Lines = getLines();

    fill(fill);
    stroke(stroke);
    strokeWeight(thickness);
    
    for(int i = 0; i < 4; i++) {
      RobotEdges[i].x1 = Lines[i][0][0];
      RobotEdges[i].y1 = Lines[i][0][1];
      RobotEdges[i].x2 = Lines[i][1][0];
      RobotEdges[i].y2 = Lines[i][1][1];
    }
    
    quad(Corners[0][0], Corners[0][1], Corners[1][0], Corners[1][1], Corners[2][0], Corners[2][1], Corners[3][0], Corners[3][1]);
    ellipse((Corners[0][0] + Corners[1][0]) / 2, (Corners[0][1] + Corners[1][1]) / 2, 10, 10);
    
    strokeWeight(1);
    fill(127);
    
    if(hasBoulder) {
      ellipse((Corners[0][0] + Corners[1][0]) / 2, (Corners[0][1] + Corners[1][1]) / 2, 25, 25);
    }
    
    if(isScaled) {
      ellipse((Corners[0][0] + Corners[2][0]) / 2, (Corners[0][1] + Corners[2][1]) / 2, 15, 15);
    }
  }
  
  void moveRobot() {
    if(isAccel) {
      input.mag += accel;
    }
    if(isDecel) {
      input.mag -= accel;
    }
    input.mag *= decel * velMultiplier;
    
    if(isTurnR) {
      input.dir += angAccel;
    }
    if(isTurnL) {
      input.dir -= angAccel;
    }
    
    inCollision = false;
    //for(Barrier barrier : Barriers) {
    //  if(this.isColliding(barrier)) {
    //    inCollision = true;
    //    vel.mag = input.proj(barrier.getAngle()).mag + 2 * input.rej(barrier.getAngle()).mag;
    //    vel.dir = input.proj(barrier.getAngle()).dir + 2 * input.rej(barrier.getAngle()).dir;
    //    vel.mag *= decel * velMultiplier;
    //  }
    //}
    if(!inCollision) {
      vel = input;
    }
    
    x += vel.getX();
    y += vel.getY();
  }
  
  void fireBoulder() {
    if(hasBoulder && runTimer) {
      Boulders.add(new Boulder((Corners[0][0] + Corners[1][0]) / 2, (Corners[0][1] + Corners[1][1]) / 2, vel.mag + 10, input.dir));
      hasBoulder = false;
      lastBoulderTime = millis();
    }
  }
  
  boolean isColliding(Barrier barrier) {
    return barrier.isColliding(RobotEdges[0]) || barrier.isColliding(RobotEdges[1]) || barrier.isColliding(RobotEdges[2]) || barrier.isColliding(RobotEdges[3]);
  }
}