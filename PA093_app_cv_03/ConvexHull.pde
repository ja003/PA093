
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
   nextP = getNextHullPointGW(pivotPrev, pivot, points);      
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

ArrayList<Point> getGrahamScan(ArrayList<Point> pointsOrig){
  ArrayList<Point> points = new ArrayList<Point>(pointsOrig); 
  if(points.size()<1)
    return points;
    
  ArrayList<Point> pointsHull = new ArrayList<Point>(); 
  Point pivotO = GetPivot(points);  
  //print("\npivot: " + pivotO);
  Point pivot = pivotO.clone();
  Point pivotPrev = new Point(pivot.x, 0);
  //pointsHull.add(pivot);
  
  //points.remove(pivotO);
  sortPointsByAngle(points, pivotPrev, pivot);
  
  for(int i=0; i< points.size();i++){
    //print("\n"+i + " - ");
    pointsHull.add(points.get(i));
    //print("\nadding: "+points.get(i));
    int hullSize = pointsHull.size()-1;
    //print(hullSize);
    if(hullSize > 2 && 
        getCrossProduct(
          pointsHull.get(hullSize-2),
          pointsHull.get(hullSize-1),
          pointsHull.get(hullSize)) > 0){
      //print("\nremoving: "+pointsHull.get(hullSize-1));
      pointsHull.remove(hullSize-1);
    }
    
  }
  
  return pointsHull;
}

void sortPointsByAngle(ArrayList<Point> points, Point p0, Point p1){
  for(int i=0; i< points.size();i++){
    for(int j=0; j< points.size()-1;j++){
      //print("\n["+i+","+j+"]:");
      if(getAngle(p0,p1,points.get(j)) == 0 ||
          getAngle(p0,p1,points.get(j)) < getAngle(p0,p1,points.get(j+1))){
        Point tmp = points.get(j);
        //print("\nswapping: "+tmp+","+points.get(j+1));
        points.set(j,points.get(j+1));
        points.set(j+1,tmp);
      }
    }  
  }
  //in our case pivot bubbles up at last position (as it has angle = 0)
  //so we push it at the start
  Point tmp = points.get(points.size()-1);
  points.add(0,tmp);
  points.remove(points.size()-1);
  
  //print("\nsorted:\n");
  for(int i=0; i< points.size();i++){
    //print(points.get(i) + ", ");
  }  
  //print("\n----------------------\n");
}

//Gift Wrap texhnique
Point getNextHullPointGW(Point p1, Point p2, ArrayList<Point> points){
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
  //print("\n angle ["+p1+","+p2+","+p3+"]: " + PVector.angleBetween(p1p2, p2p3));
  return PVector.angleBetween(p1p2, p2p3);
}

float getCrossProduct(Point p1, Point p2, Point p3){
  //PVector p1p2 = new PVector(p2.x-p1.x, p2.y-p1.y);
  //PVector p2p3 = new PVector(p3.x-p2.x, p3.y-p2.y);
  float cross = (p2.x - p1.x)*(p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x);
  //print("\n dot ["+p1+","+p2+","+p3+"]: "+cross);
  //return PVector.cross(p1p2, p2p3);//not working?
  return cross; 
}

//returns point with max X coordinate
//TODO: return min Y c when there are 2 points with max X c.
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