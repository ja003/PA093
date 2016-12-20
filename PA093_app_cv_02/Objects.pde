

class Point{
  float x;
  float y;  
  
  Point(float x, float y){
   this.x = x;
   this.y = y;
  }
  
  String toString(){
   return "["+x+","+y+"]"; 
  }
  
  Point clone(){
    return new Point(x,y);
  }
  
  boolean equals(Point p){
    return p.x == x && p.y==y;
  }
}