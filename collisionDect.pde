void setup(){
  size(700,700);
}

Object[] objects = {
  new Ball(width/2,height/2, 75, 255),
  new Square(width/2, height/2, 100, 100)
};

PVector support(Object p, Object q, PVector d){
   PVector a = p.supportPoint(d);
   PVector b = q.supportPoint(d.copy().mult(-1));
   
   return a.sub(b);
}

boolean GJK_detect(Object p, Object q){
  
  PVector d = p.center().sub(q.center()).normalize();
  
  Simplex simplex = new Simplex();
  
  simplex.add(support(p,q,d));
  
  d.mult(-1);
  
  while(true){
    simplex.add(support(p,q,d));
    
    if(simplex.getLast().dot(d)<= 0)
      return false;
    else{
      if(simplex.containsOrigin(d))
        return true;
    }
  }
}

void changeColors(Object[] obs){
  for(Object o:obs){
    o.setColor((o.fillColor + 10)% 256);
  }
}

void draw(){
  
  background(51);
  
  for(Object o : objects){
    o.update();
    o.display();
    o.checkBoundaryCollision();
  }
  
  if(objects[0].possibleCollision(objects[1])){
    if(GJK_detect(objects[0], objects[1]))
        changeColors(objects);   
  }
}
