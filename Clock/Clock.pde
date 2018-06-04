PFont font;
int window_height=720,window_length=720;
void setup(){
  size(720,720);
  font=createFont("Arial",16,true);
  textFont(font,16);
  frameRate(4);
}
void draw(){
  background(204);
      //noStroke();
  //fill(0);
  float radians;
  int CenterX=window_length/2,CenterY=window_length/2;
  //draw pannel digit
  fill(255, 0, 0);

  for(int i=1;i<=12;i++){
    String str=i+"";
    radians=(float)i*2*3.14/12.0;
    int size_cx=(int)textWidth(str);
    int size_cy=16;
    int x=CenterX-(size_cx/2)+(int)((double)(CenterX-20)*sin(radians));
    int y=CenterY-(size_cy/2)-(int)((double)(CenterY-20)*cos(radians));
    text(str,x,y);
  }
  fill(0, 0, 0);
  radians=(float)hour()+(float)minute()/60.0+(float)second()/3600.0;
  radians*=(2*3.14/12.0);
  line(CenterX,CenterY,CenterX+(int)((double)(CenterX/3)*sin(radians)),CenterY-(int)((double)(CenterY/3)*cos(radians)));
  //println("We got here and we're printing out the mouse location!!!");
  
  radians=(float)minute()+(float)second()/60.0;
  radians*=(2*3.14/60.0);  
  line(CenterX,CenterY,CenterX+(int)((double)(CenterX*1/2)*sin(radians)),CenterY-(int)((double)(CenterY*1/2)*cos(radians)));

  radians=(float)second();
  radians*=(2*3.14/60.0);
  line(CenterX,CenterY,CenterX+(int)((double)(CenterX*7/8)*sin(radians)),CenterY-(int)((double)(CenterY*7/8)*cos(radians)));

}
