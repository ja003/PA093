

Point isPointSelected(){
  for(int i = 0; i<points.size();i++){
    Point p = points.get(i);
    if(isMouseNearPoint(p,5))
      return p;
  }  
  return null;
}

boolean isMouseNearPoint(Point point, float e){
  return (mouseX - e < point.x &&  point.x < mouseX + e && mouseY - e < point.y &&  point.y < mouseY + e);
} 

void movePointWithMouse(Point p){
  p.x = mouseX;
  p.y = mouseY;
}

Point getRandomPoint(){
  return new Point(random(WINDOW_SIZE_X), random(WINDOW_SIZE_Y));
}

void resetAll(){
 points.clear(); 
}