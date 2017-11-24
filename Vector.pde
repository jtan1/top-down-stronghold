class Vector {
  // Parameters
  private float mag;
  private float dir;
  
  // Derived
  private float dx;
  private float dy;
  
  Vector(float magnitude_, float direction_) {
    this.setVal(magnitude_, direction_);
  }
  
  float getX() {
    dx = mag * cos(radians(dir));
    return dx;
  }
  
  float getY() {
    dy = mag * sin(radians(dir));
    return dy;
  }
  
  float dotP(Vector v) {
    return dx * v.dx + dy * v.dy;
  }
  
  // returns parallel component of this vector with respect to angle
  Vector proj(float angle) {
    return new Vector(mag * cos(radians(dir - angle)), angle);
  }
  
  // returns perpendicular component of this vector with respect to angle
  Vector rej(float angle) {
    return new Vector(mag * sin(radians(dir - angle)), angle - 90);
  }
  
  void setVal(float magnitude_, float direction_) {
    mag = magnitude_;
    dir = direction_;
    this.getX();
    this.getY();
  }
}