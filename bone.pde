//畫布大小
int width = 600;
int height = 500;

//每一個陣列分別存：所有Bones出來時間、位置x、位置y、射出向量x、射出向量y
float[][][] set = new float[3][1000][6]; 

//test

class Bones{
  float time, pos_x, pos_y, move_x, move_y;

  // 出來時間做Array存取：showtimes
  // bones建立（會變動的）呈現物件array：bones 
  ArrayList<bone> bones0 = new ArrayList<bone>();
  ArrayList<bone> bones1 = new ArrayList<bone>();
  ArrayList<bone> bones2 = new ArrayList<bone>();
  int[] count;
  int punch_lay;

  void setup(){
    for(int i=0;i<200;i++){
      if(i<12){set[0][i] = new float[]{0,100,10,1,150,1};}
      else if(i<31){set[0][i] = new float[]{200,0,1,10,150,1};}
      else if(i<42){set[0][i] = new float[]{0,400,10,-1,150,1};}
      else if(i<52){set[0][i] = new float[]{400,500,-1,-10,150,1};}
      else if(i<65){set[0][i] = new float[]{0,0,6,5,150,2};}
      else if(i<84){set[0][i] = new float[]{0,0,3,-5,150,2};}
      else if(i<95){set[0][i] = new float[]{600,500,-6,-5,150,2};}
      else /*if(i<103)*/{set[0][i] = new float[]{600,0,-3,5,150,2};}
    for(int j=0;j<200;j++){
      if(j<10){set[1][j] = new float[]{600,400,-10,-1,150,1};}
      else if(j<23){set[1][j] = new float[]{600,100,-10,1,150,1};}
      else if(j<33){set[1][j] = new float[]{0,500,6,-5,150,2};}
      else /*if(j<46)*/{set[1][j] = new float[]{600,0,-6,5,150,2};}
    }
    for(int k=0;k<200;k++){
      if(k<5){set[2][k] = new float[]{0,200,3,2.5,100,100};}
      else if(k<12){set[2][k] = new float[]{600,300,-3,2.5,100,100};}
      else if(k<17){set[2][k] = new float[]{0,300,3,2.5,100,100};}
      else /*if(k<22)*/{set[2][k] = new float[]{600,300,-3,2.5,100,100};}
    }
    this.count = new int[]{0,0,0};
    this.punch_lay = 0;
  }
}

  void createBone(int i){
    int index = this.count[i];
    bone b = new bone(set[i][index][0],set[i][index][1], set[i][index][2], set[i][index][3], set[i][index][4],set[i][index][5]);
    if(i==0){
      this.bones0.add(b);
    }
    else if(i==1){
      this.bones1.add(b);
    }
    else{
      this.bones2.add(b);
    }
    this.count[i]++;
    this.punch_lay = 0;
  }

  void draw(){
    if(this.bones0.size()>0){
      for (int j=0; j < this.bones0.size();j++){
        this.bones0.get(j).draw(this.punch_lay);
        if(this.bones0.get(j).removebone()){
          this.bones0.remove(j);
        }
      }
    }
    if(this.bones1.size()>0){
      for (int j=0; j < this.bones1.size();j++){
        this.bones1.get(j).draw(this.punch_lay);
        if(this.bones1.get(j).removebone()){
          this.bones1.remove(j);
        }
      }
    }
    if(this.bones2.size()>0){
      for (int j=0; j < this.bones2.size();j++){
        this.bones2.get(j).draw(this.punch_lay);
        if(this.bones2.get(j).removebone()){
          this.bones2.remove(j);
        }
      }
    }
    punch_lay++;
  }
}

class bone{
  float angle_x, angle_y, len;
  PVector start, moving;
  float angle;
  PImage image_b, image_y;
  float scaleFactor;
  int turn_count;
  boolean exist;
  float punch;
  float small;
  

  bone(float x, float y, float angle_x, float angle_y, float len, float small) {
    start = new PVector(x, y);
    this.angle_x = angle_x;
    this.angle_y = angle_y;
    this.len = len;
    this.image_b = loadImage("images/CrossBone_b.png");
    this.image_y = loadImage("images/CrossBone_y.png");
    this.exist = true;
    this.small = small;
    angle = 0;
    scaleFactor = 1.0;
    turn_count = 0;
  }

  boolean removebone(){
    return !this.exist;
  }

  void update() {
    float def_turn_count = 2;
    if(this.small==2){
      def_turn_count = 2;
    }else{
      def_turn_count = 1;
    }
    if (start.x > width || start.x<0) {
      if(turn_count < def_turn_count){
        angle_x *= -1;
        turn_count++;
      }
      else{
        this.exist = false;
      }
    }
    if (start.y > height || start.y<0) {
      if(turn_count < def_turn_count){
        angle_y *= -1;
        turn_count++;
      }else{
        this.exist = false;
      }
    }
    start.x += angle_x;
    start.y += angle_y;
    angle = radians(frameCount * 100);
    if(this.small<100){
      scaleFactor = 0.15;
    }
    else{
      scaleFactor = sin(frameCount * 0.05)*0.3 + 1.3;
    }
    
  }

  void display(int punch_lay) {
    float def_punch_lay=3;
    if(this.small>=100){
      def_punch_lay=7;
    }
    push();
    translate(start.x, start.y);
    rotate(angle);
    scale(scaleFactor);
    imageMode(CENTER);
    if(punch_lay>def_punch_lay){
      image(image_b, 0, 0, len, len);
    }else{
      image(image_y, 0, 0, len*2, len*2);
    }
    pop();
  }

  void draw(int punch_lay){
    this.update();
    this.display(punch_lay);
  }
}

