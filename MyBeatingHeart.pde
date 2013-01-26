class MyBeatingHeart extends Routine {

  private static final int BASE_VELOCITY = 5;
  private static final int HIGH_VELOCITY = 20;
  private static final int LINE_VELOCITY = 2;
  private static final int INTERVAL = 8;
  private static final int LOWER_LIMIT = 0;
  private static final int UPPER_LIMIT = 255;
  private static final long LOVE_GLOW_DURATION = 10 * 1000L; // 10 seconds
  private static final int HEARTBEAT_STATE = 0;
  private static final int LOVE_GLOW_STATE = 1;
  private static final int END_STATE = 2;
  private static final int REPEAT_LIMIT = 3;

  int r,g,b,count = 0;
  int y;
  int velocity = 40;
  boolean inhale = true;
  int beatCount = 0;
  int state = HEARTBEAT_STATE;
  int step;
  long ticktock;
  int repeatCount = 0;

  void setup(PApplet parent) {
    super.setup(parent);
  }

  void draw() {
    switch (state) {
      case HEARTBEAT_STATE:
        background(r,g,b);
        if (inhale) {
          r += velocity;
          if (r >= UPPER_LIMIT) {
            r = UPPER_LIMIT;
            inhale = false;
          }
        } else {
          r -= velocity;
          if (r <= LOWER_LIMIT) {
            r = LOWER_LIMIT;
            inhale = true;
            count++;
          }
        }
        if (count == 2) {
          beatCount++;
          count = 0;
          if (beatCount < INTERVAL) {
            try { Thread.sleep(500); } catch (InterruptedException e) { /* ignored */ }
          } else {
            // enter groovy glowy love mode
            state = LOVE_GLOW_STATE;
            ticktock = System.currentTimeMillis();
          }
        }
        break;
      case LOVE_GLOW_STATE:
        // turn pink
        background(255, 192, 203);
        strokeWeight(8);
        stroke(255, 0, 0);
        for (int i = 0; i < height / 14; i++) {
          line(0, i * 14 + step, width, i * 14 + step);
        }
        step++;
        if (step>13) step=0;

        if (System.currentTimeMillis() - ticktock > LOVE_GLOW_DURATION) {
          state = HEARTBEAT_STATE;
          count = 0;
          beatCount = 0;
          repeatCount++;
          if (repeatCount > REPEAT_LIMIT) {
            state = END_STATE;
          }
        }
        break;
      case END_STATE:
        newMode();
      default:
        break;
    }
  }

} // class MyBeatingHeart
