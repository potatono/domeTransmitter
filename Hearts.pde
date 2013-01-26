class Hearts extends Routine {
  float ofs = 0;
  int[] heart = new int[] { 85,100,110,115,120,115,100,115,120,115,110,100,85 };
  
  void setup(PApplet setup) {
    ofs = width/4;
  }
  
  void draw() {
    background(0);
    stroke(255,255,255,192);
    drawHeart((int)ofs);
    stroke(255,64,64,192);
    drawHeart((int)ofs*-1);

    stroke(255,255,255,192);
    drawHeart(((int)ofs+width/2));
    stroke(255,64,64,192);
    drawHeart(((int)ofs*-1+width/2));

    ofs+=0.5;
    
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    } 
  }
  
  void drawHeart(int ofs) {
    int x = ofs;
    for (int i=0; i<heart.length; i++) {
      x++;
      while (x > width) x = x-width;
      while (x < 0) x = x+width;
      line(x,0,x,heart[i]*(0.25+abs(sin(ofs/20.0))));
    }
  }
}

