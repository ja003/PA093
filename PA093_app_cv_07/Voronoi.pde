ArrayList<Triangle> triangles;
ArrayList<Edge> voronoiDiagram;

public void CreateVoronoiDiagramFrom(ArrayList<Edge> delaunayTriangulation){
  voronoiDiagram = new ArrayList<Edge>();
  triangles = new ArrayList<Triangle>();
  if(delaunayTriangulation.size() < 2)
    return;
    
  //print("DEL:");
  for(int i = 0;i< delaunayTriangulation.size();i++){
    //print("\n"+i+" - "+delaunayTriangulation.get(i)+",");
  }
  //print("-DEL\n");
  
  computeTriangles(delaunayTriangulation);
  evaluateNeighbouringTriangles(triangles);
  evaluateBoarderingTriangles(triangles);
  //ArrayList<Point> centers = getCircumCenters(triangles);
  
  for(int i = 0;i< triangles.size();i++){
    Triangle t = triangles.get(i);
    if(t.neigbours.size() > 0){
      for(int j = 0;j < t.neigbours.size();j++){
        voronoiDiagram.add(new Edge(t.circumCenter, t.neigbours.get(j).circumCenter));
        if(t.boarder.size() > 0){
          for(int k = 0; k< t.boarder.size();k++){
           voronoiDiagram.add(getRay(t.circumCenter,t.boarder.get(k), t));  
          }
        }
      }
    }else{
      if(t.boarder.size() > 0){
          for(int k = 0; k< t.boarder.size();k++){
           voronoiDiagram.add(getRay(t.circumCenter,t.boarder.get(k), t));  
          }
      }
    }
  }  
}

//polopřímka
Edge getRay(Point from, Edge toEdge, Triangle t){
  Point to = toEdge.getCenter();
  Point dir;
  if(from.equals(to)){
    Point p = to;
    if(to.equals(t.e0.getCenter())){
      if(t.e1.p0.equals(t.e0.p0)){
       p = t.e2.p1;
      }else{
        p = t.e2.p0;
      }        
    }
    else if(to.equals(t.e1.getCenter())){
      if(t.e2.p0.equals(t.e1.p0)){
       p = t.e0.p1;
      }else{
        p = t.e0.p0;
      }        
    }
    else if(to.equals(t.e2.getCenter())){
      //print("?3?");
      if(t.e0.p0.equals(t.e2.p0)){
       p = t.e1.p1;
      }else{
        p = t.e1.p0;
      }        
    }
    dir = new Point(to.x - p.x, to.y - p.y);  
  }
  else{
    Point opositePoint = to;
    if(toEdge.equals(t.e0)){
     if(toEdge.p0.equals(t.e1.p0))
       opositePoint = t.e2.p1;
     else
       opositePoint = t.e2.p0;
    }
    if(toEdge.equals(t.e1)){
     if(toEdge.p0.equals(t.e2.p0))
       opositePoint = t.e0.p1;
     else
       opositePoint = t.e0.p0;
    }
    if(toEdge.equals(t.e2)){
     if(toEdge.p0.equals(t.e1.p0))
       opositePoint = t.e1.p1;
     else
       opositePoint = t.e1.p0;
    }
    if(opositePoint.distanceTo(to) > opositePoint.distanceTo(from))
     dir = new Point(to.x - from.x, to.y - from.y); 
    else
     dir = new Point(from.x - to.x, from.y - to.y);   
  }
  
  
  Point infPoint = new Point(from.x + 666*dir.x, from.y + 666*dir.y);
  return new Edge (from, infPoint);  
}

void computeTriangles(ArrayList<Edge> edges){
   for(int i = 0;i< edges.size();i++){
     Point p0 = edges.get(i).p0;
     Point p1 = edges.get(i).p1;
     Edge t_edge = new Edge(p0,p1);
     //print("\n\n"+i + ":" + t_edge);
     Point p2 = p0;
     //boolean confirmed = false;
     
     for(int j = 0;j< edges.size();j++){       
       Edge e = edges.get(j);
       if(i != j){
         
         //print("\n-try:"+j + ":" + e);
         if(e.intersects(t_edge)){
           //print("\nintersect " + e + "-" +t_edge);
           if(e.p0.equals(t_edge.p0) || e.p0.equals(t_edge.p1)){
             p2 = e.p1;
             //print(" p2="+p2);
           }else if(e.p1.equals(t_edge.p0) || e.p1.equals(t_edge.p1)){
             p2 = e.p0;
             //print(" p2="+p2);
           }
           
           
           for(int k = 0;k< edges.size();k++){
             Edge e0 = edges.get(k);
             //print("\n--try:"+k + ":" + e0 + " equals? " + p2);
             if(k!=i &&k != j && !p0.equals(p2) && t_edge.intersects(e0) && e.intersects(e0)){ 
               if(e0.getIntersection(t_edge) != e0.getIntersection(e))
               {
                  //print(k + " - confirmed");
                  Triangle newT = new Triangle(p0,p1,p2);
                  if(!triangles.contains(newT)){
                     triangles.add(newT);
                     //print("\nADD " + newT+"\n");   
                  }
                  else{
                     //print("--already there " + newT);           
                  }
               }else{
                  //print("bad intersect"); 
               }
             }
           }
         }
       }
     }  
     if(p2.equals(p0)){
      //print("\nFAIL" + p0+p1+p2); 
     }
     /*if(confirmed){
       Triangle newT = new Triangle(p0,p1,p2);
       if(!triangles.contains(newT)){
         triangles.add(newT);
         print("\nadd " + newT);       
       }
       else{
         print("\nalready there " + newT);           
       }
     }*/
   }
}

void evaluateNeighbouringTriangles(ArrayList<Triangle> triangles){  
  for(int i = 0;i< triangles.size();i++){
    Triangle t = triangles.get(i);
    for(int j = 0;j< triangles.size();j++){
      if(t.isNeighbour(triangles.get(j))){
        t.neigbours.add(triangles.get(j));
      }
    }    
  }
}

void evaluateBoarderingTriangles(ArrayList<Triangle> triangles){  
  for(int i = 0;i< triangles.size();i++){
    Triangle t = triangles.get(i);
    if(t.neigbours.size() > 0){
      //print(t + " - ");
      //print(t.neigbours.get(0));
      ArrayList<Edge> candidates = new ArrayList<Edge>();
      candidates.add(t.e0);
      candidates.add(t.e1);
      candidates.add(t.e2);
      for(int j = 0; j < t.neigbours.size(); j++){
        for(int k = candidates.size()-1;k>=0;k--){
         if(t.neigbours.get(j).isEdgeIn(candidates.get(k))){
           candidates.remove(k);
         }
        }  
      }
      t.boarder = candidates;
    }else{
      t.boarder.add(t.e0);
      t.boarder.add(t.e1);
      t.boarder.add(t.e2);
    }
  }
}

Point getCenterOfCircumCircle(Triangle triangle){
  return getCenterOfCircumCircle(triangle.p0, triangle.p1, triangle.p2);
}