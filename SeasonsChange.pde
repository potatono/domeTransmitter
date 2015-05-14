/*
The dome is dark, and light green colors start to creep up the dome, 
turning darker green and yellows, blues, purples start appearing.
They hit the top and start decaying into yellows, reds, and browns.
White pixels begin to fall from the top of the dome, filling
the strips until it's full, then fade to off. Repeat.
*/

class SeasonsChange extends Routine {

  private static final int SPRING = 1;
  private static final int SUMMER = 2;
  private static final int FALL = 3;
  private static final int WINTER = 4;
  private static final int DONE = 5;

  private static final long SPRING_DELAY = 25; // ms

  int mode;
  int springGrowthPoint;

  void setup(PApplet parent) {
    super.setup(parent);
    reset();
  }

  void reset() {
    mode = SPRING;
    springGrowthPoint = Config.HEIGHT;
  }

  void draw() {
    switch (mode) {
      case SPRING:
        draw.stroke(color(0,255,127));
        draw.fill(color(0,255,127));
        draw.rect(0, springGrowthPoint, Config.WIDTH, Config.HEIGHT);
        springGrowthPoint--;
        if (springGrowthPoint <= 0) {
          mode = SUMMER;
        } else {
          try { Thread.sleep(SPRING_DELAY); } catch (Exception e) { /* ignored */ }
        }
        break;
      case SUMMER:
        mode = FALL;
        break;
      case FALL:
        mode = WINTER;
        break;
      case WINTER:
        mode = DONE;
        break;
      default:
        draw.background(0,0,20);
        reset();
        if (frameCount - modeFrameStart > Config.FRAMERATE * Config.MODE_TIMEOUT) {
          newMode();
        }
        break;
    }
  }

} // class SeasonsChange

