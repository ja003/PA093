

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
 
 boolean intersects(Edge e){
  return (p0.equals(e.p0) || p1.equals(e.p0) || 
    p0.equals(e.p1) || p1.equals(e.p1)); 
 }
 
 Point getIntersection(Edge e){
   if(p0.equals(e.p0))
     return p0;
   if(p0.equals(e.p1))
     return p0;
   if(p1.equals(e.p0))
     return p1;
   if(p1.equals(e.p1))
     return p1;  
   return null;
 }
 
 boolean equals(Edge e, boolean ignoreOriantation){
   if(ignoreOriantation){
     return 
       (p0.equals(e.p0) && p1.equals(e.p1)) ||
       (p0.equals(e.p1) && p1.equals(e.p0));
   }
   return p0.equals(e.p0) && p1.equals(e.p1);
 }
 
 boolean equals(Edge e){
    return e.equals(this, false);
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
 Point p0;
 Point p1;
 Point p2;
 
 Edge e0;
 Edge e1;
 Edge e2;
 
 Point circumCenter;
 
 ArrayList<Triangle> neigbours;//max 3
 
  boolean equals(Object other){
    if (other == null) return false;
    if (other == this) return true;
    if (!(other instanceof Triangle))return false;
    Triangle o = (Triangle)other;
    return 
      (o.e0.equals(e0,true)&&o.e1.equals(e1,true)&&o.e2.equals(e2,true))||
      (o.e0.equals(e0,true)&&o.e2.equals(e1,true)&&o.e1.equals(e2,true))||
      (o.e1.equals(e0,true)&&o.e0.equals(e1,true)&&o.e2.equals(e2,true))||
      (o.e2.equals(e0,true)&&o.e0.equals(e1,true)&&o.e1.equals(e2,true))||
      (o.e1.equals(e0,true)&&o.e2.equals(e1,true)&&o.e0.equals(e2,true))||
      (o.e2.equals(e0,true)&&o.e1.equals(e1,true)&&o.e0.equals(e2,true));
 }
 
 Triangle(Point p0,Point p1, Point p2){
    this.p1 =p1;
    this.p2 =p2;
    this.p0 =p0;
    e0 = new Edge(p0,p1);
    e1 = new Edge(p1,p2);
    e2 = new Edge(p2,p0);
    neigbours = new ArrayList<Triangle>();
    circumCenter = getCenterOfCircumCircle(p0,p1,p2);
 }
 
 boolean isNeighbour(Triangle t){
   Edge e0 = new Edge(p0,p1);
   Edge e1 = new Edge(p1,p2);
   Edge e2 = new Edge(p2,p0);
   
   Edge t_e0 = new Edge(t.p0,t.p1);
   Edge t_e1 = new Edge(t.p1,t.p2);
   Edge t_e2 = new Edge(t.p2,t.p0);
   
   return 
     (e0.intersects(t_e0) ||e0.intersects(t_e1) ||e0.intersects(t_e2))||
     (e1.intersects(t_e0) ||e1.intersects(t_e1) ||e1.intersects(t_e2))||
     (e2.intersects(t_e0) ||e2.intersects(t_e1) ||e2.intersects(t_e2));  
 }
 
 String toString(){
    return "T:" + p0+","+p1+","+p2+" c:"+circumCenter+" N:"+neigbours.size(); 
 }
 
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