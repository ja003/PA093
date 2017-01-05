ArrayList<Point> lineFrom;
ArrayList<Point> lineTo;

void getTriangulation(ArrayList<Point> pointsOrig){
  lineFrom = new ArrayList<Point>();
  lineTo = new ArrayList<Point>();  
  ArrayList<Point> points = getGrahamScan(pointsOrig);// new ArrayList<Point>(pointsOrig); 
  if(points.size()<2)
    return;
     
    
  addConvexHull(points);
        
  determineSides(points);
  sortPointsByX(points);
  
  //print("\npoints: ");
  for(int i=0;i<points.size();i++){
    //print(points.get(i).toStringExtra()+",");
  } 
  
  ArrayList<Point> stack = new ArrayList<Point>();
  stack.add(points.get(0));
  stack.add(points.get(1));
  //print("\nstart");
  for(int i = 2;i < points.size();i++){
    Point p = points.get(i);
    Point stackTop = stack.get(stack.size()-1);
    //print("\n-"+i+"-");
    //print("stack:");
    for(int j = 0;j< stack.size();j++){
      //print(stack.get(j) + ",");
    }
    
    if(p.side == stackTop.side){
      lineFrom.add(p);
      lineTo.add(stackTop);
      for(int j = stack.size()-1;j>0;j--){
       if(isWithinPolygon(
         p,
         stack.get(j), 
         stack.get(j-1))){
           lineFrom.add(p);
           lineTo.add(stack.get(j-1));           
           //print("\nIF from:" +p+ "to "+stack.get(j-1));
           //print(" remove: "+stack.get(j));
           stack.remove(j);
       }
     }  
    }else{
     for(int j = 0;j < stack.size();j++){
       lineFrom.add(p);
       lineTo.add(stack.get(j));
       //print("\nELSE from:" +p+ "to "+stack.get(j));
     }
     stack.clear();
     stack.add(stackTop);     
     
     for(int j = stack.size()-2;j>=0;j--){
       if(!isWithinPolygon(
         p,
         stackTop, 
         stack.get(j))){
           //print(" remove: "+stack.get(j));
       stack.remove(j);
       }
     }
     
    } 
    
    stack.add(p);   
    /*
    //print("\nlines:\n");
    for(int j = 0;j< lineFrom.size();j++){
      //print(lineFrom.get(j)+"-"+lineTo.get(j) + "|\n");
    }*/
  }
  /*
  for(int i=0;i<lineFrom.size()-1;i++){
   //print("["+lineFrom.get(i)+" - "+lineTo.get(i)+"]\n"); 
  }*/
}

void addConvexHull(ArrayList<Point> points){
  ArrayList<Point> hull = getGrahamScan(points);
  for(int i=0;i<hull.size()-1;i++){
    ////print(hull.get(i)+",");
    lineFrom.add(hull.get(i));
    lineTo.add(hull.get(i+1));
 }
  lineFrom.add(hull.get(0));
  lineTo.add(hull.get(hull.size()-1));
}

boolean isWithinPolygon(Point pFrom,Point p2,Point p3){
 if(pFrom.side == Side.left && 
   getCrossProduct(pFrom,p2,p3) < 0){
   return true;
 }
 else if(pFrom.side == Side.right && 
   getCrossProduct(pFrom,p2,p3) > 0){
   return true;
 }
 return false;
}

void determineSides(ArrayList<Point> points){
  //print("points:\n");
  for(int i=0;i<points.size();i++){
   //print(points.get(i)+","); 
  }
  //print("\n");
  
  Point minX = new Point(6666,6666);
  int minXindex = 0;
  for(int i=0; i < points.size();i++){
    if(points.get(i).x < minX.x){
      minX = points.get(i);
      minXindex = i;
    }
  }
  //print("\nminI:"+minXindex);
  for(int i=0; i < minXindex;i++){
    Point tmp = points.get(0).clone();
    //print( " move "+tmp);
    points.remove(0);
    points.add(tmp);
  }
  minXindex = 0;  
  //print("\npoints:\n");
  for(int i=0;i<points.size();i++){
   //print(points.get(i)+","); 
  }
  //print("\n");
  
  int maxXindex = 0;
  Point maxX = new Point(-6666,6666);
  for(int i=0; i< points.size();i++){
    if(points.get(i).x > maxX.x){
      maxX = points.get(i);   
      maxXindex = i;
    }
  }
  //print("\nmaxI:"+maxXindex);
  
  points.get(minXindex).side = Side.both;
  points.get(maxXindex).side = Side.both;
  
  float s = getCrossProduct(
    points.get(minXindex),
    points.get(maxXindex),
    points.get(1));  
  
  for(int i = 1; i < maxXindex;i++){
    points.get(i).side = s<0? Side.left:Side.right;
  }
  for(int i = maxXindex+1; i < points.size();i++){
    points.get(i).side = s<0? Side.right:Side.left;
  }
  
  //print("sides:\n");
  for(int i=0;i<points.size();i++){
   //print(points.get(i)+","); 
  }
  //print("\n");
}