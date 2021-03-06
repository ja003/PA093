

Point isPointSelected(){
  for(int i = 0; i<points.size();i++){
    Point p = points.get(i);
    if(isMouseNearPoint(p,5))
      return p;
  }  
  return null;
}

boolean isMouseNearPoint(Point point, float e){
  return (mouseX - e < point.x &&  point.x < mouseX + e && mouseY - e < point.y &&  point.y < mouseY + e);
} 

void movePointWithMouse(Point p){
  p.x = mouseX;
  p.y = mouseY;
}

Point getRandomPoint(){
  return new Point(random(WINDOW_SIZE_X), random(WINDOW_SIZE_Y));
}

void resetAll(){
 points.clear(); 
 drawTriangulation = false;
 drawKdTree = false;
 drawGiftWrap = false;
 drawGrahamScan = false;
 drawVoronoiDiagram = false;
}

void drawEdges(ArrayList<Edge> edges){
  for(int i=0;i<edges.size();i++){
    Point p0 = edges.get(i).p0;
    Point p1 = edges.get(i).p1;
    strokeWeight(5);
    stroke(0);
    line(p0.x, p0.y, p1.x, p1.y);
  }
}

void printEdges(ArrayList<Edge> edges){
  print("\n-------------\n");
  for(int i=0;i<edges.size();i++){
    print(edges.get(i) + "\n");
  }
  print("-------------");
}

void drawLines(ArrayList<Point> lineFrom, ArrayList<Point> lineTo){
  if(lineFrom.size() < 2 || lineFrom.size() != lineTo.size())
    return;
   for(int i=0;i<lineFrom.size();i++){
    strokeWeight(5);
    stroke(0);
    line(lineFrom.get(i).x, lineFrom.get(i).y, lineTo.get(i).x, lineTo.get(i).y);
  }
}

void connectPointsWithLine(ArrayList<Point> points, float weight){
  if(points.size() < 2)
    return;
  
  for(int i=0;i<points.size()-1;i++){
    strokeWeight(weight);
    stroke(0);
    line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
    //print(points.get(i).x);
  }
  line(points.get(points.size()-1).x, points.get(points.size()-1).y, points.get(0).x, points.get(0).y);
}