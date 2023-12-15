import controlP5.*;

ControlP5 cp5;

Slider2D slider;

float zoom = 1;

ArrayList<IntList> render;
int limit = 10000;

int oneX;
int oneY;

float angle_off = 0.0;
float angle_increment = 0.05;


float frames = 0;

boolean rec = false;


void setup(){
  size(2000,2000);
  cp5 = new ControlP5(this);
  
  slider = cp5.addSlider2D("")
              .setPosition(30,30)
              .setSize(200,200)
              .setMinMax(0,0,180,180)
              .setValue(0,0);
  
  oneX = width/2;
  oneY = height/2;
  background(255);
  render = new ArrayList<IntList>();
  for(int i=1; i<limit; ++i){
    IntList seq = new IntList();
    
    int n=i;
    do{
      seq.append(n);
      n = collatzFunc(n);
      
    }while(n!=1);
    seq.append(1);
    seq.reverse();
    
    render.add(seq);
  }
  
  println("fin");

}




void draw(){
  background(0);
  pushMatrix();
  for(IntList seq : render){
    float len=30;
    float angle = PI/16;
    resetMatrix();
    
    translate(oneX,oneY);
    for(int j=0; j<seq.size(); ++j){
      int value = seq.get(j);
      scale(zoom);
      if(value%2==0){
        angle = noise(angle_off)*5;
        if(random(20) % 2 == 0)angle*= -1;
        rotate(radians(slider.getArrayValue()[0]+angle));
        //rotate(angle);
      }else{
        angle = noise(angle_off)*5;
        if(random(20) % 2 == 0)angle*= -1;
        rotate(-radians(slider.getArrayValue()[1]+angle));
        //rotate(-angle);
      }
      //stroke(random(255),random(255),random(255));
      //stroke(255,30);
      if(value < 3000)stroke(200, 40, 10, 30);
      else if(value < 6000) stroke(10, 180, 90, 30);
      else stroke(10, 90, 180, 30);
      
      line(0,0,0,-len);
      translate(0,-len);
      
    }
    
  }
  angle_off += angle_increment;
  popMatrix();
  if(rec){
    saveFrame("frames/####.png");
    frames += 0.5;
    if(frames > 180)exit();
  }
}

void keyPressed(){
  if(key == 'z')zoom+=0.005;
  else if(key == 'x')zoom-=0.005;
  else if(keyCode == UP)oneY += 10;
  else if(keyCode == DOWN)oneY -= 10;
  else if(keyCode == LEFT)oneX += 10;
  else if(keyCode == RIGHT)oneX -= 10;
  else if(key == 'r')rec=true;
  else if(key == 's')saveFrame("outputImages/##.png");
  
  
}


int collatzFunc(int n){
  if(n%2 == 0){
    return n/2;
  }
  else{
    return (n*3+1)/2;
  }
}
