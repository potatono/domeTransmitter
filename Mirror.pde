class Mirror extends Routine {
  Routine subroutine;
  int offset;
  
  public Mirror(Routine subroutine) {
    this.subroutine = subroutine;
    this.offset = int(random(width/6,width-width/6));
  }
  
  public Mirror(Routine subroutine, int offset) {
    this.subroutine = subroutine;
    this.offset = offset;
  }
  
  void setup(PApplet parent) {
    super.setup(parent);
    
    subroutine.setup(parent);
  }
  
  void draw() {
    subroutine.draw();
    
//    mirror(offset + int((controller.roll/-90.0) * (width/2)));
    
     mirror(offset);
  }
  
  void mirror(int ofs) {
    while (ofs<0) ofs+=width;
    while (ofs>width) ofs-=width;
    int x;
    int x2=0;
    for(int i=0; i<width/2; i++) {
      x = i + ofs;
      x2 = width-i + ofs;
      while (x>=width) x=x-width;
      while (x2>=width) x2=x2-width;
      copy(x,0,1,height,x2,0,1,height);
    }
  }
}
