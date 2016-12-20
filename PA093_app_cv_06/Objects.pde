

class Point{
  float x;
  float y;  
  Side side;
  
  Point(float x, float y){
   this.x = x;
   this.y = y;
   this.side = Side.both;
  }
  Point(float x, float y, Side side){
   this.x = x;
   this.y = y;
   this.side = side;
  }
  
  String toString(){
   return "["+x+","+y+"]"; 
  }
  
  String toStringExtra(){
   return "["+x+","+y+"]:" + side; 
  }
  
  Point clone(){
    return new Point(x,y,side);
  }
  
  boolean equals(Point p){
    return p.x == x && p.y==y;
  }
  
  float distanceTo(Point point){
   return dist(x,y,point.x, point.y); 
  }
}

class Edge{
 Point p0;
 Point p1;
 
 Edge(Point p0,Point p1) {
  this.p0 = p0;
  this.p1 = p1;
 }
 
 Edge clone(){
  return new Edge(p0.clone(),p1.clone()); 
 }
 
 boolean equals(Edge e){
    return p0.equals(e.p0) && p1.equals(e.p1);
  }
 
 String toString(){
   return "["+p0+","+p1+"]"; 
  }
 
 void swapOrientation(){
  Point tmp = p0.clone();
  p0 = p1;
  p1 = tmp;
 }
 
 float distanceTo(Point p){
    float AB = p.distanceTo(p0);
    float BC = p0.distanceTo(p1);
    float AC = p.distanceTo(p1);
  
    // Heron's formula
    float s = (AB + BC + AC) / 2;
    float area = (float) Math.sqrt(s * (s - AB) * (s - BC) * (s - AC));
  
    // but also area == (BC * AD) / 2
    // BC * AD == 2 * area
    // AD == (2 * area) / BC
    // TODO: check if BC == 0
    float AD = (2 * area) / BC;
    return AD;
 }
}

//for triangulation
enum Side{
  left,
  right,
  both
}

class Triangle{
 Point p1;
 Point p2;
 Point p3;
}

class KdTree{
  KdNode root;
}
class KdNode{
 Point point;
 KdNode left;
 KdNode right;
 
 KdNode(Point point){
  this.point = point; 
 }
 
 String toString(){
   String leftString = "-";
   String rightString = "-";
   if(left != null)
     leftString = left.point.toString();
   if(right != null)
     rightString = right.point.toString();
   
  return point + "L:"+leftString+",R:"+rightString; 
 }
}