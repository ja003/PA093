ArrayList<Triangle> triangles;
ArrayList<Edge> voronoiDiagram;

public void CreateVoronoiDiagramFrom(ArrayList<Edge> delaunayTriangulation){
  voronoiDiagram = new ArrayList<Edge>();
  triangles = new ArrayList<Triangle>();
  if(delaunayTriangulation.size() < 3)
    return;
    
  print("DEL:");
  for(int i = 0;i< delaunayTriangulation.size();i++){
    print("\n"+i+" - "+delaunayTriangulation.get(i)+",");
  }
  print("-DEL\n");
  
  computeTriangles(delaunayTriangulation);
  evaluateNeighbouringTriangles(triangles);
  //ArrayList<Point> centers = getCircumCenters(triangles);
  
  for(int i = 0;i< triangles.size();i++){
    Triangle t = triangles.get(i);
    print("\nprocess " + t);
    for(int j = 0;j < t.neigbours.size();j++){
      voronoiDiagram.add(new Edge(t.circumCenter, t.neigbours.get(j).circumCenter));
    }
  }
  
}

/*ArrayList<Point> getCircumCenters(ArrayList<Triangle> triangles){
  ArrayList<Point> centers = new ArrayList<Point>();
  for(int i = 0;i< triangles.size();i++){
    centers.add(getCenterOfCircumCircle(triangles.get(i)));
  }
  return centers;
}*/

void computeTriangles(ArrayList<Edge> edges){
   for(int i = 0;i< edges.size();i++){
     Point p0 = edges.get(i).p0;
     Point p1 = edges.get(i).p1;
     Edge t_edge = new Edge(p0,p1);
     print("\n\n"+i + ":" + t_edge);
     Point p2 = p0;
     //boolean confirmed = false;
     
     for(int j = 0;j< edges.size();j++){       
       Edge e = edges.get(j);
       if(i != j){
         
         print("\n-try:"+j + ":" + e);
         if(e.intersects(t_edge)){
           print("\nintersect " + e + "-" +t_edge);
           if(e.p0.equals(t_edge.p0) || e.p0.equals(t_edge.p1)){
             p2 = e.p1;
             print(" p2="+p2);
           }else if(e.p1.equals(t_edge.p0) || e.p1.equals(t_edge.p1)){
             p2 = e.p0;
             print(" p2="+p2);
           }
           
           
           for(int k = 0;k< edges.size();k++){
             Edge e0 = edges.get(k);
             print("\n--try:"+k + ":" + e0 + " equals? " + p2);
             if(k!=i &&k != j && !p0.equals(p2) && t_edge.intersects(e0) && e.intersects(e0)){ 
               if(e0.getIntersection(t_edge) != e0.getIntersection(e))
               {
                  print(k + " - confirmed");
                  Triangle newT = new Triangle(p0,p1,p2);
                  if(!triangles.contains(newT)){
                     triangles.add(newT);
                     print("\nADD " + newT+"\n");   
                  }
                  else{
                     print("--already there " + newT);           
                  }
               }else{
                  print("bad intersect"); 
               }
             }
           }
         }
       }
     }  
     if(p2.equals(p0)){
      print("\nFAIL" + p0+p1+p2); 
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

Point getCenterOfCircumCircle(Triangle triangle){
  return getCenterOfCircumCircle(triangle.p0, triangle.p1, triangle.p2);
}