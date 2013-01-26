class Swirl extends Routine {
  float x=0;
  float y=0;
  float yo=0;
  int weight = 5;

  public Swirl() {
    yo=random(0.3,0.7);
    if (random(0,1)<0.5) yo=-yo;
  }
  
  public Swirl(float speed) {
    yo = speed;
  }
  
  public Swirl(float speed, int weight) {
    this.yo = speed;
    this.weight = weight;
  }

  void draw() {
    background(0);
    strokeWeight(this.weight);
    
    for (x=-width; x<width*2; x+=this.weight) {
      stroke((x % 2 == 0) ? colorPicker.primaryColor : colorPicker.secondaryColor);
      line(x-y,0,x+width-y,height);
    }      
    
    y+=yo + (yo*controller.pitch/-45);
    if (y>weight*2) y-=weight*2;
    else if (y<0) y+=weight*2;
    
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    } 
  }
}

