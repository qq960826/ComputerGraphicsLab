int window_width=720,window_height=720;

class Point2D{
  public double x;
  public double y;
  public double w;
  public Point2D(){
      x=0;
      y=0;
      w=1;
  }
  public Point2D(double mx,double my){
      x=mx;
      y=my;
      w=1;
  }
}
class Point3D extends Point2D{
  public double z;
  public Point3D(){
    z=0;
  }
  public Point3D(double mx,double my,double mz){
    super(mx,my);
    z=mz;
  }
}
class Face{
  public int VertexNum;
  public int Vertexs[];
  public Face(){
    VertexNum=0;
    Vertexs=null;
  }
  public void SetNum(int num){
    VertexNum=num;
    Vertexs=new int[VertexNum];
    
  }
}
class Transform{
  float TransformMatrix[][]=new float[4][4];
  int num;
  Point3D PointsOld[];
  void SetMatrix(Point3D[] points,int n){
    num=n;
    PointsOld=points;
  }
  void Identity(){
    TransformMatrix[0][0]=1.0;TransformMatrix[0][1]=0.0;TransformMatrix[0][2]=0.0;TransformMatrix[0][3]=0.0;
    TransformMatrix[1][0]=0.0;TransformMatrix[1][1]=1.0;TransformMatrix[1][2]=0.0;TransformMatrix[1][3]=0.0;
    TransformMatrix[2][0]=0.0;TransformMatrix[2][1]=0.0;TransformMatrix[2][2]=1.0;TransformMatrix[2][3]=0.0;
    TransformMatrix[3][0]=0.0;TransformMatrix[3][1]=0.0;TransformMatrix[3][2]=0.0;TransformMatrix[3][3]=1.0;
  }
  void RotateX(float angle){
    Identity();
    float radian=angle*PI/180;
    TransformMatrix[1][1]=cos(radian); TransformMatrix[1][2]=sin(radian);
    TransformMatrix[2][1]=-sin(radian);TransformMatrix[2][2]=cos(radian);
    MultiMatrix();
  }
  void RotateY(float angle){
    Identity();
    float radian=angle*PI/180;
    TransformMatrix[0][0]=cos(radian);TransformMatrix[0][2]=-sin(radian);
    TransformMatrix[2][0]=sin(radian);TransformMatrix[2][2]=cos(radian);  
    MultiMatrix();
  }
  void RotateZ(float angle){
    Identity();
    float radian=angle*PI/180;
    TransformMatrix[0][0]=cos(radian); TransformMatrix[0][1]=sin(radian);
    TransformMatrix[1][0]=-sin(radian);TransformMatrix[1][1]=cos(radian);
    MultiMatrix();
  }
  void MultiMatrix(){
    Point3D PointsNew[]=new Point3D[num];
    for(int i=0;i<num;i++){
      PointsNew[i]=PointsOld[i];
    }
    for(int i=0;i<num;i++){
    PointsOld[i].x=PointsNew[i].x*TransformMatrix[0][0]+PointsNew[i].y*TransformMatrix[1][0]+PointsNew[i].z*TransformMatrix[2][0]+PointsNew[i].w*TransformMatrix[3][0];
    PointsOld[i].y=PointsNew[i].x*TransformMatrix[0][1]+PointsNew[i].y*TransformMatrix[1][1]+PointsNew[i].z*TransformMatrix[2][1]+PointsNew[i].w*TransformMatrix[3][1];
    PointsOld[i].z=PointsNew[i].x*TransformMatrix[0][2]+PointsNew[i].y*TransformMatrix[1][2]+PointsNew[i].z*TransformMatrix[2][2]+PointsNew[i].w*TransformMatrix[3][2];
    PointsOld[i].w=PointsNew[i].x*TransformMatrix[0][3]+PointsNew[i].y*TransformMatrix[1][3]+PointsNew[i].z*TransformMatrix[2][3]+PointsNew[i].w*TransformMatrix[3][3];
    }
    
    
  }
}

Point3D Points[]=new Point3D[8];
Face Faces[]=new Face[8];
Transform trans=new Transform();
float Alpha=0,Beta=0;
Boolean autoplay=false;

void initPoints(float a){
  for(int i=0;i<8;i++){
    Points[i]=new Point3D();
  }
  Points[0].x=-a;Points[0].y=-a;Points[0].z=-a;
  Points[1].x=+a;Points[1].y=-a;Points[1].z=-a;
  Points[2].x=+a;Points[2].y=+a;Points[2].z=-a;
  Points[3].x=-a;Points[3].y=+a;Points[3].z=-a;
  Points[4].x=-a;Points[4].y=-a;Points[4].z=+a;
  Points[5].x=+a;Points[5].y=-a;Points[5].z=+a;
  Points[6].x=+a;Points[6].y=+a;Points[6].z=+a;
  Points[7].x=-a;Points[7].y=+a;Points[7].z=+a;
}
void initFace(){
  for(int i=0;i<8;i++){
    Faces[i]=new Face();
  }
  Faces[0].SetNum(4);Faces[0].Vertexs[0]=4;Faces[0].Vertexs[1]=5;Faces[0].Vertexs[2]=6;Faces[0].Vertexs[3]=7;//front
  Faces[1].SetNum(4);Faces[1].Vertexs[0]=0;Faces[1].Vertexs[1]=3;Faces[1].Vertexs[2]=2;Faces[1].Vertexs[3]=1;//back
  Faces[2].SetNum(4);Faces[2].Vertexs[0]=0;Faces[2].Vertexs[1]=4;Faces[2].Vertexs[2]=7;Faces[2].Vertexs[3]=3;//left
  Faces[3].SetNum(4);Faces[3].Vertexs[0]=1;Faces[3].Vertexs[1]=2;Faces[3].Vertexs[2]=6;Faces[3].Vertexs[3]=5;//right
  Faces[4].SetNum(4);Faces[4].Vertexs[0]=2;Faces[4].Vertexs[1]=3;Faces[4].Vertexs[2]=7;Faces[4].Vertexs[3]=6;//top
  Faces[5].SetNum(4);Faces[5].Vertexs[0]=0;Faces[5].Vertexs[1]=1;Faces[5].Vertexs[2]=5;Faces[5].Vertexs[3]=4;//bottom
 
}
void drawBox(){
  Point3D point_first=null,point_last=null,point_current=null;
  for(int nFace=0;nFace<6;nFace++){
    for(int nPoint=0;nPoint<Faces[nFace].VertexNum;nPoint++){
      point_current=Points[Faces[nFace].Vertexs[nPoint]];
      if(nPoint==0){
        point_first=point_current;
        point_last=point_current;
        continue;
      }
      line((float)point_last.x+window_width/2,(float)point_last.y+window_height/2,(float)point_current.x+window_width/2,(float)point_current.y+window_height/2);
      point_last=point_current;
    }
    line((float)point_last.x+window_width/2,(float)point_last.y+window_height/2,(float)point_first.x+window_width/2,(float)point_first.y+window_height/2);
  }
}
void setup(){
  size(720,720);
  initPoints(150);
  initFace();
  trans.SetMatrix(Points,8);
  
}
void draw(){
  background(204);
  initPoints(150);
  initFace();
  trans.RotateX(Alpha);
  trans.RotateY(Beta);
  if(autoplay){

      Alpha+=5;
      Beta-=5;
      
      delay(100);
  }
    drawBox();

}
void keyPressed() {
  if (key == CODED) {
      initPoints(150);
      initFace();
    if (keyCode == UP) {
      Alpha+=5;
    }else if(keyCode == DOWN){
      Alpha-=5;
    }else if(keyCode == LEFT){
      Beta-=5;
    }else if(keyCode == RIGHT){
      Beta+=5;
      
    }
    //trans.RotateX(Alpha);
    //trans.RotateY(Beta);
  }else{
    if(keyCode=='b'||keyCode=='B'){
      autoplay=!autoplay;
    }
  }
}
