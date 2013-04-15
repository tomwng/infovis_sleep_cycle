String[] data;
int[] sleep;
int[] awake;
int count;
int xshift;

// output coordinaries
int currx1, currx2, curry1, curry2;

void setup() {
// reading data
  data = loadStrings("/Users/tom/Desktop/sleep cycle data.txt");
  // data = loadStrings("/Users/charnugagoo/Dropbox/Study/Data Visulization/SleepingCircle/data2.txt");
  count = data.length;
  sleep = new int[count];
  awake = new int[count];
  for(int i=0; i<count; i++) {
    String[] times = split(data[i], ' ');
    println(times);
    sleep[i] = Integer.parseInt(times[0]);
    awake[i] = Integer.parseInt(times[1]);
  }
// setup sketch field
  size(1600, 400);
  currx1 = 0;
  currx2 = currx1 + width;
  curry1 = min(min(sleep), min(awake));
  curry2 = max(max(sleep), max(awake));
} 

void draw() {
  background(240);
  strokeWeight(5);
  for(int i = 0; i < count; i++) {
    float x = map(i * 6, 0, width, xshift, width + xshift);
    float y1 = map(sleep[i], curry1, curry2, 0, height);
    float y2 = map(awake[i], curry1, curry2, 0, height);
    stroke(120); // gray
    line(x, y1, x, y2);
    stroke(0, 0, 120);
    point(x, y1);
    stroke(0, 0, 120);
    point(x, y2);
  }
  
  smooth();
}

void keyPressed() {
  if (key == ',') {
    xshift += 20;
  } else if (key == '.') {
    xshift -= 20;
  } else if (key == '<') {
    xshift += 100;
  } else if (key == '>') {
    xshift -= 100;
  }
}

