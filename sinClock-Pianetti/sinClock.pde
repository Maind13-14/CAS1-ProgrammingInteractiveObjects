
int xspacing = 2;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude ; // Height of wave
float period = 1200.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave



float secX ;
float secY;

void setup() {
  size(displayWidth, displayHeight);

  //parte del sin copiato


  w = width*2;
  dx = (TWO_PI / period) * xspacing; 
  yvalues = new float[w/xspacing];
}

void draw() {

  background(255);
  fill(0);

  //altezza onda sin

  amplitude = 30+12*hour();  





  pushStyle();
  strokeWeight(0.2);
  stroke(0);
  //  line(width/2,0, width/2,height); 
  //  line(0,height/2, width, height/2);
  //linee
  pushMatrix();
  translate(width/2, height/2);




  //disegno segnalatori per minuti
  for (int i=15; i<45; i++) {
    if (minute()>= 15 && minute()<= 45) {
      line(cos(i*(TWO_PI/60)-TWO_PI/4)*300, 0, cos(i*(TWO_PI/60)-TWO_PI/4)*300, height/2);

if (i >= 17 && i <= 43) {
      textSize(7);
      text(i, cos(i*(TWO_PI/60)-TWO_PI/4)*300, height/2-100);
}
    }
    else {
      line(cos(i*(TWO_PI/60)-TWO_PI/4)*300, 0, cos(i*(TWO_PI/60)-TWO_PI/4)*300, -height/2);
    }
  }
if (minute() >= 45 || minute() <= 15){
  for (int i=46; i<59; i++) {

    textSize(7);
    text(i+1, cos((i+1)*(TWO_PI/60)-TWO_PI/4)*300, -height/2+100);
  }
  for (int i=0; i<14; i++) {

    textSize(7);
    text(i, cos(i*(TWO_PI/60)-TWO_PI/4)*300, -height/2+100);
  }
}


  pushStyle();
  noStroke();

  // ellipse(0,0,600,600);
  //   
  popStyle();

  //disegno linee 
  pushStyle();
  strokeWeight(0.1);
  for (int i=0; i<24; i++)
  {
    if (minute()>= 15 && minute()<= 45) {
      line(-width/2, -(30+12*i), width/2, -(30+12*i));
      textSize(7);
      fill(0);
      text(i, 600, -(30+12*i));
    }
    else {
      line(-width/2, 30+12*i, width/2, 30+12*i);
      textSize(7);
      fill(0);
      text(i, 600, (30+12*i));
    }
  }
  popStyle();


  popMatrix();

  popStyle(); 


  secX = width/2+(cos(minute()*(TWO_PI/60)-TWO_PI/4)*300);
  secY = height/2+(sin(minute()*(TWO_PI/60)-TWO_PI/4)*300);


  calcWave();
  renderWave();
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.03;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    
    yvalues[i] = (sin(x*second()/2))*amplitude;
   
    x+=dx;
    
  }
}

void renderWave() {

  fill(255);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    strokeWeight(2);
    point(width/2-w/2+x*xspacing, height/2+yvalues[x]);
    if (x % 20 == 0) {
      strokeWeight(0.2);
      line(width/2-w/2+x*xspacing, height/2+yvalues[x], secX, secY);
    }
  }
}

