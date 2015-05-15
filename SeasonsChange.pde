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
  private static final int DARKEN = 6;
  private static final int FLOWER_MAX_DIAMETER = 8;
  private static final int FLOWER_MIN_DIAMETER = 3;
  private static final int LEAF_MAX_DIAMETER = 18;
  private static final int LEAF_MIN_DIAMETER = 8;
  private static final int MAX_FLOWERS = 400;
  private static final int FALL_CYCLE = 500;

  private static final long SPRING_DELAY = 25; // ms

  color[] flowerColors = {
    color(0,255,255), // cyan
    color(255,105,180), // hot pink
    color(255,0,0), // red
    color(160,32,240), // purple
    color(255,255,0), // yellow
    color(255,165,0) // and orange, of course
  };
  color[] fallColors = {
    color(178,34,34), // dark red
    color(165,42,42), // brown
    color(255,140,0), // dark orange
    color(255,215,0) // dark yellow / gold
  };
  FallLeaf[] leaves = new FallLeaf[Config.WIDTH];
  color springGreen;
  color darkGreen;
  color snowColor;
  int mode;
  int springGrowthPoint;
  int flowerCount;
  ArrayList<Snowflake> snowflakes;
  int ySnowLimit;
  color fadeout;
  int pixelCount;
  int fallCount;

  void setup(PApplet parent) {
    super.setup(parent);
    springGreen = color(0,255,127);
    reset();
  }

  void reset() {
    mode = SPRING;
    springGrowthPoint = Config.HEIGHT;
    flowerCount = 0;
    fallCount = 0;
    snowflakes = new ArrayList<Snowflake>();
    ySnowLimit = Config.HEIGHT;
    snowColor = color(200,200,200);
    fadeout = snowColor;
    for (int i = 0; i < Config.WIDTH; i++) {
      int idx = floor(random(fallColors.length));
      leaves[i] = new FallLeaf(i, fallColors[idx]);
    }
  }

  void draw() {
    switch (mode) {
      case SPRING:
        draw.stroke(springGreen);
        draw.fill(springGreen);
        draw.rect(0, springGrowthPoint, Config.WIDTH, Config.HEIGHT);
        springGrowthPoint--;
        if (springGrowthPoint <= 0) {
          mode = SUMMER;
//          mode = DARKEN;
          darkGreen = springGreen;
        } else {
          try { Thread.sleep(SPRING_DELAY); } catch (Exception e) { /* ignored */ }
        }
        break;
      case DARKEN:
        // have to reduce g by 116 and b by 93
        float g = darkGreen >> 8 & 0xFF;
        float b = darkGreen & 0xFF;
        g -= 1.247;
        if (g <= 139) {
          g = 139;
          mode = SUMMER;
        }
        b -= 1;
        if (b <= 34) {
          b = 34;
          mode = SUMMER;
        }
        darkGreen = color(0,g,b);
        draw.fill(darkGreen);
        draw.stroke(darkGreen);
        draw.rect(0,0,Config.WIDTH,Config.HEIGHT);
        break;
      case SUMMER:
        // draw bursts of color over the green
        float d = random(FLOWER_MAX_DIAMETER);
        if (d < FLOWER_MIN_DIAMETER) {
          d = FLOWER_MIN_DIAMETER;
        }
        int idx = floor(random(flowerColors.length));
        int x = floor(random(Config.WIDTH));
        int y = floor(random(Config.HEIGHT));
        draw.stroke(flowerColors[idx]);
        draw.fill(flowerColors[idx]);
        draw.ellipse(x, y, d, d);
        flowerCount++;
        if (flowerCount >= MAX_FLOWERS) {
          flowerCount = 0;
          mode = FALL;
        }
        break;
      case FALL:
        boolean fallDone = false;
        int startedCount = 0;
        for (int i = 0; i < leaves.length; i++) {
          if (!leaves[i].started) {
            leaves[i].draw();
            break;
          } else {
            startedCount++;
          }
        }
        for (int i = 0; i < startedCount; i++) {
          if (leaves[i].started) {
            leaves[i].draw();
          }
        }
        fallCount++;
        if (fallCount >= FALL_CYCLE) {
          mode = WINTER;
        }
        break;
      case WINTER:
        // snowflakes fall from the top of the dome and fill the strips
        for (int i = 0; i < Config.WIDTH; i++) {
          Snowflake flake = new Snowflake(ySnowLimit, snowColor);
          snowflakes.add(flake);
          flake.draw();
        }
        boolean foundDone = false;
        for (int i = 0; i < snowflakes.size(); i++) {
          Snowflake flake = snowflakes.get(i);
          flake.draw();
          if (flake.done) {
            foundDone = true;
            snowflakes.remove(i);
          }
        }
        draw.fill(snowColor);
        draw.stroke(snowColor);
        draw.rect(0, ySnowLimit, Config.WIDTH, Config.HEIGHT);
        if (foundDone) {
          ySnowLimit--;
        }
        if (ySnowLimit <= 0) {
          mode = DONE;
        }
        break;
      case DONE:
        // fade out
        float sr = fadeout >> 16 & 0xFF;
        float sg = fadeout >> 8 & 0xFF;
        float sb = fadeout & 0xFF;
        fadeout = color(sr-1,sg-1,sb-1);
        draw.fill(fadeout);
        draw.stroke(fadeout);
        draw.rect(0,0,Config.WIDTH, Config.HEIGHT);
        if (sb == 0) {
          reset();
          if (frameCount - modeFrameStart > Config.FRAMERATE * Config.MODE_TIMEOUT) {
            newMode();
          }
        }
        break;
    }
  } // draw method

  class FallLeaf {

    int x;
    color targetColor;
    color currentColor;
    boolean started;
    
    public FallLeaf(int x, color targetColor) {
      this.x = x;
      this.targetColor = targetColor;
      currentColor = color(0,0,0);
      started = false;
    }

    public void lighten() {
        float tr = targetColor >> 16 & 0xFF;
        float tg = targetColor >> 8 & 0xFF;
        float tb = targetColor & 0xFF;
        float cr = currentColor >> 16 & 0xFF;
        float cg = currentColor >> 8 & 0xFF;
        float cb = currentColor & 0xFF;
        if (cr < tr) {
          cr++;
        }
        if (cg < tg) {
          cg++;
        }
        if (cb < tb) {
          cb++;
        }
        currentColor = color(cr,cg,cb);
    }

    public void draw() {
      started = true;
      lighten();
      draw.stroke(currentColor);
      draw.fill(currentColor);
      draw.line(x, 0, x, Config.HEIGHT);
    }

  } // cass FallLeaf

  class Snowflake {
    float x;
    float y;
    float yv;
    float speed;
    color c;
    color blk;
    boolean done;
    int ylimit;

    public Snowflake(int ylimit, color c) {
      this.ylimit = ylimit;
      this.c = c;
      init();
    }

    public void init() {
      blk = color(0,0,0);
      x = random(Config.WIDTH);
      y = 0;
      float max_speed = 2;
      float min_speed = 1;
      yv = random(max_speed);
      if (yv < min_speed) {
        yv = min_speed;
      }
      done = false;
    }

    public void draw() {
      // clear the previous pixel
      draw.fill(blk);
      draw.stroke(blk);
      draw.point(x, y - 1);
      // draw next pixel
      draw.fill(c);
      draw.stroke(c);
      draw.point(x,y);
      y += yv;
      done = y >= ylimit;
    }

  } // class Snowflake

} // class SeasonsChange

