
ArrayList<Point> getGiftWrap(ArrayList<Point> pointsOrig){
  ArrayList<Point> points = new ArrayList<Point>(pointsOrig); 
  if(points.size()<1)
    return points;
  
  ArrayList<Point> pointsHull = new ArrayList<Point>(); 
  
  Point pivotO = GetPivot(points);
  Point pivot = pivotO.clone();
  Point pivotPrev = new Point(pivot.x, 0);
  pointsHull.add(pivot);
  int counter = 0;
  Point nextP = new Point(666,666);
  while(nextP != pivotO){
   nextP = getNextHullPoint(pivotPrev, pivot, points);      
   pivotPrev = pivot;
   pivot = nextP.clone(); 
   
   pointsHull.add(pivot);
   points.remove(nextP);
   
   counter++;
   if(counter > 10){
     print("fail");
     return pointsHull;
   }
  }
  
  return pointsHull;
}


Point getNextHullPoint(Point p1, Point p2, ArrayList<Point> points){
  if(points.size() < 1){
    print("no next ");
    return null;
  }
  
  float minAngle = 666;
  Point minAnglePoint = p1;
  for(int i=0;i<points.size();i++){
   if(getAngle(p1,p2,points.get(i)) < minAngle && !points.get(i).equals(p2)){
     minAnglePoint = points.get(i);
     minAngle = getAngle(p1,p2,points.get(i));
   }
  }    
  return minAnglePoint;
}

float getAngle(Point p1, Point p2, Point p3){
  PVector p1p2 = new PVector(p2.x-p1.x, p2.y-p1.y);
  PVector p2p3 = new PVector(p3.x-p2.x, p3.y-p2.y);
  return PVector.angleBetween(p1p2, p2p3);
}

Point GetPivot(ArrayList<Point> points){
  if(points.size() < 1)
    return null;
  Point maxXPoint = new Point(-666,-666);
 for(int i=0;i<points.size();i++){
     if(points.get(i).x > maxXPoint.x){
       //print(points.get(i)+"---");
       maxXPoint = points.get(i);
     }
 } 
 return maxXPoint;
}