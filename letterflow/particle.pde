class Particle {
  
  PVector position;
  PVector force;
  PVector speed;
  boolean hit;
  int age = 0;
  int enterAge = 0;
  float conformity;
  int maxAge = (int)random(10, 90);
  
  int startColor = 100;
  int endColor = 75;
  
  Particle(PVector pos) {
    position = pos;
    speed = PVector.random3D();
    float c = 1.0;
    conformity = random(c) - c / 2;
  }
  
  Boolean update(int frame) {
    float frameMultiplier = 0.0015;
    float noiseMultiplier = 0.1015;
    float mult = 0.321;
    
    float noiseFloat = noise((position.x + conformity) * noiseMultiplier, 
      (position.y + conformity) * noiseMultiplier, 
      frame * frameMultiplier);
    PVector noiseVec = new PVector(cos(((noiseFloat -0.3) * TWO_PI) * mult),
      sin(((noiseFloat - 0.3) * TWO_PI) * mult));
     
    speed.add(noiseVec);
    speed.div(4);
    if (hit == true) {        
        position.add(speed.mult(1.55));
    } else {
      position.add(speed.mult(1.28));      
    }
    age++;
    
    return checkBounds();
  }
  
  Boolean checkBounds() {
    int padding = 10;
    if (position.x < -padding || position.x > width + padding ||
      position.y < -padding || position.y > height + padding) {
      return false;
    } else {
      return true;
    }
  }
  
  void paint() {
    colorMode(HSB, 100);
    fill(map(age, 0, maxAge, startColor, endColor),
      100,//map(age, 0, maxAge, 100, 0), 
      100);//map(age, 0, maxAge, 100, 0));      
    noStroke();
    ellipse(position.x, position.y, 2.5, 0.5);
  }
}