class Rocket { 
  PVector position;
  PVector velocity = new PVector (0, 0);
  PVector acceleration = new PVector (0, 0);
  
  float mass; 
  float angle_of_launch;
    
  int booster_stage = -1; //the current booster stage that has to fire 
  
  boolean has_launched = false; 
  Booster[] b = new Booster[5]; //can have 5 max booster stages  
  
  Rocket (float _mass, float _angle_of_launch, float radius_of_earth, PVector center_of_earth_pos) {
    mass = _mass;
    angle_of_launch = _angle_of_launch;
    position = new PVector (center_of_earth_pos.x, center_of_earth_pos.y + radius_of_earth);
    println("initial position" + position); 
  }
  
  void launch () {
    velocity = PVector.fromAngle(angle_of_launch); // launches at an angle (kludge)  
    b[0] = (new Booster (10)); //Initialize the booster, with some amount of fuel
    b[1] = (new Booster (50)); //to get into stable orbit
    booster_stage = 0; 
    has_launched = true; 
  }
  
  void display() { //Modelling as perfect sphere for now 
    stroke(0);
    strokeWeight(0.75);
    fill (255);
    ellipse (position.x, position.y, 8, 8);
  }
  
  void apply_trans_force (PVector net_force) {
    acceleration = net_force.div(mass); 
    println ("acceleration is " + acceleration); 
  }

  void update (PVector[] forces, int num_forces) {
    
    PVector force = b[booster_stage].boost(velocity.copy().normalize());
    print("mass = " + mass); 
    
    for (int i = 0; i < num_forces; i++) { 
      force.add (forces[i]);
    }
    
    println ("net force" + force); 
    apply_trans_force (force); 
    
    velocity.add (acceleration); 
    println ("velocity" + velocity); 
    position.add (velocity); 
    println ("position" + position); 
  }
}