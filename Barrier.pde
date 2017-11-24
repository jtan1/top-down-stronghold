class Barrier {
  // Parameters
  private float x1;
  private float y1;
  private float x2;
  private float y2;
  private boolean isSolid;
  
  // Internal Usage
  float xIntersect;
  float yIntersect;
  
  Barrier(float x1_, float y1_, float x2_, float y2_, boolean isSolid_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
    isSolid = isSolid_;
  }
  
  void display() {
    stroke(127);
    if(isSolid) {
      strokeWeight(2);
    }
    else {
      strokeWeight(0);
    }
    
    line(x1, y1, x2, y2);
  }
  
  boolean isColliding(Barrier barrier) {
    if(floor(barrier.x2 - barrier.x1) == 0) {
      xIntersect = (barrier.x1 + barrier.x2) / 2;
    }
    else {
      xIntersect = (((y1 - barrier.y1) * (x2 - x1) * (barrier.x2 - barrier.x1)) + (barrier.x1 * (x2 - x1) * (barrier.y2 - barrier.y1)) - (x1 * (y2 - y1) * (barrier.x2 - barrier.x1))) / (((x2 - x1) * (barrier.y2 - barrier.y1)) - ((y2 - y1) * (barrier.x2 - barrier.x1)));
    }
    yIntersect = ((y2 - y1) * (xIntersect - x1) / (x2 - x1)) + y1;
    return((xIntersect <= max(x1, x2)) && (xIntersect >= min(x1, x2)) && (xIntersect <= max(barrier.x1, barrier.x2)) && (xIntersect >= min(barrier.x1, barrier.x2)) && (yIntersect <= max(y1, y2)) && (yIntersect >= min(y1, y2)) && (yIntersect <= max(barrier.y1, barrier.y2)) && (yIntersect >= min(barrier.y1, barrier.y2)));
  }
  
  float getAngle() {
    return degrees(atan((y2 - y1) / (x2 - x1)));
  }
}