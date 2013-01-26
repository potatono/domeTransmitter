class ColorPicker {
  color[] palette = new color[] {
    color(255,255,255),
    color(255,64,64),
    color(64,255,255),
    color(64,64,255),
    color(64,255,64),
    color(255,255,64),
    color(255,64,255)
  };
  
  float dimRatio = 0.85;
  int primary=0;
  int secondary=1;
  color primaryColor = palette[primary];
  color secondaryColor = color(255*dimRatio,64*dimRatio,64*dimRatio);
  boolean wasButtonUp = false;
  boolean wasButtonDown = false;
  boolean wasButtonLeft = false;
  boolean wasButtonRight = false;

  color dim(color c) {
    return color(red(c)*dimRatio,green(c)*dimRatio,blue(c)*dimRatio);
  }
  
  void forceGray() {
    primaryColor = color(128);
    secondaryColor = color(0);
  }
  
  void update() {
    if (controller.buttonUp) wasButtonUp = true;
    else if (wasButtonUp) {
      wasButtonUp = false;
      primary -= 1;
      if (primary<0) primary=palette.length-1;
      primaryColor = palette[primary];
    }
    else if (controller.buttonDown) wasButtonDown = true;
    else if (wasButtonDown) {
      wasButtonDown = false;
      primary+=1;
      if (primary>=palette.length) primary=0;
      primaryColor = palette[primary];
    }
    
    if (controller.buttonLeft) wasButtonLeft = true;
    else if (wasButtonLeft) {
      wasButtonLeft = false;
      secondary -= 1;
      if (secondary<0) secondary=palette.length-1;
      secondaryColor = dim(palette[secondary]);

    }
    else if (controller.buttonRight) wasButtonRight = true;
    else if (wasButtonRight) {
      wasButtonRight = false;
      secondary += 1;
      if (secondary>=palette.length) secondary=0;
      secondaryColor = dim(palette[secondary]);
    }
  }
}
