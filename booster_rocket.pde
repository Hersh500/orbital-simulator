class Booster {
  int fuel_remaining;
  float magnitude = 36000000; 
  
  Booster (int fuel) {
    fuel_remaining = fuel; 
  }
  
  PVector boost (PVector dir) {
    PVector force = dir; 
    if (fuel_remaining > 0) {
      fuel_remaining -= 1;
      force.mult(magnitude);  
      return force; 
    }
    else {
      return new PVector(0,0); 
    }
  }
}