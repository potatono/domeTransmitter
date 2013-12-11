class Chase extends Routine {
  void draw() {
    background(0);

    long frame = frameCount - modeFrameStart;
    
    stroke(red(primaryColor)*0.5,green(primaryColor)*0.5,blue(primaryColor)*0.5);
    line(frame/3.0%displayWidth, 0, frame/3.0%displayWidth, displayHeight);
    stroke(red(primaryColor)*0.6,green(primaryColor)*0.6,blue(primaryColor)*0.6);
    line((frame/3.0+1)%displayWidth, 0, ((frame/3.0+1))%displayWidth, displayHeight);
    stroke(red(primaryColor)*0.7,green(primaryColor)*0.7,blue(primaryColor)*0.7);
    line((frame/3.0+2)%displayWidth, 0, ((frame/3.0+2))%displayWidth, displayHeight);
    stroke(red(primaryColor)*0.8,green(primaryColor)*0.8,blue(primaryColor)*0.8);
    line((frame/3.0+3)%displayWidth, 0, ((frame/3.0+3))%displayWidth, displayHeight);
    stroke(primaryColor);
    line((frame/3.0+4)%displayWidth, 0, ((frame/3.0+4))%displayWidth, displayHeight);

    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

