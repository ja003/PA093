

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
 
  boolean intersects(Edge edge)
  {
    float i_x;
    float i_y;
    float p0_x = p0.x;
    float p0_y = p0.y;
    float p1_x = p1.x;
    float p1_y = p1.y;
    
    float p2_x = edge.p0.x;
    float p2_y = edge.p0.y;
    float p3_x = edge.p1.x;
    float p3_y = edge.p1.y;
  
    float s1_x, s1_y, s2_x, s2_y;
    s1_x = p1_x - p0_x;     s1_y = p1_y - p0_y;
    s2_x = p3_x - p2_x;     s2_y = p3_y - p2_y;

    float s, t;
    s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
    t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);

    if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
    {
        i_x = p0_x + (t * s1_x);
        i_y = p0_y + (t * s1_y);
        Point intersection = new Point(i_x, i_y);
        if(intersection.equals(p0) || intersection.equals(p1))
          return false;        
        return true;
    }

    return false; // No collision
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