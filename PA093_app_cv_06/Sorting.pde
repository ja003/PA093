void sortPointsByX(ArrayList<Point> points){
  for(int i=0; i< points.size();i++){
    for(int j=0; j< points.size()-1;j++){
      //if(points.size() < 2)
        //return;
      Point p1 = points.get(j);
      Point p2 = points.get(j+1);
      if(p1.x > p2.x || (p1.x == p2.x && p1.y > p2.y)){
        Point tmp = p1.clone();
        //print("\nswapping: "+tmp+","+points.get(j+1));
        points.set(j,points.get(j+1));
        points.set(j+1,tmp);
      }
    }  
  }
  /*print("sorted:\n");
  for(int i=0;i<points.size();i++){
   print(points.get(i)+","); 
  }
  print("\n");*/
}

void sortPointsByY(ArrayList<Point> points){
  for(int i=0; i< points.size();i++){
    for(int j=0; j< points.size()-1;j++){
      //if(points.size() < 2)
        //return;
      Point p1 = points.get(j);
      Point p2 = points.get(j+1);
      if(p1.y > p2.y || (p1.y == p2.y && p1.x > p2.x)){
        Point tmp = p1.clone();
        //print("\nswapping: "+tmp+","+points.get(j+1));
        points.set(j,points.get(j+1));
        points.set(j+1,tmp);
      }
    }  
  }
  /*print("sorted:\n");
  for(int i=0;i<points.size();i++){
   print(points.get(i)+","); 
  }
  print("\n");*/
}