class TestCrawl extends Routine
{
  int y=0;
  long next=0;

  void draw() {
    if (next < millis()) {
      next = millis() + 5;

      y++;
      if (y>height) 
        y=0;
    }

    background(0);
    colorMode(RGB);
    stroke(color(255,255,255));
    line(0,y,width,y);
  }
}
