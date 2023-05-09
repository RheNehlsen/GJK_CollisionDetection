class Simplex{
  
  ArrayList<PVector> points;
  
  Simplex(){
    points = new ArrayList<PVector>(3);
  }
  
  void add(PVector p){
    points.add(p);
  }
  
  PVector getLast(){
    return points.get(points.size()-1);
  }
  
  
  boolean containsOrigin(PVector d){
    PVector a = getLast(); //<>//
    PVector ao =  a.copy().mult(-1);
    
    if(points.size() == 3){
      PVector b = points.get(1);
      PVector c = points.get(0);
      PVector ab = b.copy().sub(a);
      PVector ac =  c.copy().sub(a);
      PVector abPerp = tripleProduct(ac, ab, ab);
      
      if(abPerp.dot(ao) > 0){
        points.remove(c);
        d.set(abPerp);
        d.normalize();
      }
      else{
        PVector acPerp = tripleProduct(ab, ac, ac);
        if(acPerp.dot(ao) >0){ 
          points.remove(b);
          d.set(acPerp);
          d.normalize();
        }
        else{
          return true;
        }
      }
    }
    else{
      PVector b = points.get(0);
      PVector ab = b.copy().sub(a);
      d.set(tripleProduct(ab, ao, ab).normalize());
      d.normalize();
      
    }
    return false;
  } //<>//
}
PVector tripleProduct(PVector a, PVector b, PVector c){
  return a.copy().cross(b).cross(c);
}

PVector perpendicular(PVector a){
    return new PVector(-a.y, a.x);
}
