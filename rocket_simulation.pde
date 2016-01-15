/**
  TODO: 
  - need to fix things
  - 1 pixel is 10^5 meters-- need to scale UP for calculations 
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
float G = 6.67 * pow (10, -11); //approximate--scaled using some math 

/**
  The following method scales quantities by the appropriate amount, so they can be entered as their true-to-life numbers, 
  and then scaled down appropriately for the program.
*/ 
float scale_pixels (float num_pixels) {
  return num_pixels * pow (10, 5); //each pixel of distance is 10^5 meters. (The rocket is not drawn to scale). 
}

float scale_meters (float num_meters) {
  return num_meters / pow(10, 5); 
}

void setup() {
  size (1280, 720);
  background(0);
  earth = new Body (60.37, width/2, height/2, 5.97*pow(10, 24), new PVector (0,0));
  c = new Cosmos(); 
  c.add_body(earth); 
  r = new Rocket (2970000, .7, earth.radius_in_pixels, earth.position);
  launch_button = new RButton (60, 40, "launch", new PVector (width-80, height-90)); 
  booster2_button = new RButton (60, 40, "booster2", new PVector (width-80, height-50));
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