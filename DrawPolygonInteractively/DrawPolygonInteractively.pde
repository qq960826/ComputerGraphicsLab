ArrayList<PVector> vertex=new ArrayList<PVector>();
Boolean first=true;
Boolean move=false;
Boolean showPolygon=false;
void setup(){
  size(720,720); 
  background(204);
  frameRate(4);
  //noLoop();
}
void draw(){
  background(204);
  if(showPolygon==true){
    beginShape();
     for(int i=0;i<vertex.size();i++){
      
      vertex(vertex.get(i).x,vertex.get(i).y);
      
      
    }
    endShape();
    return;
  }
  if(vertex.size()>=2){
    for(int i=1;i<vertex.size();i++){
      int index=i;
      line(vertex.get(index-1).x,vertex.get(index-1).y,vertex.get(index).x,vertex.get(index).y);
    }
  }
}
void mousePressed(){
  PVector mouse_point=new PVector(mouseX,mouseY);
  if(mouseButton==LEFT){
    if(first){
    vertex.add(mouse_point);
    vertex.add(mouse_point);
    println("mousePressed|first",mouse_point.x,mouse_point.y);
    first=false;
    int index=vertex.size()-1;
    line(vertex.get(index-1).x,vertex.get(index-1).y,vertex.get(index).x,vertex.get(index).y);
    }else{
      vertex.add(mouse_point);
      int index=vertex.size()-1;
      line(vertex.get(index-1).x,vertex.get(index-1).y,vertex.get(index).x,vertex.get(index).y);
      println("mousePressed|not first");
    }
  }
}
void mouseReleased(){
  PVector mouse_point=new PVector(mouseX,mouseY);
  if(mouseButton==RIGHT){
    if(showPolygon==false){
    showPolygon=true;
    
    
    }else{
      showPolygon=false;
      first=true;
      move=false;
      vertex.clear();
      
    }
    //int index=vertex.size()-1;
    //line(vertex.get(index-1).x,vertex.get(index-1).y,vertex.get(index).x,vertex.get(index).y);
    //if(!move){
    //  first=true;
    //}
    
  }
}
void mouseDragged(){
  
  PVector mouse_point=new PVector(mouseX,mouseY);
  println("mouseMoved",mousePressed);
  if(mousePressed==true&&mouseButton==LEFT){
    move=true;
    int index=vertex.size()-1;
    line(vertex.get(index-1).x,vertex.get(index-1).y,vertex.get(index).x,vertex.get(index).y);
    vertex.set(index,mouse_point);
    line(vertex.get(index-1).x,vertex.get(index-1).y,vertex.get(index).x,vertex.get(index).y);

    
  }
  
}
