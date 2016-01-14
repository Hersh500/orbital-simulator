class Body {
  PVector position;
  float radius; 
  float mass;
  PVector planetary_forces; 
  PVector velocity; 
  
  Body(float _radius, int x, int y, float _mass, PVector _velocity) {
    radius = _radius;
    mass = _mass;
    position = new PVector(x, y);
    velocity = _velocity; 
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0, 200, 100);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
  
  /*
  void apply_force (PVector net_force) {
    acceleration = net_force.div(mass);
  }
  */ 
  
  PVector attract (float mass1, PVector pos_of_obj) {
    PVector force = PVector.sub (position, pos_of_obj);
    force.normalize(); 
    force.mult(G * mass1 * mass / sq((PVector.sub(pos_of_obj, position).mag()))); 
    return force; 
  }
  
  void update () {
    position.add(velocity); 
  }
}