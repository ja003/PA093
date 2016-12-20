

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