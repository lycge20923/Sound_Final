import oscP5.*;
import netP5.*;

OscP5 oscp5;

void oscEvent(OscMessage myOscMessage) {
  if(myOscMessage.checkAddrPattern("/duck") == true) {
    int value = myOscMessage.get(0).intValue();
    if(value == 1) {
      heart.HeartChange(State.red);
    }
    else if(value == 2) {
      heart.HeartChange(State.blue);
    }
  }
  if(myOscMessage.checkAddrPattern("/bone") == true) {

  }
}


Heart heart; // Heart 物件 (控制 redHeart)
Bones bone; // 宣告一個Bones物件
enum State {
  red, blue
}

float[] rectPosition;

boolean leftKeyPressed = false;
boolean rightKeyPressed = false;
boolean upKeyPressed = false;
boolean downKeyPressed = false;

void setup() {
  oscp5 = new OscP5(this, 9999);
  // 背景
  size(600, 500);
  background(0);
  
  // 白框位址、大小 [左上x, 左上y, 寬, 高]
  rectPosition = new float[]{100, 100, width-200, height-200};
  heart = new Heart();
  bone = new Bones();
  bone.setup();
}

static int i = 0;

void draw() {
  background(0);
  bone.draw(i);
  heart.draw();
  if(i % 60 == 0) heart.createPlatform(rectPosition[0] + rectPosition[2], rectPosition[1] + rectPosition[3] - 100, -2, 50);
  if(i % 60 == 0) heart.createPlatform(rectPosition[0] - 50, rectPosition[1] + rectPosition[3] - 200, 2, 50);
  i++;
  
  // 白框(設定填充色為透明，邊框色為白色)
  fill(color(255, 255, 255, 0));
  stroke(255);
  strokeWeight(5); // 邊框粗細
  // 繪製一個矩形，左上角座標為 (0, 1)，寬度為 2，高度為 3
  rect(rectPosition[0], rectPosition[1], rectPosition[2], rectPosition[3]);
}

void keyPressed() {
  if (keyCode == LEFT) {
    leftKeyPressed = true;
  }else if (keyCode == RIGHT) {
    rightKeyPressed = true;
  }else if (keyCode == UP) {
    upKeyPressed = true;
  }else if (keyCode == DOWN) {
    downKeyPressed = true;
  }else {
    if(key == 'r') {
      heart.HeartChange(State.red);
    }
    if(key == 'b') {
      heart.HeartChange(State.blue);    
    }
    int time = 10;
    // press 1~9
    heart.move(int(key) - '0', time);
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    leftKeyPressed = false;
  }else if (keyCode == RIGHT) {
    rightKeyPressed = false;
  }else if (keyCode == UP) {
    upKeyPressed = false;
  }else if (keyCode == DOWN) {
    downKeyPressed = false;
  }
}

class Heart {
  float heartSize = 20;
  float heartX;
  float heartY;
  float speed = 3;
  
  // 紅心
  // 當前移動方向與時間
  int direction;
  int time;
  
  // 藍心
  // 重力大小, 跳躍初速度
  boolean jumping = true;
  float gravity = 0.4;
  float initial_velocity = -9;
  float velocity = 0;
  float pre_heartY;

  Platform platform;
  
  // 邊界判斷 [x_min, x_max, y_min, y_max]
  float[] boundary = new float[4];
  
  PImage redHeart;
  PImage blueHeart;
  PImage currHeart;
  State state = State.red;
  
  Heart() {
    this.heartX = 100 + (width-200) / 2;
    this.heartY = 100 + (height-200) / 2;
    
    //redHeart = loadImage("https://upload.wikimedia.org/wikipedia/commons/a/a5/Undertale.png");
    this.redHeart = loadImage("./images/red_heart.png");
    this.redHeart.resize(int(this.heartSize), 0);
    
    this.blueHeart = loadImage("./images/blue_heart.png");
    this.blueHeart.resize(int(this.heartSize), 0);
    this.pre_heartY = this.heartY;
    
    this.currHeart = this.redHeart;
    
    this.boundary = new float[]{rectPosition[0] + this.heartSize / 2 + 3,
                                rectPosition[0] + rectPosition[2] - this.heartSize / 2 - 2,
                                rectPosition[1] + this.heartSize / 2 + 3,
                                rectPosition[1] + rectPosition[3] - this.heartSize / 2 - 2};
    this.platform = new Platform(new float[]{rectPosition[0], rectPosition[0] + rectPosition[2], rectPosition[1], rectPosition[1] + rectPosition[3]});
  }

  // 邊界檢查
  void boundaryCheck() {
    if (this.heartX < this.boundary[0]) {
      this.heartX = this.boundary[0];
    }
    if (this.heartX > this.boundary[1]) {
      this.heartX = this.boundary[1];
    }
    if (this.heartY < this.boundary[2]) {
      this.heartY = this.boundary[2];
      this.velocity = 0;
    }
    if (this.heartY > this.boundary[3]) {
      this.heartY = this.boundary[3];
    }
  }


  // 紅心移動 ----------------------------------------------
  // 設定移動方向與時間
  // 依照數字鍵方向
  // 7 8 9 ↖ ↑ ↗
  // 4 5 6 ←   →
  // 1 2 3 ↙ ↓ ↘
  void move(int dir, int t) {
    this.direction = dir;
    this.time = t;
  }

  // 根據當前設定的方向與時間移動
  void heartMoving() {
    if (this.time <= 0) return;
    this.time -= 1;

    if (this.direction == 1 || this.direction == 4 || this.direction == 7) {
      this.heartX -= this.speed;
    }
    if (this.direction == 3 || this.direction == 6 || this.direction == 9) {
      this.heartX += this.speed;
    }
    if (this.direction == 7 || this.direction == 8 || this.direction == 9) {
      this.heartY -= this.speed;
    }
    if (this.direction == 1 || this.direction == 2 || this.direction == 3) {
      this.heartY += this.speed;
    }
  }

  // 手動移動
  void manualMoving() {
    if (leftKeyPressed) {
      this.heartX -= this.speed;
    }
    if (rightKeyPressed) {
      this.heartX += this.speed;
    }
    if (upKeyPressed) {
      this.heartY -= this.speed;
    }
    if (downKeyPressed) {
      this.heartY += this.speed;
    }
  }
  // 紅心移動 ----------------------------------------------

  // 藍心移動 ----------------------------------------------
  void GravityWorking() {
    if (this.heartY < this.boundary[3]) {
      this.heartY += this.velocity;
      this.velocity += this.gravity;
    }
    else {
      this.velocity = 0;
      this.jumping = false;
    }
    
  }
  
  void manualJumping() {
    if (leftKeyPressed) {
      this.heartX -= this.speed;
    }
    if (rightKeyPressed) {
      this.heartX += this.speed;
    }
    if (upKeyPressed) {
      if(this.jumping == false){
        this.heartY -= 1;
        this.jumping = true;
        this.velocity = this.initial_velocity;
      }
    }
    else {
      if(this.jumping == true && this.velocity < -1.5) {
        this.velocity = -1.5;
      }
    }
    if (downKeyPressed) {
      this.heartY += this.speed;
    }
  }
  // 藍心移動 ----------------------------------------------
  
  // 愛心切換
  void HeartChange(State s) {
    this.state = s;
    if (this.state == State.red){
      println("Change heart to Red");
      this.currHeart = this.redHeart;
    } else if (this.state == State.blue) {
      println("Change heart to Blue");
      this.currHeart = this.blueHeart;
      this.velocity = 0;
    }
  }
  void HeartBehavior() {
    if (this.state == State.red){
      manualMoving();
      heartMoving();
    } else if (this.state == State.blue) {
      this.pre_heartY = this.heartY;
      GravityWorking();
      manualJumping();
    }
  }

  void createPlatform(float plat_x, float plat_y, float plat_speed, float plat_width){
    platform.create(plat_x, plat_y, plat_speed, plat_width);
  }

  // 繪製愛心
  void draw() {
    platform.draw(this);
    imageMode(CENTER);
    image(this.currHeart, this.heartX, this.heartY);
    HeartBehavior();
    boundaryCheck();
  }
}
