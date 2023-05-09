abstract class Object{
  PVector position;
  PVector velocity;
  
  float radius;
  int fillColor;
  Object(float x, float y, float r, int c){
    
    position = new PVector(x,y);
    velocity = PVector.random2D();
    velocity.mult(3);
    radius = r;
    fillColor = c;
  }
  
  void update(){
    position.add(velocity);
  }
  
  void checkBoundaryCollision(){
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }
  
  abstract void display();
  
  abstract PVector supportPoint(PVector d);
}

class Ball extends Object{
  
  Ball(float x, float y, float r, int c){
    super(x,y,r,c);
  }
  
  PVector supportPoint(PVector d){
    PVector p = new PVector;
    d.normalize(p).mult(radius);
    return p;
  }
  void display(){
    noStroke();
    fill(fillColor);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}

class Square extends Object{
   //<>//
  Square(float x, float y, float r, int c){
    super(x,y,r,c);
  }
  
  void checkBoundaryCollision(){
    
   if (position.x > width - radius) {
      position.x = width - radius;
      velocity.x *= -1;
    } else if (position.x <= 0) {
      position.x = 0;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y <= 0) {
      position.y = 0;
      velocity.y *= -1;
    }
  }
  
  PVector supportPoint(PVector d){
    float vertices = squareVetices();
    int max = 0;
    float dot = d.dot(vertices[0][0], vertices[0][1]);
    
    for(int i =1; i<4; i++){
      currDot = d.dot(vertices[i][0], vertices[i][1]);
      if (currDot> dot){
        max = i;
        dot = currDot;
      }
    }
    
    return new PVector(vertices[max][0], vertices[max][1]);
  }
  
  float[] squareVertices(){
    return {
      (position.x, position.y),
      (position.x + radius, position.y),
      (position.x, position.y + radius),
      (position.x + radius, position.y + radius)
    }
  }
  
  void display(){
    noStroke();
    fill(fillColor);
    square(position.x , position.y, radius);
  }
}
