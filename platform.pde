class Platform {
    ArrayList<plat> plats = new ArrayList<plat>();
    // 邊界判斷 [x_min, x_max, y_min, y_max]
    float[] boundary = new float[4];
    float flex = 4;

    Platform(float[] boundary) {
        this.boundary = boundary;
    }

    void create(float x, float y, float width, float speed){
        plat p = new plat(x, y, width, speed);
        this.plats.add(p);
    }
    
    void draw(Heart heart) {
        ArrayList<Integer> to_be_remove = new ArrayList<Integer>();
        boolean jumping_flag = true;
        float ori_heart_speed = heart.speed;
        for(int i=this.plats.size()-1; i>=0; i--){
            plat p = this.plats.get(i);
            p.display(this.boundary);

            // heart on the platform
            if(p.x - flex <= heart.heartX && heart.heartX <= p.x + p.width + flex && heart.heartY + heart.heartSize/2 <= p.y && heart.heartY + heart.heartSize/2 + heart.velocity >= p.y) {
                heart.heartX += p.speed;
                heart.speed = 2.5;
                heart.velocity = 0;
                heart.heartY = p.y - heart.heartSize/2;
                heart.jumping = false;
                jumping_flag = false;
            }

            // remove
            if(p.speed >= 0){
                if(p.x > this.boundary[1]){
                    to_be_remove.add(i);
                }
            }
            else{
                if(p.x + p.width < this.boundary[0]){
                    to_be_remove.add(i);
                }
            }
        }
        if(jumping_flag == true){
            heart.jumping = true;
            heart.speed = ori_heart_speed;
        } 
        for(int idx : to_be_remove){
            this.plats.remove(idx);
        }
    }

}

class plat {
    float width = 50;
    float height = 8;
    float x = 0, y = 0;
    float speed = 3;

    plat(float x, float y, float speed, float width){
        this.x = x;
        this.y = y;
        this.speed = speed;
        this.width = width;
    }

    void display(float[] boundary){
        float real_width = min(min(this.width, boundary[1] - this.x), this.width + this.x - boundary[0]);
        // white
        fill(color(255, 255, 255, 0));
        stroke(180);
        strokeWeight(1);
        rect(max(this.x, boundary[0]), this.y, real_width, this.height);

        // green
        fill(color(255, 255, 255, 0));
        stroke(0, 100, 0);
        strokeWeight(1);
        rect(max(this.x, boundary[0]), this.y - this.height/2, real_width, this.height);

        this.x += this.speed;
    }
}
