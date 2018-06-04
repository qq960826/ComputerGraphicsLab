int window_width=720,window_height=720;
void setup(){
  size(720,720);
}
void draw(){
  background(255);
  drawDiamond(30,300);
}
void drawDiamond(int n,float radius){
    //noStroke();
  //fill(255);
  float x[]=new float[n],y[]=new float[n];
  float theata=2*PI/(float)n;
  for(int i=0;i<n;i++){
    y[i]=radius*sin(i*theata);
    x[i]=radius*cos(i*theata);
  }
  for(int i=0;i<n-1;i++){
    for(int j=i+1;j<n;j++){
        line(x[i]+window_width/2,y[i]+window_height/2,x[j]+window_width/2,y[j]+window_height/2);
      }
    }
}
