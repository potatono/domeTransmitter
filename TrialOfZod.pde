class TrialOfZod extends Routine {
  float arcHeight = height/4;
  float n = 0;
  float s = 0.5;
  float top;
  
  void draw() {
    background(0);
    stroke(primaryColor);
    fill(0);
    strokeWeight(3);
    //arc(width/2,height-50,(float)width+20,50,-PI,0);
    //line(0,height-25,width,height-25);
    top = 85 + controller.pitch/2;
    
    n = n + s;
    if (abs(n)>width) {
      n = 0;
    }

    line(-width+n,   top-45,      -width/2+n,       top+45);
    line(-width/2+n, top+45,      n,                top-45);
    line(n,          top-45,      width/2+n,        top+45);
    line(width/2+n,  top+45,      width+n,          top-45);
    line(width+n,    top-45,      width+width/2+n,  top+45);


    line(-width+n,   top+45,      -width/2+n,       top-45);
    line(-width/2+n, top-45,      n,                top+45);
    line(n,          top+45,      width/2+n,        top-45);
    line(width/2+n,  top-45,      width+n,          top+45);
    line(width+n,    top+45,      width+width/2+n,  top-45);

    long frame = frameCount - modeFrameStart;
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

  
}








