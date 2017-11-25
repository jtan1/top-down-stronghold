class Boulder {
  // Parameters
  private float x;
  private float y;
  
  // Constants
  float decel = 0.97;
  
  // Internal Usage
  private Vector vel = new Vector(0, 0);
  
  Boulder(float x_, float y_, float speed_, float angle_) {
    x = x_;
    y = y_;
    vel.mag = speed_;
    vel.dir = angle_;
  }

  void display() {
    vel.mag *= decel;
    x += vel.getX();
    y += vel.getY();
    fill(127);
    ellipse(x, y, 25, 25);
  }
  
  boolean isColliding(float pointX, float pointY, float radius) {
    return pow(x - pointX, 2) + pow(y - pointY, 2) < pow(radius, 2);
  }
  
  boolean isColliding(Robot robot) {
    return isColliding((robot.Corners[0][0] + robot.Corners[1][0]) / 2, (robot.Corners[0][1] + robot.Corners[1][1]) / 2, 20) && (millis() - robot.lastBoulderTime) > 500;
  }
  
  boolean isColliding(Barrier barrier) {
    if(abs(barrier.distFrom(x, y)) < pow(barrier.x2 - barrier.x1, 2) + pow(barrier.y2 - barrier.y1, 2)) {
      return pow((barrier.y2 - barrier.y1) * (x - barrier.x1) - (barrier.x2 - barrier.x1) * (y - barrier.y1), 2) < 156.25 * (pow(barrier.x2 - barrier.x1, 2) + pow(barrier.y2 - barrier.y1, 2));
    }
    else
    {
      //return isColliding(barrier.x1, barrier.y1, 25) || isColliding(barrier.x2, barrier.y2, 25);
      return false;
    }
  }
  
  void performCollision(float barrierAngle) {
    vel.dir = (2 * barrierAngle - vel.dir) % 360;
    vel.mag *= 0.75;
  }
}