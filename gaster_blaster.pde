
GasterBlasterManager gasterBlasterManager; 

final int LEFTRIGHT = 0;
final int CIRCLE = 1;
final int RANDOM = 2;
final int NONE = 3;

float[][] attack_list = {
  {600.0, -100.0, 530.0, 246.64748, 180.0, 90.0},
  {0.0, -100.0, 70.0, 170.45107, 360.0, 270.0},
  {0.0, -100.0, 70.0, 168.04109, 360.0, 270.0},
  {0.0, -100.0, 70.0, 264.4251, 360.0, 270.0},
  {0.0, -100.0, 70.0, 332.54547, 360.0, 270.0},
  {0.0, -100.0, 70.0, 172.46143, 360.0, 270.0},
  {600.0, -100.0, 530.0, 287.52856, 180.0, 90.0},
  {600.0, -100.0, 530.0, 152.75122, 180.0, 90.0},
  {0.0, -100.0, 70.0, 252.23817, 360.0, 270.0},
  {0.0, -100.0, 70.0, 176.39563, 360.0, 270.0},
  {600.0, -100.0, 530.0, 282.5943, 180.0, 90.0},
  {0.0, -100.0, 70.0, 346.11493, 360.0, 270.0},
  {0.0, -100.0, 70.0, 329.68054, 360.0, 270.0},
  {0.0, -100.0, 70.0, 222.87213, 360.0, 270.0},
  {-64.95735, 507.8604, 129.00702, 411.04153, 290.60364, 237.94615},
  {665.396, 509.70572, 478.66827, 310.20502, 296.0711, 141.52177},
  {-34.973724, 575.7523, 231.98746, 426.2893, 37.469215, 239.00131},
  {-76.89641, -42.323906, 399.3092, 103.05226, 200.1007, 25.136526},
  {-93.22852, -1.6505778, 509.5601, 187.6665, 254.10135, 38.121304},
  {-59.333683, -47.057228, 484.486, 310.06207, 70.19727, 147.33058},
  {-91.61587, -53.107338, 66.39302, 255.83612, 95.6227, 245.56247},
  {680.05786, 508.24347, 347.22418, 78.51898, 82.79144, 63.38426},
  {601.0461, 595.1763, 111.57547, 116.42059, 260.84357, 317.4829},
  {619.95264, 597.5397, 523.243, 220.81622, 245.05463, 59.663136},
  {-25.806868, 552.9646, 64.823685, 273.31616, 206.93024, 226.18031},
  {608.3245, -4.5911074, 543.47876, 176.35643, 3.5909843, 42.897076},
  {650.5311, 520.316, 85.65918, 280.19098, 357.61826, 234.55215},
  {677.96106, -80.3913, 137.53534, 202.66833, 340.19626, 317.9983},
  {625.3486, -95.737854, 127.66275, 84.9492, 355.63855, 298.6},
  {608.6354, 569.33167, 303.93237, 41.384247, 152.01126, 44.63984},
  {-5.506426, -83.52254, 120.55286, 223.97797, 267.61368, 309.0921},
  {-28.7085, -56.397606, 459.40018, 455.76373, 209.7928, 132.9672},
  {-68.93364, -55.14611, 116.342285, 257.59784, 343.2328, 246.7785},
  {-26.370716, -45.42707, 526.4461, 48.146088, 318.10922, 53.330334},
  {-80.99426, 518.5694, 383.80914, 392.22156, 22.944088, 132.20932},
  {-60.7323, -79.49561, 87.51761, 199.53696, 192.73665, 300.35773},
  {659.5575, 533.7043, 57.853302, 292.0409, 178.5616, 234.97752},
  {662.33417, -11.507404, 136.11118, 193.31104, 55.470055, 319.16382},
  {677.91, 556.76874, 370.7023, 379.80215, 241.47481, 128.4401},
  {-92.26265, -92.78314, 144.33017, 393.6763, 247.75893, 234.61131},
  {621.2385, -1.3115227, 526.1478, 53.994995, 60.976673, 52.01383},
  {-12.8488655, -22.13949, 104.219635, 176.01967, 45.83367, 303.715},
  {-22.33138, 514.1978, 374.30313, 382.9211, 191.44763, 145.2016},
  {-10.134113, 522.13904, 203.2082, 83.4245, 183.10474, 307.37476},
  {-47.163254, -79.13231, 236.97495, 84.12024, 76.11096, 326.70343},
  {623.91003, 567.07245, 375.09076, 447.21783, 62.920696, 119.95506},
  {642.3406, -81.5728, 91.22139, 448.44843, 132.10205, 233.43033},
  {603.9435, -35.62018, 538.2617, 114.911804, 152.39426, 29.19645},
  {669.4992, -13.318568, 50.744156, 283.89966, 334.68878, 224.43427},
  {-22.31195, 576.7436, 486.21252, 170.14935, 291.26456, 50.703987},
  {692.7534, -55.389423, 351.86157, 55.417297, 322.88214, 63.452908},
  {662.33417, -11.507404, 136.11118, 193.31104, 55.470055, 319.16382},
};

int next_attack = 0;

class GasterBlasterManager {
    ArrayList<GasterBlaster> gasterBlasters = new ArrayList<GasterBlaster>();
    int attack = NONE;
    float attackAngle = 0; 
    float vectorX, vectorY;
    int attackCount = 0;
    int startTime = Integer.MAX_VALUE;
    
    void startTime(int time) {
        this.startTime = time;
        next_attack = 0;
        this.attackCount = 0;
    }
    
    void attackMode(int mode){
        attack = mode;
        if (attack == LEFTRIGHT && i-startTime > 800 && i-startTime < 1800) attackCount += 1;
        if (attack == RANDOM && i-startTime > 4600 && i-startTime < 6300) attackCount += 1;
        if (i-startTime > 6550 && i-startTime < 8000) attackCount += 1;
    }
    
    void create(float startX, float startY, float targetX, float targetY, float startAngle, float endAngle){
        GasterBlaster g = new GasterBlaster(startX, startY, targetX, targetY, startAngle, endAngle);
        this.gasterBlasters.add(g);
    }
    
    void draw() {
        //print(i-startTime);
        //print('\n');
        if(i-startTime < 100) this.attackAngle = 0;
        if (i-startTime > 800 && i-startTime < 1800 && attackCount > 0 && attack == LEFTRIGHT){
            attackCount -= 3;
            //float rand = random(1);
            //float startX = (rand < 0.5) ? 0 : width;
            //float startY = -100; // 起始 Y 坐標在畫面上方
            //float targetX = (rand < 0.5) ? 70 : width-70;
            //float targetY = random(height-120*2)+120; //random(height) + 120;
            //float startAngle = (rand < 0.5) ? 360 : 180;
            //float endAngle =  (rand < 0.5) ? 270 : 90;// random(TWO_PI);
            //print(startX + ", " + startY + ", " + targetX + ", " + targetY + ", " + startAngle + ", " + endAngle + "\n");
            // 0 [1, 0], 90 [-0, 1], 180 [-1, 0], 270[0, -1]
            this.create(attack_list[next_attack][0], attack_list[next_attack][1], attack_list[next_attack][2], attack_list[next_attack][3], attack_list[next_attack][4], attack_list[next_attack][5]);
            next_attack += 1;
            //this.create(startX, startY, targetX, targetY, startAngle, endAngle); 
        }
        else if (i-startTime > 4800 && i-startTime < 6300 && attackCount > 0 && attack == RANDOM){
            attackCount = 0;
            //float startX = (random(1) < 0.5) ? -random(100) : random(100)+width;
            //float startY = (random(1) < 0.5) ? -random(100) : random(100)+height; // 起始 Y 坐標在畫面上方
            //float targetX = random(width/3) + width/3;
            //float targetY = random(height/3) + height/3;
            
            //float decide = random(1);
            //if (decide < 0.333) {
            //    if(targetX < width/2) targetX -= width/4; else targetX += width/4;
            //}
            //else if (decide < 0.666) {
            //    if(targetY < height/2) targetY -= height/4; else targetY += height/4;
            //}
            //else {
            //  if(targetX < width/2) targetX -= width/4; else targetX += width/4;
            //  if(targetY < height/2) targetY -= height/4; else targetY += height/4;
            //}
            
            //float startAngle = random(360); // 隨機選擇起始角度
            //float endAngle = random(40) + 25;
            //if (targetX < width/2 && targetY < height/2) endAngle += 270;
            //else if (targetX >= width/2 && targetY >= height/2) endAngle += 90;
            //else if (targetX < width/2 && targetY >= height/2) endAngle += 190;
            //print(startX + ", " + startY + ", " + targetX + ", " + targetY + ", " + startAngle + ", " + endAngle + "\n");
            // 0 [1, 0], 90 [-0, 1], 180 [-1, 0], 270[0, -1]
            // this.create(startX, startY, targetX, targetY, startAngle, endAngle);
            this.create(attack_list[next_attack][0], attack_list[next_attack][1], attack_list[next_attack][2], attack_list[next_attack][3], attack_list[next_attack][4], attack_list[next_attack][5]);
            next_attack += 1;
            print(attackCount + " " + next_attack+"\n");
        }
        else if (i-startTime > 6700 && i-startTime < 8000){
            if((i-startTime) %5 == 0){
                this.attackAngle = (this.attackAngle + 10) % 360;
                this.vectorX = PVector.fromAngle(radians(this.attackAngle)).y;
                this.vectorY = PVector.fromAngle(radians(this.attackAngle)).x;
                
                float startX = width/2 + this.vectorX * 1000;
                float startY = height/2 + this.vectorY * 1000;
                float targetX = width/2 + this.vectorX * 200;
                float targetY = height/2 + this.vectorY * 200;
                float startAngle = this.attackAngle; // 隨機選擇起始角度
                float endAngle = 180 - this.attackAngle;// random(TWO_PI);
                // 0 [1, 0], 90 [-0, 1], 180 [-1, 0], 270[0, -1]
                this.create(startX, startY, targetX, targetY, startAngle, endAngle);
            }
        }
        
        ArrayList<Integer> to_be_remove = new ArrayList<Integer>();
        for(int i=this.gasterBlasters.size()-1; i>=0; i--){
            GasterBlaster g = this.gasterBlasters.get(i);
            g.update();
            g.display();
            if (g.isOut()) to_be_remove.add(i);
        }
        //for(int idx : to_be_remove){
        //    this.gasterBlasters.remove(idx);;
        //}
    }
}

// 定義 GasterBlaster 類別
class GasterBlaster {
  float x, y;            // 目前位置
  float targetX, targetY; // 目標位置
  float startX, startY;   // 起始位置
  float leaveX, leaveY;
  float vectorX, vectorY;
  float startAngle;       // 隨機起始角度
  float endAngle;       
  PImage[] images;        // 所有圖片
  int currentImageIndex = 0;
  float angle = 0;        // 旋轉角度
  float nextImageTime = 0;
  float[] imageSwitchInterval = {20, 20, 20, 20, 50, 50};
  boolean flyingIn = true; // 是否處於飛入狀態
  float scaleValue = 1;  // 縮放值
  float leaveSpeed = 0.0;
  float lazerOpacity = 255.0;
  float lazerWidth = 1;
  boolean lazerEnd = false;
  boolean Fired = false;
  
  GasterBlaster(float startX, float startY, float targetX, float targetY, float startAngle, float endAngle) {
    this.x = this.startX = startX;
    this.y = this.startY = startY;
    this.targetX = targetX;
    this.targetY = targetY;
    this.startAngle = radians(startAngle);
    this.endAngle = radians(endAngle);
    this.vectorX = PVector.fromAngle(this.endAngle).y;
    this.vectorY = PVector.fromAngle(this.endAngle).x;
    this.leaveX = targetX - this.vectorX * 100;
    this.leaveY = targetY + this.vectorY * 100;
    this.images = new PImage[6];
    for (int i = 0; i < images.length; i++) {
      images[i] = loadImage("images/spr_gasterblaster_" + i + ".png");
    }
    this.angle = startAngle; // 設定起始角度
  }
  
  void update() {
    // 如果處於飛入狀態，則移動向目標位置並旋轉
    if (flyingIn) {
      float speed = 5; // 飛入的速度
      x = lerp(x, targetX, 0.07);
      y = lerp(y, targetY, 0.07);
      angle = lerp(angle, endAngle, 0.4);
      
      // 檢查是否已經接近目標位置，如果是則切換狀態
      if (dist(x, y, targetX, targetY) < 2) {
        flyingIn = false;
        x = targetX;
        y = targetY;
        angle = endAngle; // 到達指定位置時重置角度
      }
    } else {
      if (!this.Fired || (x > -100 && y > -100) && (x < 1000 && y < 1000)){
        x = lerp(x, leaveX, -sq(this.leaveSpeed));
        y = lerp(y, leaveY, -sq(this.leaveSpeed));
      }
      float lazerStartX = x - this.vectorX * 50;
      float lazerStartY = y + this.vectorY * 50;
      float lazerEndX = x - this.vectorX * 50000;
      float lazerEndY = y + this.vectorY * 50000;
      
      if (this.lazerWidth > 0){
        stroke(255, this.lazerOpacity);
        // 設置線條的粗度（10pt）
        strokeWeight(this.lazerWidth);
        // 繪製一條線
        line(lazerStartX, lazerStartY, lazerEndX, lazerEndY);
      }  
      // 檢查是否到達切換圖片的時間
      if (millis() > nextImageTime) {
        if (this.lazerEnd || this.lazerWidth >= 30) {
          if (this.lazerWidth <=5) this.lazerWidth = 0;
          else this.lazerWidth -= 5;
          this.lazerEnd = true;
        }
        else {
          this.lazerWidth += 5;
          this.lazerOpacity -= 10;
        }
        this.leaveSpeed += 0.02;
        // 切換到下一張圖片
        if (this.Fired != true && currentImageIndex < 4) currentImageIndex += 1;
        else {
          this.Fired = true;
          currentImageIndex = (currentImageIndex + 1) % images.length;
          if (currentImageIndex == 0) currentImageIndex = 4;
        }
        // 設定下一次切換的時間
        nextImageTime = millis() + imageSwitchInterval[currentImageIndex];
      }
    }
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    scale(scaleValue);  // 縮放物體
    imageMode(CENTER);
    image(images[currentImageIndex], 0, 0);
    popMatrix();
  }
  
  boolean isOut() {
    if (this.Fired && (x < -100 || y < -100) || (x > 1000 || y > 1000) && this.lazerWidth <= 1) return true;
    else return false;
  }
  
  
}
