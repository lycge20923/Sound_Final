
GasterBlasterManager gasterBlasterManager; 

final int LEFTRIGHT = 0;
final int CIRCLE = 1;
final int RANDOM = 2;
final int NONE = 3;

class GasterBlasterManager {
    ArrayList<GasterBlaster> gasterBlasters = new ArrayList<GasterBlaster>();
    int attack = NONE;
    float attackAngle = 0; 
    float vectorX, vectorY;
    int attackCount = 0;
    int startTime = Integer.MAX_VALUE;
    
    void startTime(int time) {
        this.startTime = time;
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
        if (i-startTime > 800 && i-startTime < 1800 && attackCount > 0 && attack == LEFTRIGHT){
            attackCount -= 3;
            float rand = random(1);
            float startX = (rand < 0.5) ? 0 : width;
            float startY = -100; // 起始 Y 坐標在畫面上方
            float targetX = (rand < 0.5) ? 70 : width-70;
            float targetY = random(height-120*2)+120; //random(height) + 120;
            float startAngle = (rand < 0.5) ? 360 : 180;
            float endAngle =  (rand < 0.5) ? 270 : 90;// random(TWO_PI);
            // 0 [1, 0], 90 [-0, 1], 180 [-1, 0], 270[0, -1]
            this.create(startX, startY, targetX, targetY, startAngle, endAngle); 
        }
        else if (i-startTime > 4800 && i-startTime < 6300 && attackCount > 0 && attack == RANDOM){
            attackCount -= 3;
            float startX = (random(1) < 0.5) ? -random(100) : random(100)+width;
            float startY = (random(1) < 0.5) ? -random(100) : random(100)+height; // 起始 Y 坐標在畫面上方
            float targetX = random(width/3) + width/3;
            float targetY = random(height/3) + height/3;
            
            float decide = random(1);
            if (decide < 0.333) {
                if(targetX < width/2) targetX -= width/4; else targetX += width/4;
            }
            else if (decide < 0.666) {
                if(targetY < height/2) targetY -= height/4; else targetY += height/4;
            }
            else {
              if(targetX < width/2) targetX -= width/4; else targetX += width/4;
              if(targetY < height/2) targetY -= height/4; else targetY += height/4;
            }
            
            float startAngle = random(360); // 隨機選擇起始角度
            float endAngle = random(40) + 25;
            if (targetX < width/2 && targetY < height/2) endAngle += 270;
            else if (targetX >= width/2 && targetY >= height/2) endAngle += 90;
            else if (targetX < width/2 && targetY >= height/2) endAngle += 190;
            
            // 0 [1, 0], 90 [-0, 1], 180 [-1, 0], 270[0, -1]
            this.create(startX, startY, targetX, targetY, startAngle, endAngle);
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
