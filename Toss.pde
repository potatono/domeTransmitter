class Toss extends Routine {
  float g;
  float ya;
  float ys;
  float y;
  
  public Toss() {
    ys=0;
    ya=0;
    y=0;
    g=10;
  }
  
  void draw() {
    ys += ya;
    ya += g;
    if (ya > g) ya = g;
    if (ys > g) ys = g;
    if (ya < -50) ya = -50;
    if (ys < -50) ys = -50;
    y += ys;
    while (y>height) y-=height;
    while (y<0) y+=height;
  
  println("ya="+ya+" ys="+ys+" y="+y);  
    background(0);
    stroke(255);
    line(0,y,width,y);

    if (controller.dacc.y < 0) {
      println(controller.dacc.y);
      ya += controller.dacc.y;
    }
  }
  
}
