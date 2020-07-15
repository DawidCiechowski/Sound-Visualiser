import processing.sound.*;

SoundFile file;
String filePath;
String fileName = "Avicii - Wake Me Up [Metal Cover by UMC].mp3";
Amplitude amp;
ArrayList<Float> al = new ArrayList<Float>();
float vol = 0.5;
int time = millis();
int ss, ms;

void setup() {
  size(500, 500);
  amp = new Amplitude(this);
  filePath = sketchPath(fileName);
  file = new SoundFile(this, filePath);
  file.play();
  amp.input(file);
  file.amp(vol);
  ss = (int) (file.duration() % 60);
  ms = (int) (file.duration() / 60);
}


void draw() {
  background(0);
  stroke(255);
  text(fileName + ": " + nf(ms, 2) + ":" + nf(ss, 2), 20, 20);
  fileDuration();
  al.add(amp.analyze());
  stroke(255);
  noFill();
  beginShape();
  for(int i = 0; i < al.size(); i++) {
    float y = map(al.get(i), 0, 0.5, height, 0);
    vertex(i, y - 40);
  }
  endShape();
  
  stroke(255, 0, 30);
  line(al.size() - 1, height, al.size() - 1, 0);
  
  if(al.size() > 450) {
    al.remove(0);
  }
  
}

void mouseClicked() {
  if(file.isPlaying() == 1) {
    //file.stop();
    noLoop();
  } else {
    file.play();
    amp.input(file);
    ss = (int) (file.duration() % 60);
    ms = (int) (file.duration() / 60);
    loop();
  }
}

void keyPressed() {
  if(key == '+') {
    vol += 0.01;
    file.amp(vol);
    println(vol);
  } else if(key == '-') {
    vol -= 0.01;
    file.amp(vol);
  }
}

void fileDuration() {
  
  if(ms + ss > 0) {
    if(millis() > time + 1000) {
      ss--;
      time = millis();
    }
  }

  
  
  if(ms > 0) {
    if(ss < 0) {
      ss = 59;
      ms--;
    }
  }
}
  
  
