class Swirl extends Routine {
  float x=0;
  float y=0;
  float yo=0;

  public Swirl() {
    yo=random(0.3,0.7);
    if (random(0,1)<0.5) yo=-yo;
  }
  
  public Swirl(float speed) {
    yo = speed;
  }

  void draw() {
    background(0);
    strokeWeight(5);
    
    for (x=-width; x<width+15; x+=5) {
      stroke((x % 2 == 0) ? colorPicker.primaryColor : colorPicker.secondaryColor);
      line(x-y,0,x+width-y,height);
    }      
    
    y+=yo + (yo*controller.pitch/-45);
    if (y>10) y-=10;
    else if (y<0) y+=10;
  }
}

