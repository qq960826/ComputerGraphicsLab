ArrayList<PVector> ControlPoints=new ArrayList<PVector>();
Boolean finished=false;
void setup(){
  size(720,720);
  background(204);
  
}
void draw(){
}
void mousePressed(){
  PVector mouse_point=new PVector(mouseX,mouseY);
  if(mouseButton==LEFT){
    ControlPoints.add(mouse_point);
    drawControlPolygon();
  }
    if(mouseButton==RIGHT){
      if(finished==false){
        DrawBezier();
        finished=true;
      }else{
        ControlPoints.clear();
        background(204);
        finished=false;
      }
    
  }
}
void drawControlPolygon(){
  stroke(255,0,0);
  for(int i=0;i<ControlPoints.size();i++){
    if(i==0){
      //ellipse(ControlPoints.get(i).x-2,ControlPoints.get(i).y-2,ControlPoints.get(i).x+2,ControlPoints.get(i).y+2);
      continue;
    }
      //ellipse(ControlPoints.get(i).x-2,ControlPoints.get(i).y-2,ControlPoints.get(i).x+2,ControlPoints.get(i).y+2);
      line(ControlPoints.get(i-1).x,ControlPoints.get(i-1).y,ControlPoints.get(i).x,ControlPoints.get(i).y);
  }
}
long Fac(int m){
  long f;
  if(m==0||m==1)
    f=1;
  else
    f=m*Fac(m-1);
  return f;
}
double Cni(int n, int i){
  return (double)(Fac(n))/(Fac(i)*Fac(n-i));
}
void DrawBezier(){
    stroke(0,0,255);
    float x_last=ControlPoints.get(0).x,y_last=ControlPoints.get(0).y;
    for(float t=0;t<=1;t+=0.01){
      float x=0,y=0;
      for(int i=0;i<ControlPoints.size();i++){
        PVector p=ControlPoints.get(i);
        int n=ControlPoints.size()-1;
        x+=p.x*Cni(n,i)*pow(t,i)*pow(1-t,n-i);
        y+=p.y*Cni(n,i)*pow(t,i)*pow(1-t,n-i);
        
        
      }
      line(x_last,y_last,x,y);
      x_last=x;y_last=y;
      
    }
}
