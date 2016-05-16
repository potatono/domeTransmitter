public class D15TestPattern extends Routine {
  float a=-1;
  float b=32;
  float c=-1;
  
  void draw() {
    draw.background(0);
    draw.stroke(255);
    draw.strokeWeight(1);

    a++;
    a = a % 32;    
    b -= 0.5;
    b = b % 32;
    c += 0.25;
    c = c % 32;
      
    for (int i=(int)a; i<Config.HEIGHT; i+=32)
      draw.line(0,i,Config.WIDTH,i);
      
    draw.stroke(127);
    
    for (int i=(int)b; i<Config.HEIGHT; i+=32)
      draw.line(0,i,Config.WIDTH,i);

    draw.stroke(64);
    
    for (int i=(int)c; i<Config.HEIGHT; i+=32)
      draw.line(0,i,Config.WIDTH,i);
      
  }
}


