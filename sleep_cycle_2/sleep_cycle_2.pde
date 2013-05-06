class LogEntry {
  float begin;
  float duration;
  int year, month, day, hour, minute;
  void set(String entry) {
    String[] s = split(entry, ',');
    begin    = float(s[0]);
    duration = float(s[1]);
    year     = int(s[2]);
    month    = int(s[3]);
    day      = int(s[4]);
    hour     = int(s[5]);
    minute   = int(s[6]);
  }
  int getday() { return day; }
};

LogEntry[] log;

String[] data;
int count;
float first;
float timespan = 16;

void setup() {
// loading data
  data = loadStrings("/Users/tom/Documents/Codes/infovis_sleep_cycle/sleep_cycle_2/sleeplog.csv");
  count = data.length;
  log = new LogEntry[count];
  for(int i = 0; i < count; i++) {
    log[i] = new LogEntry(); // why do we need this line?
    log[i].set(data[i]);
  }
  first = int(log[0].begin);
//  println(log[1234].day);
// setup sketch field
  size(1000, 400);
}

void drawaxis() {
}

void drawtimepoint(float time) {
  float x = map(time, first, first + timespan, 0, width);
  float y = map(cos(time * TWO_PI), -1, 1, height / 4, height * 3 / 4);
  noStroke();
  fill(map(sin(time * TWO_PI), -1, 1, 64, 255), 64, 64);
  ellipse(x, y, max(500 / timespan, 1), 5);
}

void drawtimeperiod(float time, float dur) {
  for(float t = 0; t < dur; t = t + 5.0/1440) {
    drawtimepoint(time + t);
  }
}

void draw() {
  noLoop();
  background(240);
  for(int i = 0; i < count; i++) {
    float x1 = map(log[i].begin, first, first + timespan, 0, width);
    float x2 = map(log[i].begin + log[i].duration, first, first + timespan, 0, width);
    float y = 200;
    strokeWeight(1);
    stroke(128);
    line(x1, y, x2, y);
//    drawtimepoint(log[i].begin);
    drawtimeperiod(log[i].begin, log[i].duration);
  }
  for(int i = int(first); i < int(log[count - 1].begin) + 1; i++) {
    drawtimepoint(i);
  }
}

void keyPressed() {
  switch(key) {
    case '+': case '=':
      timespan *= 2; redraw(); break;
    case '-': 
      timespan /= 2; redraw(); break;
    default: 
      ;
  }
}

