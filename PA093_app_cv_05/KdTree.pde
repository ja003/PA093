KdTree kdTree;

void buildKdTreeFrom(ArrayList<Point> points){
  if(points.size() == 0)
    return;
  
  kdTree = new KdTree();
  kdTree.root = buildKdTree(pointsToKdNodes(points),0);
  
  //print("printing\n");
  printKdTree();
}

KdNode buildKdTree(ArrayList<KdNode> nodes, int depth){
  if(nodes.size() == 1){
     return nodes.get(0); 
  }
  else if(nodes.size() == 0){
     return null;
  }
  
  if(depth % 2 == 0){
   nodes = sortNodesByX(nodes); 
  }else{
   nodes = sortNodesByY(nodes); 
  }
  int median = (int)(nodes.size()/2);
    
  ArrayList<KdNode> P1 = getSublist(nodes,0,median);
  ArrayList<KdNode> P2 = getSublist(nodes,median+1,nodes.size());
  
  KdNode v_left = buildKdTree(P1, depth+1);
  KdNode v_right = buildKdTree(P2, depth+1);
  
  KdNode v = nodes.get(median);
  v.left = v_left;
  v.right = v_right;
  
  return v;
}

void drawKdTree(){
  if(kdTree.root != null)
   drawKdNode(kdTree.root, new KdNode(new Point(0, WINDOW_SIZE_Y)),0); 
}

void drawKdNode(KdNode node, KdNode parent, int depth){
  //print("\n"+depth+"-draw: " + node);
  if(node.left == null && node.right == null)
    return;
  //print("!");
  Point from = new Point(0,0);
  Point to = new Point(0,0);
  
  strokeWeight(5);
  stroke(0);
  
  if(depth % 2 == 0){    
    if(parent.point.y < node.point.y){
      from.y = parent.point.y;
      to.y = WINDOW_SIZE_Y;
    }
    else{
      from.y = 0;
      to.y = parent.point.y;
    }
    
    line(node.point.x, from.y, node.point.x, to.y);
  }else {
    if(parent.point.x < node.point.x){
      from.x = parent.point.x;
      to.x = WINDOW_SIZE_X;
    }
    else{
      from.x = 0;
      to.x = parent.point.x;
    }
    line(from.x,node.point.y, to.x, node.point.y);
  }
  if(node.left != null)
    drawKdNode(node.left, node, depth+1);
  if(node.right != null)
    drawKdNode(node.right, node, depth+1);
}

void printKdTree(){
  prinSubtree(kdTree.root,0);
}

void prinSubtree(KdNode node, int counter){
  if(counter > 10)
    return;
 //print(node + "\n");
 if(node.left != null)
   prinSubtree(node.left,counter+1);
 if(node.right != null)
   prinSubtree(node.right,counter+1);
}


ArrayList<KdNode> getSublist(ArrayList<KdNode> nodes, int from, int to){
  //print("\nsub:");
  ArrayList<KdNode> subList = new ArrayList<KdNode>();
  for(int i = from; i < to; i++){
    subList.add(nodes.get(i));
    //print(nodes.get(i)+",");
  }
  return subList;
}

ArrayList<KdNode> pointsToKdNodes(ArrayList<Point> points){
  //print(points.size() + " - ");  
  ArrayList<KdNode> nodes = new ArrayList<KdNode>();
  for(int i = 0;i<points.size();i++){
    nodes.add(new KdNode(points.get(i)));
  }
  return nodes;
}

ArrayList<Point> kdNodesToPoints(ArrayList<KdNode> nodes){
  ArrayList<Point> points = new ArrayList<Point>();
  for(int i = 0;i<nodes.size();i++){
    points.add(nodes.get(i).point);
  }
  return points;
}


ArrayList<KdNode> sortNodesByX(ArrayList<KdNode> nodes){
  ArrayList<Point> points = kdNodesToPoints(nodes);
  sortPointsByX(points);
  return pointsToKdNodes(points);
}
ArrayList<KdNode> sortNodesByY(ArrayList<KdNode> nodes){
  ArrayList<Point> points = kdNodesToPoints(nodes);
  sortPointsByY(points);
  return pointsToKdNodes(points);
}

//ArrayList<Point> nodesToPoints()