class Cosmos {
  Body[] bodies; 
  int num_bodies; 
  
  Cosmos () {
    bodies = new Body[100000]; 
    num_bodies = 0; 
  }
  
  void add_body (Body b) {
    bodies[num_bodies] = b; 
    num_bodies += 1; 
  }
  
  Body get_body (int i) {
    return bodies[i]; 
  }
  
}