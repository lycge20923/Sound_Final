class Obstacles {
  ArrayList<obs> obstacles = new ArrayList<obs>();
  ArrayList<customBone> customBones = new ArrayList<customBone>();
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

  void create(PImage bone, float w, float h, int mode) {
    obstacles.add(new obs(bone, w, h));
    customBones.add(new customBone(h, mode));
  }

  void draw(int num) {
    ArrayList<Integer> toRemove = new ArrayList<Integer>();
    this.next += 1;
    if (num % 60 == 0) this.create(this.whiteBoneTall, this.whiteBoneTall.width, 60, 1);
    


    
    // random bone height
    // if (this.next % 5 == 0) {
    //   int rand = round(random(1,2));
    //   int coef = abs(count % 16 - 8) + 1;

    //   if (rand == 1) { // white
    //     this.create(this.whiteBone, this.whiteBone.width, 15 * coef, 1);
    //   }
    //   else { // blue
    //     this.create(this.blueBone, this.blueBone.width, 60, 2);
    //   }
    //   this.next = 0;
    //   this.randint = int(random(40, width / 5));
    //   this.count += 1;
    // }
    
    for (int i = 0; i < customBones.size(); i++) {
      customBone o = customBones.get(i);
      if (o.xleft > width || o.xright < 0) {
        toRemove.add(i);
      }
      o.move();
      o.show(boundary);
    }

    // remove exceed boundary obstacles
    for(int i = toRemove.size() - 1; i >= 0; i--) {
      obstacles.remove(toRemove.get(i));
      customBones.remove(toRemove.get(i));
    }
  }
}

class obs {
  float xleft, xright, y, w, h;
  float speed = 3;
  PImage bone;
  
  // 建構子

  public obs(PImage bone, float w, float h) {
    this.bone = bone;
    this.w = w;
    this.h = h;
    this.xleft = 0;
    this.xright = width;
    this.y = height - 100 - this.h / 2;
  }

  // 移動
  void move() {
    // xleft += speed;
    this.xright -= this.speed;
  }

  // 顯示
  void show(float[] boundary) {
    image(this.bone, this.xright, this.y, this.w, this.h);
    float upperH = abs(this.bone.height * 8 * 0.15 - this.h);
    image(this.bone, this.xright, boundary[1] + upperH/2, this.w, upperH);
  }
}

class customBone {
  float xleft, xright, y, w, h;
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
    this.y = height - 100 - this.h / 2;
  }

  // 移動
  void move() {
    this.xright -= this.speed;
  }

  // 顯示
  void show(float[] boundary) {
    // mode 1 : white, mode 2 : blue
    if (this.mode == 1){
      fill(color(255, 255, 255));
      rect(this.xright, this.y, 6, this.h);
      rectMode(CENTER);
      image(this.boneWhiteBot, this.xright, this.y + this.h / 2);
      image(this.boneWhiteTop, this.xright, this.y - this.h / 2);
    }
    else if (this.mode == 2) {
      fill(color(84, 205, 240));
      rect(this.xright, this.y, 6, this.h);
      rectMode(CENTER);
      image(this.boneBlueBot, this.xright, this.y + this.h / 2);
      image(this.boneBlueTop, this.xright, this.y - this.h / 2);
    }
      

    // image(this.bone, this.xright, this.y, this.w, this.h);
    // float upperH = abs(this.bone.height * 8 * 0.15 - this.h);
    // image(this.bone, this.xright, boundary[1] + upperH/2, this.w, upperH);
  }
}
