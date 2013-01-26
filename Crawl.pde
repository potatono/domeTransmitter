class Crawl extends Routine {
  int step=0;
  
  void draw() {
    background(0);
    stroke(255);
    
    for (int i=0; i<height/4; i++) {
      line(0,i*4+step,width,i*4+step);
    }
    
    step++;
    if (step>3) step=0;
  }
}
