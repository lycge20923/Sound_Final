import java.util.Queue;
import java.util.ArrayDeque;

class Obstacles {
  // ArrayList<obs> obstacles = new ArrayList<obs>();
  ArrayList<customBone> customBones = new ArrayList<customBone>();
  Queue<Integer> freq = new ArrayDeque<Integer>();

  public float[] boundary;
  PImage blueBone, whiteBone, whiteBoneTall;
  int next = 0, randint = int(random(50, 150)), count = 8;

  Obstacles(float[] boundary) {
    this.boundary = boundary;

    this.whiteBoneTall = loadImage("./images/bone_white_tall.png");
    this.whiteBone = loadImage("./images/bone_white.png");

    // this.whiteBone.resize(0, 30);

    // blue bone color: #54cdf0, (84,205,240)
    this.blueBone = loadImage("./images/bone_blue.png");
    // this.blueBone.resize(0, 30);
  }

  void create(float h, int mode) {
    // obstacles.add(new obs(bone, w, h));
    customBones.add(new customBone(h, mode));
  }

  void getFreq(int f) {
    this.freq.add(f);
  }

  void draw() {
    ArrayList<Integer> toRemove = new ArrayList<Integer>();
    this.next += 1;
    // this.create(this.whiteBoneTall, this.whiteBoneTall.width, freq, 1);
    
    // random bone height
    // if (this.next % 5 == 0) {
    //   int boneHeight = this.freq.size() == 0 ? 60 : this.freq.poll();
    //   // println(freq);
    //   this.create(boneHeight, 1);
      
    //   this.next = 0;
    //   // this.randint = int(random(40, width / 5));
    //   // this.count += 1;
    // }
    
    for (int i = customBones.size() - 1; i >=0 ; i--) {
      customBone o = customBones.get(i);
      if (o.xleft > width || o.xright < 0) {
        toRemove.add(i);
      }
      o.move();
      o.show(boundary, i);
      // println(o.h);
    }
    // println(this.customBones.size());
    // remove exceed boundary obstacles
    for(int idx : toRemove) {
      this.customBones.remove(idx);
    }
  }
}

class customBone {
  float xleft, xright, y, w, h, upy;
  float speed = 3;
  int mode;
  PImage boneWhiteBot, boneWhiteTop, boneBlueBot, boneBlueTop;
  
  // 建構子

  public customBone(float h, int mode) {
    this.boneWhiteBot = loadImage("./images/bone_white_bottom.png");
    this.boneWhiteTop = loadImage("./images/bone_white_top.png");
    this.boneBlueBot = loadImage("./images/bone_blue_bottom.png");
    this.boneBlueTop = loadImage("./images/bone_blue_top.png");

    this.mode = mode;
    this.w = 6;
    this.h = h;
    this.xleft = 0;
    this.xright = width;
    this.y = height - 100 - this.h / 2 - this.boneWhiteBot.height / 2;
    this.upy = 100 + this.h / 2 + this.boneWhiteTop.height / 2;
  }

  // 移動
  void move() {
    this.xright -= this.speed;
  }

  // 顯示
  void show(float[] boundary, int i) {
    // mode 1 : white, mode 2 : blue
    float bonePos = (this.xright > width - 10) ? this.y + this.h / 2 : this.y;
    rectMode(CENTER);

    if (this.mode == 1){
      fill(color(255, 255, 255));
      rect(this.xright, bonePos, 6, this.h);
      image(this.boneWhiteBot, this.xright, bonePos + this.h / 2);
      image(this.boneWhiteTop, this.xright, bonePos - this.h / 2);

      // float reverseH = (150 - this.h);
      // this.upy = 100 + reverseH / 2 + this.boneWhiteTop.height / 2;
      // fill(color(255, 255, 255));
      // rect(this.xright, this.upy, 6, reverseH);
      // image(this.boneWhiteBot, this.xright, this.upy + reverseH / 2);
      // image(this.boneWhiteTop, this.xright, this.upy - reverseH / 2);
    }
    else if (this.mode == 2) {
      fill(color(64, 254, 254));
      rect(this.xright, bonePos, 6, this.h);
      image(this.boneBlueBot, this.xright, bonePos + this.h / 2);
      image(this.boneBlueTop, this.xright, bonePos - this.h / 2);
    }
  }
}
