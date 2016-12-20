ArrayList<Edge> delaunayTriangulation;
ArrayList<Edge> AEL;

ArrayList<Edge> getDelaunayTriangulation(ArrayList<Point> points) {
  delaunayTriangulation = new ArrayList<Edge>(); 
  if(points.size() < 3)
    return delaunayTriangulation;
  AEL = new ArrayList<Edge>();
  delaunayTriangulation = new ArrayList<Edge>(); 
  Point p1 = points.get(0);
  Point p2 = getClosestPoint(points, p1);
    
  Edge e = new Edge(p1, p2);
  Point p = getDelaunayClosestPoint(points, e, Side.left);
  if (p == null){
    e.swapOrientation();
    p = getDelaunayClosestPoint(points, e, Side.left);
  }
  Edge e2 = new Edge(p2, p);
  Edge e3 = new Edge(p, p1);
  AEL.add(e);
  AEL.add(e2);
  AEL.add(e3);
  int i = -1;
  while(!AEL.isEmpty() && i < 666){
    i++;     
    e = AEL.get(0);     //<>//
    e.swapOrientation();
    p = getDelaunayClosestPoint(points,e, Side.left);
    
    if(p != null && 
      (containsEdge(delaunayTriangulation,new Edge(p,e.p0)) ||
      containsEdge(delaunayTriangulation,new Edge(p,e.p1))))
    {
      e.swapOrientation();
      p = getDelaunayClosestPoint(points,e, Side.left);
    }
    
    
    if(p != null){
       p1 = e.p0;
       p2 = e.p1;
       e2 = new Edge(p2,p);
       if(!containsEdge(AEL,e2) && !containsEdge(delaunayTriangulation,e2)){
         if(!intersectsEdges(AEL,e2)){
           AEL.add(e2);   
         }
       }
       
       e3 = new Edge(p,p1);       
       if(!containsEdge(AEL,e3) && !containsEdge(delaunayTriangulation,e3)){
         if(!intersectsEdges(AEL,e3)){
           AEL.add(e3); 
         }
       }
    }
    delaunayTriangulation.add(e);
    AEL.remove(e);
  }
  
    return delaunayTriangulation;
}

boolean containsEdge(ArrayList<Edge> edges, Edge edge){
  Edge e_swapped = edge.clone();
  e_swapped.swapOrientation();
  return isEdgeIn(edges,edge) || isEdgeIn(edges,e_swapped);
}

//contains function works only with references, references are lost on the way...
boolean isEdgeIn(ArrayList<Edge> edges, Edge edge){
  for (int i = 0; i<edges.size(); i++) {
      if(edge.equals(edges.get(i)))
        return true;
  }
  return false;
}

boolean intersectsEdges(ArrayList<Edge> edges, Edge edge){
  for (int i = 0; i<edges.size(); i++) {
      if(edge.hasIntersection(edges.get(i)))
        return true;
  }
  return false;
}


Point getClosestPoint(ArrayList<Point> points, Point pointFrom) {
  float dist = 6666;
  int index = 0;
  for (int i = 0; i<points.size(); i++) {
    float d = pointFrom.distanceTo(points.get(i));
    if (d != 0 && d < dist) {
      dist = d; 
      index = i;
    }
  }
  return points.get(index);
}

Point getDelaunayClosestPoint(ArrayList<Point> points, Edge edge, Side side) {
  int sideMultiplier = -1;
  if(side == Side.right)
    sideMultiplier *= -1;
  float dist = 6666;
  int index = -1;
  for (int i = 0; i<points.size(); i++) {
    float d = getDelaunayDistance(edge, points.get(i));
    if (d != 0 && d < dist && 
    sideMultiplier * getCrossProduct(edge.p0, edge.p1, points.get(i)) > 0) {
      dist = d; 
      index = i;
    }
  }
  
  if (index != -1)
  return points.get(index);
  else
    return null;
}

float getDelaunayDistance(Edge e, Point p) {
  
  Point center = getCenterOfCircumCircle(e.p0, e.p1, p);
  float dist = center.distanceTo(p); 
  if (getCrossProduct(e.p0, e.p1, p) * getCrossProduct(e.p0, e.p1, center) < 0)
    dist *= -1;
  return dist;
}

Point getCenterOfCircumCircle(Point p0, Point p1, Point p2){
    float dA, dB, dC, aux1, aux2, div;
 
    dA = p0.x * p0.x + p0.y * p0.y;
    dB = p1.x * p1.x + p1.y * p1.y;
    dC = p2.x * p2.x + p2.y * p2.y;
 
    aux1 = (dA*(p2.y - p1.y) + dB*(p0.y - p2.y) + dC*(p1.y - p0.y));
    aux2 = -(dA*(p2.x - p1.x) + dB*(p0.x - p2.x) + dC*(p1.x - p0.x));
    div = (2*(p0.x*(p2.y - p1.y) + p1.x*(p0.y-p2.y) + p2.x*(p1.y - p0.y)));
 
    if(div == 0){ 
        return p2;
    }
    Point center = new Point(0,0);
 
    center.x = aux1/div;
    center.y = aux2/div;
 
    float radius = sqrt((center.x - p0.x)*(center.x - p0.x) + (center.y - p0.y)*(center.y - p0.y));
    //print(" radius = " + radius);
    return center;
}