class Chase extends Routine {
  float speed = 5;
  int intensity;
  
  void draw() {
    background(0);
  
    long frame = frameCount - modeFrameStart;

    for (int i=0; i<10; i++) {
      stroke(255 - (10-i)*25,128 - (5*i),128 - (5*i));
      line((frame/speed+i)%width, 0, (frame/speed+i)%width, height);
    }
   // line((frame/speed+1)%width, 0, ((frame/speed+1))%width, height);
   // line((frame/speed+2)%width, 0, ((frame/speed+2))%width, height);
   // line((frame/speed+3)%width, 0, ((frame/speed+3))%width, height);
  
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}
