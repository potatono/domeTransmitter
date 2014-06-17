class TestPattern extends Routine {
  int o=0;
  boolean vertical = false;
  
  public TestPattern(boolean vertical) {
    this.vertical = vertical;
  }
  
  void draw() {
    draw.background(0);
    draw.stroke(primaryColor);
        
    if (!vertical) {
      draw.line(o,0,o,Config.HEIGHT);
      o++;
      if (o>Config.WIDTH) o=0;
    }
    else {
      o++;
      o = o % 16;
      
      for (int i=o; i<Config.HEIGHT; i+=16)
        draw.line(0,i,Config.WIDTH,i);
    }
  }
}

