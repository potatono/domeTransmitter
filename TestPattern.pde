class TestPattern extends Routine {
  int o=0;
  boolean vertical = false;
  
  public TestPattern(boolean vertical) {
    this.vertical = vertical;
  }
  
  void draw() {
    background(0);
    stroke(primaryColor);
    
    if (!vertical) {
      line(o,0,o,height);
      o++;
      if (o>width) o=0;
    }
    else {
      o++;
      o = o % 4;
      
      for (int i=o; i<height; i+=4)
        line(0,i,width,i);
    }
    
  }
}

