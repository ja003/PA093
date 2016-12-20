ArrayList<Point> points;
Point selectedPoint;
int WINDOW_SIZE_X = 1000;
int WINDOW_SIZE_Y = 1000;
boolean convexHull;
ArrayList<Point> pointsHull;

void setup() {
  WINDOW_SIZE_X = 1000;
  WINDOW_SIZE_Y = 1000;
  size(1000, 1000);
  noStroke();
  background(126);
  convexHull = true;
  points = new ArrayList<Point>(); 
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
 if(key == 'd'){
   convexHull = true;
 }
 
 if(key == 'c'){
   pointsHull = getGiftWrap(points);
 }
 
}