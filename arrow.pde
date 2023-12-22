class Arrow {
    ArrayList<arr> arrows = new ArrayList<arr>();

    void create(float x, float y, float angle, float speed, float size, float dist, int side) {
        PVector outsidePoint = createOutsidePoint(rectPosition, dist, side); //指定起始：x: (rectPosition[0] - d , rectPosition[0] + rectPosition[2] + d), y: (rectPosition[1] - d , rectPosition[1] + rectPosition[3] + d)  
        arr arrow = new arr(outsidePoint.x, outsidePoint.y, calculateAngle(outsidePoint, rectPosition), speed, size); //(起始x, 起始 y , 角度, 速度, 大小）
        arrows.add(arrow);
    }

    void draw(){
        for (int i = arrows.size() - 1; i >= 0; i--) {
            arr arrow = arrows.get(i);
            arrow.update();
            arrow.display();

            // 箭飛出邊界刪除
            if (arrow.isOutOfBounds()) {
            arrows.remove(i);
            }
        }
    }

    // 生成方框外的座標
    PVector createOutsidePoint(float[] rectPosition, float dist, int side) {
        switch (side) {
            case 0:
                return new PVector(random(rectPosition[0], rectPosition[0]+ rectPosition[2]), rectPosition[1] - dist);
            case 1:
                return new PVector(rectPosition[0]+ rectPosition[2] + dist, random(rectPosition[1], rectPosition[1]+ rectPosition[3]));
            case 2:
                return new PVector(random(rectPosition[0], rectPosition[0]+ rectPosition[2]), rectPosition[1]+ rectPosition[3]+ dist);
            case 3:
                return new PVector(rectPosition[0] - dist, random(rectPosition[1], rectPosition[1]+ rectPosition[3]));
            default:
                return new PVector(0, 0);
        }
    }

    // 計算箭往方框的角度
    float calculateAngle(PVector arrowPos, float[] rectPosition) {
        return atan2(rectPosition[1]+ rectPosition[3] / 2 - arrowPos.y, rectPosition[0]+ rectPosition[2] / 2 - arrowPos.x);
    }

}

class arr{
    float x, y, angle, speed, size, bodyLength, xSpeed, ySpeed, r;
    PImage image;

    arr(float x, float y, float angle, float speed, float size) {
        this.x = x;
        this.y = y;
        this.angle = angle;
        this.speed = speed;
        this.size = size;
        this.image = loadImage("images/spear.png");
    }
  
    void update() {
        this.speed += 0.2;
        this.xSpeed = speed * cos(angle);
        this.ySpeed = speed * sin(angle);
        this.x += this.xSpeed;
        this.y += this.ySpeed;
    }

    void display() {
        pushMatrix();
        translate(x, y);
        rotate(angle);
        scale(size);
        imageMode(CENTER);
        image(image, 0, 0);
        popMatrix();
    }
    
    // 超出邊界刪除
    boolean isOutOfBounds() {
        return x < 0 || x > width || y < 0 || y > height;
    } 
 
}


  
