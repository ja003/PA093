ArrayList<Point> points;
Point selectedPoint;

ArrayList<Point> pointsGiftWrap;
ArrayList<Point> pointsGrahamScan;

boolean drawDelaunayTriangulationFlag;
boolean drawTriangulation;
boolean drawKdTree;
boolean drawVoronoiDiagram;
boolean drawGiftWrap;
boolean drawGrahamScan;

int WINDOW_SIZE_X = 500;
int WINDOW_SIZE_Y = 500;

void setup() {
  size(500, 500);
  noStroke();
  background(126);
  points = new ArrayList<Point>();
  int x = 200;
  int c = 100;
  
  points.add(new Point(x-c,x-c));
  points.add(new Point(x+c/2,x-c));  
  points.add(new Point(x,x));
  points.add(new Point(x-c,x+c));
  points.add(new Point(x+c,x+c));
  
  pointsGiftWrap = new ArrayList<Point>(); 
  pointsGrahamScan = new ArrayList<Point>(); 
}

void draw() {
  background(126);
  
  
  for(int i = 0; i<points.size();i++){
    Point p = points.get(i);
    ellipse(p.x, p.y, 10,10);
  }
  if(drawGiftWrap)
    connectPointsWithLine(pointsGiftWrap, 5);
    
  if(drawGrahamScan)
    connectPointsWithLine(pointsGrahamScan, 5);
    
  if(drawTriangulation)
    drawLines(lineFrom, lineTo);
    
  if(drawDelaunayTriangulationFlag)
    drawEdges(delaunayTriangulation);
    
  if(drawKdTree)
    drawKdTree();
  
  if(drawVoronoiDiagram)
    drawEdges(voronoiDiagram);
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
   drawGiftWrap = !drawGiftWrap;
   if(drawGiftWrap)
     pointsGiftWrap = getGiftWrap(points);
 }
 
 if(key == 'c'){
   drawGrahamScan = !drawGrahamScan;
   if(drawGrahamScan)
     pointsGrahamScan = getGrahamScan(points);
 }
 if(key == 'd'){
   drawDelaunayTriangulationFlag = !drawDelaunayTriangulationFlag;
   drawTriangulation = false;
   print("delaunayTriangulation\n");
   getDelaunayTriangulation(points);
 }
 
 if(key == 't'){
   drawTriangulation = !drawTriangulation;
   drawDelaunayTriangulationFlag = false;
   print("triangulate\n");
   getTriangulation(points);
 }
 if(key == 'k'){
   print("kdTree\n");
   buildKdTreeFrom(points);
   drawKdTree = !drawKdTree;
 }
 if(key == 'v'){
   print("voronoi\n");
   CreateVoronoiDiagramFrom(getDelaunayTriangulation(points));
   drawVoronoiDiagram = !drawVoronoiDiagram;
 }
 
}