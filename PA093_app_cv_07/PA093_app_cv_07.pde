ArrayList<Point> points;
Point selectedPoint;

ArrayList<Point> pointsGiftWrap;
ArrayList<Point> pointsGrahamScan;

boolean drawDelaunayTriangulation;
boolean drawTriangulation;
boolean drawKdTree;
boolean drawVoronoiDiagram;
boolean drawGiftWrap;
boolean drawGrahamScan;

int WINDOW_SIZE_X = 1000;
int WINDOW_SIZE_Y = 1000;

void setup() {
  size(1000, 1000);
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
    
  if(drawDelaunayTriangulation)
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
    print("Add random point\n"); 
 }
 if(key == 'r'){
   resetAll();
   print("RESET\n"); 
 }
 if(key == 'h'){
   drawGiftWrap = !drawGiftWrap;
   if(drawGiftWrap){
     pointsGiftWrap = getGiftWrap(points);      
     print("GiftWrap\n"); 
   }
 }
 
 if(key == 'c'){
   drawGrahamScan = !drawGrahamScan;
   if(drawGrahamScan){
     pointsGrahamScan = getGrahamScan(points);     
     print("GrahamScan\n");
   }
 }
 if(key == 'd'){
   drawDelaunayTriangulation = !drawDelaunayTriangulation;
   drawTriangulation = false;
   if(drawDelaunayTriangulation){
     print("delaunayTriangulation\n");
     getDelaunayTriangulation(points);
   }
 }
 
 if(key == 't'){
   drawTriangulation = !drawTriangulation;
   drawDelaunayTriangulation = false;
   if(drawTriangulation){
     print("triangulate\n");
     getTriangulation(points);
   }
 }
 if(key == 'k'){
   
   drawKdTree = !drawKdTree;
   if(drawKdTree){
     print("kdTree\n");
     buildKdTreeFrom(points);
   }
 }
 if(key == 'v'){   
   drawVoronoiDiagram = !drawVoronoiDiagram;
   if(drawVoronoiDiagram){
     print("voronoi\n");
     CreateVoronoiDiagramFrom(getDelaunayTriangulation(points));  
   }
 }
 
}