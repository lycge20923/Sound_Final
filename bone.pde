//畫布大小
int width = 600;
int height = 500;

//每一個陣列分別存：所有Bones出來時間、位置x、位置y、射出向量x、射出向量y
float[][] set = new float[100][5]; 

//test

class Bones{
  float time, pos_x, pos_y, move_x, move_y;

  // 出來時間做Array存取：showtimes
  // bones建立（會變動的）呈現物件array：bones
  ArrayList<Float> showtimes = new ArrayList<Float>(); 
  ArrayList<bone> bones = new ArrayList<bone>();

  int count;
  void setup(){

    // 初始化 
    set[0] = new float[]{20,0,0,4,6};
    set[1] = new float[]{23,100,0,4,3};
    set[2] = new float[]{26,70,90,7,5};
    set[3] = new float[]{29,300,400,6,6};
    set[4] = new float[]{32,500,5,4,6};
    set[5] = new float[]{35,500,700,-4,-6};
    set[6] = new float[]{38,400,30,4,6};
    set[7] = new float[]{41,600,500,-4,-6};
    set[8] = new float[]{44,30,40,4,6};
    set[9] = new float[]{47,64,43,4,6};
    for(int i =0;i<set.length;i++){
      this.showtimes.add(set[i][0]);
    }
    this.count = 0;
  }

  void draw(int i){
    //時間吻合，抓新的bone物件進入宣告
    if(float(i)==this.showtimes.get(this.count)){ //如果時間吻合
      int index = this.count;
      bone b = new bone(set[index][1],set[index][2], set[index][3], set[index][4], 100);
      this.bones.add(b);
      this.count++;
    }

    //呈現所有應該呈現的bone
    if(this.bones.size()>0){
      for (int j=0; j < this.bones.size();j++){
        this.bones.get(j).draw();
        if(this.bones.get(j).removebone()){
          this.bones.remove(j);
        }
      }
    }
  }
}

class bone{
  float angle_x, angle_y, len;
  PVector start, moving;
  float angle;
  PImage image;
  float scaleFactor;
  int turn_count;
  boolean exist;

  bone(float x, float y, float angle_x, float angle_y, float len) {
    start = new PVector(x, y);
    this.angle_x = angle_x;
    this.angle_y = angle_y;
    this.len = len;
    this.image = loadImage("images/bone.png");
    this.exist = true;
    angle = 0;
    scaleFactor = 1.0;
    turn_count = 0;
  }

  boolean removebone(){
    return !this.exist;
  }

  void update() {
    if (start.x > width || start.x<0) {
      if(turn_count < 100){
        angle_x *= -1;
        turn_count++;
      }
      else{
        this.exist = false;
      }
    }
    if (start.y > height || start.y<0) {
      if(turn_count < 100){
        angle_y *= -1;
        turn_count++;
      }else{
        this.exist = false;
      }
    }
    start.x += angle_x;
    start.y += angle_y;
    angle = radians(frameCount * 100);
    scaleFactor = 0.15;
    //scaleFactor = sin(frameCount * 0.05)*0.3 + 1.3;
  }

  void display() {
    push();
    translate(start.x, start.y);
    rotate(angle);
    scale(scaleFactor);
    imageMode(CENTER);
    image(image, 0, 0, len, len);
    pop();
  }

  void draw(){
    this.display();
    this.update();
  }
}

