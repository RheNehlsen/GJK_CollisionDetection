void setup(){
  size(500,500);
}

Object[] objects = {
  new Ball(100,200, 40, 255),
  new Square(50, -10, 100, 100)
};

void draw(){
  
  background(51);
  
  for(Object o : objects){
    o.update();
    o.display();
    o.checkBoundaryCollision();
  }
  
}
