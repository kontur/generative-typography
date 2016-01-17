import java.lang.System;

ArrayList <Particle> p = new ArrayList<Particle>();
PImage last;
ArrayList <PVector> spawnPositions = new ArrayList<PVector>();
int maxParticles = 5000;
PFont f;
String fontName = "OpenSans-Bold.ttf";
int fontSize = 800;
String word = "K";

// set this flag to record into the output folder
boolean record = true;
long ts;

void setup () {
  ts = System.currentTimeMillis();
  frameRate(24);
  fullScreen();
  background(0);
  
  f = createFont(fontName, fontSize);
  textFont(f);

  // create a decent amount of particles right away
  for (int i = 0; i < maxParticles / 4; i++) { 
    createParticle();
  }
}

void draw () {
  last = get();
  
  if (p.size() < maxParticles) {
    for (int i = 0; i < (maxParticles - p.size()); i++) {
      createParticle();
    }
  }
  
  fill(255, 255, 255);
  rect(0, 0, width, height);
  fill(color(0));
  textAlign(CENTER, CENTER);
  textSize(fontSize);
  text(word, width / 2 , height / 2 - fontSize / 10);
    
  for (int i = 0; i < p.size(); i++) {
    Particle check = p.get(i);    
    if (get((int)check.position.x, (int)check.position.y) == color(0)) {
      check.hit = true;
      check.enterAge = check.age;
      spawnPositions.add(new PVector((int)check.position.x, (int)check.position.y));
    } else {
      check.hit = false;
      check.enterAge = 0;
    }    
  }
  
  image(last, 0, 0);
  fill(0, 25);
  rect(0, 0, width, height);
  
  for (int i = 0; i < p.size(); i++) {
    Particle part = p.get(i);    
    Boolean alive = part.update(frameCount);
    if (!alive || part.age > part.maxAge) {
      p.remove(i);
    } else {
      part.paint();
    }    
  }
  
  if (record) {
    saveFrame("output/" + ts + "/frame-######.png");
  }
}
  
void createParticle() {
  if (p.size() < maxParticles) {
    int size = spawnPositions.size();
    int maxSize = maxParticles * 2;
    PVector spawnPoint = new PVector(random(width), random(height));
    if (size < maxParticles / 10) {
      spawnPositions.add(spawnPoint);
    } else {
      spawnPoint = spawnPositions.get((int)random(spawnPositions.size() - 1));
      if (size > maxSize) {
        spawnPositions = new ArrayList<PVector>(spawnPositions.subList(0, size));
      }
    }
    p.add(new Particle(spawnPoint));
  }
}