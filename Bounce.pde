class Bounce extends Routine {
  int n = 100;
  int[] x;
  float[] y;
  float[] s;

  void setup(PApplet parent) {
    super.setup(parent);
    x = new int[n];
    y = new float[n];
    s = new float[n];
    
    for (int i=0; i<n; i++) {
      x[i] = int(random(0,width));
      y[i] = random(0,height);
      s[i] = random(0.5,2.5);
    }
  }
  
  void draw() {
    background(0);
    
    for (int i=0; i<n; i++) {
      color c = colorPicker.primaryColor;

      y[i] += s[i] + (s[i]*controller.pitch/-135) + (s[i]*y[i]/height*2);
      if (y[i]<0 || y[i]>height) {
        s[i] = -s[i];
        if (y[i]<0)
          x[i] = (x[i]+width/2) % width;
      }
            
      for (int j=0; j<5; j++) {
        stroke(c);
        point(x[i],int(y[i] + (s[i]<0 ? j : -j)));
        c = colorPicker.dim(c);
      } 
    }
    
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    } 

  }
}
