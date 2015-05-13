class ShootingStars extends Routine {
  int NUM_STARS = 100;
  Star[] stars;
  
  void setup(PApplet parent) {
    super.setup(parent);
    stars = new Star[NUM_STARS];
    for (int i = 0; i < NUM_STARS; i++) {
      stars[i] = new Star();
    }
  }


  void draw() {
    draw.background(0,0,20);
    for (int i = 0; i < NUM_STARS; i++) {
      stars[i].draw();
    }
    
    if (frameCount - modeFrameStart > Config.FRAMERATE * Config.MODE_TIMEOUT) {
      newMode();
    }

  }

  class Star {
    
    int starsize = 20;
    float x;
    float y;
    float yv;
    // track the last x value we generated so we don't get multiple stars on the same strip
    float lastx;
    float speed;
    float r;
    float g;
    float b;
    color c;
    
    public Star() {
      init();
    }

    public void reset() {
      r = random(255);
      g = random(255);
      b = random(255);
      c = color(r,g,b);
      lastx = x;
      x = random(Config.WIDTH);
      // They all start at the top, should be negative?
      y = 0;
      float max_speed = 6;
      float min_speed = 2;
      yv = random(max_speed);
      if (yv < min_speed) {
        yv = min_speed;
      }
    }

    public void init() {
      reset();
    }
    
    public void draw() {
      draw.fill(c);
      draw.stroke(c);
      for (int i = 0; i < starsize; i++) {
        //draw.stroke(color(r - (i * starsize), g - (i * starsize), b - (i * starsize)));
        draw.line(x, y, x, y - i);
      }
      y += yv;
      if (y > Config.HEIGHT + starsize) {
        reset();
      }

      long frame = frameCount - modeFrameStart;
      if (frame >Config.FRAMERATE*Config.MODE_TIMEOUT) {
        newMode();
      }
    }

  } // class Star

} // class ShootingStars
