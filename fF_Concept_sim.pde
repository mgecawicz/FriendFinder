int red = #FF892E;
int green = #52FFAA;
int blue = #529BFF;
int yellow = #EAD728;
int locked = #FF9831;

int connectionNumber = 0;

int[] colors = {red, green, blue, yellow, locked};

Circle c;
int numballs = 20;

ArrayList<Circle> circles;

boolean connected = false;

void setup() {
  fullScreen();


  smooth();
  //background(0);

  circles = new ArrayList<Circle>();
}

//circles.add(new Circle(random(25,width-25),random(25,height-25)));


void draw() {
  background(255);
  
  //text("Number of Connections: "+connectionNumber,width-200,50);

  key();

  newCircle();

  for (Circle c : circles) {
    c.move();
    c.show();

    for (Circle other : circles) {
      if (c != other) {
        float d = dist(c.x, c.y, other.x, other.y);
        if (d < c.r/2+other.r/2 && c.pick_fin == other.pick_fin) {
          stroke(0);
          strokeWeight(1);
          line(c.x, c.y, other.x, other.y);
        }
      }
    }
  }
  saveFrame();
}



void key() {
  textSize(10);
  text("INTERESTS:", 20, 20);
  fill(red, 100);
  rect(20, 40, 20, 50);
  textSize(10);
  fill(0);
  text("SPORTS", 50, 60);

  fill(green, 100);
  rect(20, 100, 20, 50);
  textSize(10);
  fill(0);
  text("PAINTING", 50, 120);

  fill(blue, 100);
  rect(20, 160, 20, 50);
  textSize(10);
  fill(0);
  text("POLITICS", 50, 180);

  fill(yellow, 100);
  rect(20, 220, 20, 50);
  textSize(10);
  fill(0);
  text("CODING", 50, 240);
}

void newCircle() {

  float x = random(70, width-70);
  float y = random(70, height-70);

  boolean valid = true;

  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);

    if (d < c.r*2) {
      valid = false;
      break;
    }
  }

  if (valid && circles.size() <= numballs) {
    circles.add(new Circle(x, y));
  }
}
class Circle {
  float x;
  float y;
  float r;
  float dx;
  float dy;
  float R;
  float G;
  float B;
  float Alpha;

  float a;
  float b;

  float pick_raw = random(0, 3);
  int pick_fin = round(pick_raw);

  Circle(float x_, float y_) {
    x = x_;
    y = y_;

    r = 100;
    dx = random(-1, 1);
    dy = random(-1, 1);
    R = random(4);
    G = random(4);
    B = random(4);
    Alpha = 100;
  }

  void move() {
    x = x + dx;
    y = y + dy;

    if (x >= width-r-5 || x <= r+5) {
      dx *= -1;
    }
    if (y >= height-r-5 || y < r+5) {
      dy *= -1;
    }
  }

  void bounce() {
    R = 0;
    G = 255;
    //dx *= -1;
    //dy *= -1;
  }

  void bounce_off() {
    R = 255;
    G = 0;
    //dx *= -1;
    //dy *= -1;
  }

  void show() {
    a = x;
    b = y;

    noStroke();
    fill(colors[pick_fin], Alpha);
    ellipse(x, y, r*2, r*2);

    stroke(0);
    fill(0);
    ellipse(a, b, 10, 10);
  }
}