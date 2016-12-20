

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