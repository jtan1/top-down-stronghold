class Defense extends Barrier {
  // Parameters
  private float x;
  private float y;
  private int pos;
  private int id;
  private boolean isBlue;
  private PImage imgDefense;
  
  // Internal Usage
  private int health = 2;
  private int crossingStage = 0;
  private boolean touchingFront = false;
  private boolean touchingBack = false;
  
  Defense(float x_, float y_, int pos_, int id_, boolean isBlue_) {
    super(x_ - 100, y_, x_ + 100, y_, false);
    x = x_;
    y = y_;
    pos = pos_;
    id = id_;
    isBlue = isBlue_;
    switch(id) {
    case 0:
      imgDefense = imgPortcullis;
      break;
    case 1:
      imgDefense = imgCheval;
      break;
    case 2:
      imgDefense = imgMoat;
      break;
    case 3:
      imgDefense = imgRamparts;
      break;
    case 4:
      imgDefense = imgSallyPort;
      break;
    case 5:
      imgDefense = imgDrawbridge;
      break;
    case 6:
      imgDefense = imgRoughTerrain;
      break;
    case 7:
      imgDefense = imgRockWall;
      break;
    case 8:
      if(isBlue) {
        imgDefense = imgLowBarB;
      }
      else {
        imgDefense = imgLowBarR;
      }
      break;
    }
  }
  
  void display() {
    imageMode(CENTER);
    image(imgDefense, x, y);
    if(health == 2) {
      if(isBlue) {
        image(imgBFullLight, x, y);
      }
      else {
        image(imgRFullLight, x, y);
      }
    }
    else if(health == 1) {
      if(isBlue) {
        image(imgBDamagedLight, x, y);
      }
      else {
        image(imgRDamagedLight, x, y);
      }
    }
    else {
      image(imgDeadLight, x, y);
    }
  }
}