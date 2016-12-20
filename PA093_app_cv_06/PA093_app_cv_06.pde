ArrayList<Point> points;
Point selectedPoint;
int WINDOW_SIZE_X = 1000;
int WINDOW_SIZE_Y = 1000;

boolean convexHull;
ArrayList<Point> pointsHull;

boolean delaunayTriangulationFlag;
boolean triangulation;
boolean drawKdTree;

void setup() {
  WINDOW_SIZE_X = 1000;
  WINDOW_SIZE_Y = 1000;
  size(1000, 1000);
  noStroke();
  background(126);
  convexHull = true;
  points = new ArrayList<Point>();
  int x = 100;
  int c = 100;
  
  /*points.add(new Point(x-c,x-c));
  points.add(new Point(x+c,x-c));
  points.add(new Point(x-c,x+c));
  points.add(new Point(x+c,x+c));*/
  
  points.add(new Point(x,x));
  points.add(new Point(x,3*x));
  //points.add(new Point(2*x,3*x));
  points.add(new Point(3*x,3*x));
  points.add(new Point(3*x,x));
  //points.add(new Point(2*x,x));
    
    
  /*points.add(new Point(x,2*x));
  points.add(new Point(x,x));
  points.add(new Point(2*x,x/2-40));
  points.add(new Point(2*x,x+x/2));
  points.add(new Point(2.5*x,2*x));
  points.add(new Point(3*x,x));
  points.add(new Point(3.5*x,1.7*x));
  points.add(new Point(4*x,x));*/
  
  
  
  //points.add(new Point(x-50,x-100));
  //points.add(new Point(x+100,x-100));
  
  //points.add(new Point(x-100,x+100));
  //points.add(new Point(x+100,x+100));
  
  /*points.add(new Point(x-200,x-50));
  points.add(new Point(x-150,x-100));
  points.add(new Point(x-75,x-125));
  points.add(new Point(x,x-100));
  points.add(new Point(x+50,x));
  points.add(new Point(x-100,x));*/
  //points.add(new Point(x-80,x-250));
  //points.add(new Point(x-90,x-50));
  /*points.add(new Point(730,560));
  points.add(new Point(400,436));
  points.add(new Point(373,583));
  points.add(new Point(415,479));
  points.add(new Point(471,500));*/
  pointsHull = new ArrayList<Point>(); 
}

void draw() {
  background(126);
  
  
  for(int i = 0; i<points.size();i++){
    Point p = points.get(i);
    ellipse(p.x, p.y, 10,10);
  }
  if(convexHull)
    connectPointsWithLine(pointsHull, 5);
    
  if(triangulation)
    drawLines(lineFrom, lineTo);
    
  if(delaunayTriangulationFlag)
    drawEdges(delaunayTriangulation);
    
  if(drawKdTree)
    drawKdTree();
}

void mouseClicked() {
  Point p0 = isPointSelected();
  if(p0 != null)
    points.remove(p0);
  else  
    points.add(new Point(mouseX, mouseY));
    
  print("\n ----------------\n");
  for(int i = 0; i<points.size();i++){
    Point p = points.get(i);
    print(p);
  }
  print("\n");
 
}

void mouseDragged(){
  Point p0 =isPointSelected();
  if(p0 != null){
    selectedPoint = p0;
  }
  if(selectedPoint != null){
     movePointWithMouse(selectedPoint);
  }
}
void mouseReleased() {
  selectedPoint = null;
}

void keyPressed(){
 if(key == 'g'){
    points.add(getRandomPoint()); 
 }
 if(key == 'r'){
   resetAll();
 }
 if(key == 'h'){
   convexHull = true;
 }
 
 if(key == 'c'){
   //pointsHull = getGiftWrap(points);
   pointsHull = getGrahamScan(points);
 }
 if(key == 'd'){
   delaunayTriangulationFlag = true;
   triangulation = false;
   print("delaunayTriangulation\n");
   getDelaunayTriangulation(points);
 }
 
 if(key == 't'){
   triangulation = true;
   delaunayTriangulationFlag = false;
   print("triangulate\n");
   getTriangulation(points);
 }
 if(key == 'k'){
   print("kdTree\n");
   buildKdTreeFrom(points);
   drawKdTree = true;
 }
 
}