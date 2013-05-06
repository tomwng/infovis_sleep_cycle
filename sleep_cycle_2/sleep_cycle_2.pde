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
  int getday() { 
    return day;
  }
};

LogEntry[] log;

String[] data;
int count;
int first;
float timespan = 12;
int offset = 0;

void setup() {
  // loading data
  data = loadStrings("/Users/tom/Documents/Codes/infovis_sleep_cycle/sleep_cycle_2/sleeplog.csv");
  count = data.length;
  log = new LogEntry[count];
  for (int i = 0; i < count; i++) {
    log[i] = new LogEntry(); // why do we need this line?
    log[i].set(data[i]);
  }
  first = int(log[0].begin);
  // setup sketch field
  size(1000, 400);
}

void drawaxis() {
}

void drawtimepoint(float time) {
  float x = map(time, first + offset, first + timespan + offset, 0, width);
  float y = map(cos(time * TWO_PI), -1, 1, height / 4, height * 3 / 4);
  noStroke();
  // stripe color: red in 0:00 - 12:00, gray in 12:00 - 23:59 
  fill(map(sin(time * TWO_PI), -1, 1, 64, 255), 64, 64);
//  ellipse(x, y, max(500 / timespan, 1), 5);
  float w = max(800 / timespan, 1) / 2; // width of rect
  rect(x - w / 2, y - 4, w, 8);
}

void drawtimeperiod(float time, float dur) {
  for (float t = 0; t < dur; t = t + 5.0 / 1440) {
    drawtimepoint(time + t);
  }
}

void draw() {
  noLoop();
  background(240);
  for (int i = 0; i < count; i++) {
    if(log[i].begin + log[i].duration >= first + offset &&
       log[i].begin <= first + timespan + offset) {
      drawtimeperiod(log[i].begin, log[i].duration);
    }
  }
}

void keyTyped() {
  switch(key) {
  case '_': case '-': timespan *= 2; break;
  case '+': case '=': timespan /= 2; break;
  case ',': offset -= 1; break;
  case '.': offset += 1; break;
  case '<': offset -= 7; break;
  case '>': offset += 7; break;
  case 'R': case 'r': offset = 0; break;
  }
  redraw();
}

