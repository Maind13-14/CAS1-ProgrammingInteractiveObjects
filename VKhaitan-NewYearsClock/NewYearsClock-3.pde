int num=60;
int oldSecond;
int oldMinute;
int oldHour;
Flock flock;

void setup() { 
  size(displayWidth,displayHeight, P3D);

  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(0, height));
    noCursor();
  }
}

void draw() {
  background(0);

  //  frameRate(1);
  //  println( "hour" + hour() + " " + "Minute" + minute() + " " + "Second" + second());

  if ( mousePressed) {
    flock.run();
  }

  else

  {
    translate(width/2, height/2);

    rotate(-PI/2);
    blendMode(ADD);

    //SECOND
    float r = 200;
    float g = mouseY;
    float b = 30;

    pushMatrix();
    int sec = second();

    //    if (oldSecond != sec) {
    float s = TWO_PI/num * sec;
    rotate(s);
    //      oldSecond=sec;
    //   }
    clock(400, color(r, g, 0));
    popMatrix();



    //MINUTE




    pushMatrix();
    int min = minute();

    //    if (oldMinute != min) {
    float m = TWO_PI/num * min;
    rotate(m);
    //      oldMinute = min;
    //    }

    clock(200, color(r, g, b));    
    popMatrix();

    //    println( sec +"    " + oldSecond);



    //HOUR



    pushMatrix();
    int hou=hour();
    //    if (oldHour != hou) {      
    float h= TWO_PI/12 * hou;
    rotate(h);
    //      oldHour=hou;
    //    }    
    clock(40, color(255));

    popMatrix();
  }
}


void clock(float r, color c) {
  float angle=TWO_PI/num;
  noStroke();
  pushStyle();
  beginShape(QUAD_STRIP);
  //  float z= mouseY;
  for ( int i=0; i<num+1; i++) {
    float x= cos(angle*i)* r;
    float y= sin(angle*i)* r ;
    float a = 255.0/num * i;
    fill(c, a);
    vertex(0, 0); 
    vertex(x, y);
  }
  endShape();
  popStyle();
}

