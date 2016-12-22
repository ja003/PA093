

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
 
  //actual intersection
  boolean hasIntersection(Edge edge)
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
 
 boolean intersects(Edge e){
  return (p0.equals(e.p0) || p1.equals(e.p0) || 
    p0.equals(e.p1) || p1.equals(e.p1)); 
 }
 
 //intersection only at edges
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
   //return e.equals(this, false);

   //return equals(e,true); 
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
   Edge t_e2 = new Edge(t.p2,t.p0); //<>//
   
   Point y0 = e0.getIntersection(t_e0);
   //print("\n"+e0 + " int " + t_e0 + " : " + y0);
   Point y1 = e0.getIntersection(t_e1);
   //print("\n"+e0 + " int " + t_e0 + " : " + y1);
   Point y2 = e0.getIntersection(t_e2);
   //print("\n"+e0 + " int " + t_e0 + " : " + y2);
   Point y3 = e1.getIntersection(t_e0);
   //print("\n"+e1 + " int " + t_e1 + " : " + y3);
   Point y4 = e1.getIntersection(t_e1);
   //print("\n"+e1 + " int " + t_e1 + " : " + y4);
   Point y5 = e1.getIntersection(t_e2);
   //print("\n"+e1 + " int " + t_e1 + " : " + y5);
   Point y6 = e2.getIntersection(t_e0);
   //print("\n"+e2 + " int " + t_e2 + " : " + y6);
   Point y7 = e2.getIntersection(t_e1);
   //print("\n"+e2 + " int " + t_e2 + " : " + y7);
   Point y8 = e2.getIntersection(t_e2);
   //print("\n"+e2 + " int " + t_e2 + " : " + y8);
   
   ArrayList<Point> ints = new ArrayList<Point>(); 
   if(y0 != null){ints.add(y0); }
   if(!ints.contains(y1) && y1 != null){ ints.add(y1);}
   if(!ints.contains(y2) && y2 != null){ ints.add(y2);}
   if(!ints.contains(y3) && y3 != null){ ints.add(y3);}
   if(!ints.contains(y4) && y4 != null){ ints.add(y4);}
   if(!ints.contains(y5) && y5 != null){ ints.add(y5);}
   if(!ints.contains(y6) && y6 != null){ ints.add(y6);}
   if(!ints.contains(y7) && y7 != null){ ints.add(y7);}
   if(!ints.contains(y8) && y8 != null){ ints.add(y8);}

   //print("\nINT:"+ints.size());
   return ints.size() >=2;
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