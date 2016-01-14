/**
  TODO: 
  - implement correct value for G 
  - scale quantities appropriately (gravity, mass of rocket, mass of fuel, etc.) 
    - mass scaling factor: (1 / 10^23)
    - size scaling factor: (1 / 10^5) 
  - implement navigation in the rocket (nose cone applies a force) 
  - implement fuel mass
  - implement planetary forces 
*/


Body earth; 
Rocket r;
PVector gravity; 
Cosmos c; 
RButton launch_button; 
RButton booster2_button; 
float G = scale_force (sq(scale_radius( 1/sq(scale_mass(6.674 * pow (10, -11)))))); 

/**
  The following three methods scale quantities by the appropriate amount, so they can be entered as their true-to-life numbers, 
  and then scaled down appropriately for the program.
*/ 

float scale_mass(float mass) {
  return mass * (1 / pow(10, 23)); 
}

PVector scale_force(PVector force) {
  return new PVector (scale_mass (scale_radius (sq(1/scale_time (force.x)))), scale_mass (scale_radius (sq(1/scale_time (force.y))))); 
}

float scale_force (float force) {
  return (scale_mass (scale_radius (sq(1/scale_time (force))))); 
}
float scale_radius(float radius) {
  return radius * (1/pow(10,5)); 
}

float scale_time(float time) {
  return time * 1/30; //each "frame" represents a second. 
}

//need to scale the radius in the attract function 

void setup() {
  size (1280, 720);
  background(0);
  earth = new Body (scale_radius(6.371*pow(10,6)), width/2, height/2, scale_mass(5.97*pow(10, 24)), new PVector(0,0));
  c = new Cosmos(); 
  c.add_body(earth); 
  r = new Rocket (scale_mass(2970000), .7, earth.radius, earth.position);
  launch_button = new RButton (60, 40, "launch", new PVector (width-80, height-90)); 
  booster2_button = new RButton (60, 40, "booster2", new PVector (width-80, height-50));
  frameRate(30); 
}

void draw() {
  background(0); 
    
  gravity = new PVector(0,0);
  for (int i = 0; i < c.num_bodies; i++) {
    gravity.add (c.get_body(i).attract (r.mass, r.position));
    println("Force of gravity is" + gravity); 
  }
  
  PVector[] forces = new PVector[100]; 
  int num_forces = 1; 
  forces[0] = gravity; 
  earth.update(); 
 
  earth.display(); 
  
  if (r.has_launched) {
    r.update(forces, num_forces); 
  }
  
  r.display(); 
  launch_button.display(); 
  booster2_button.display(); 
}

void mouseClicked() {
  if (launch_button.mouseHover()) {
    r.launch(); 
  }
  else if (booster2_button.mouseHover()) {
    r.booster_stage = 1; 
  }
}