//Title: Enjoy the time
//Author: Marco Lurati
//Teacher: Andreas Gysin
//Course: 1.2 Programming Interactive Objects 1
//Year: 2013
//License: CC-BY


ArrayList <Dot> dots;

int minutes, oldMinute, targetL_alpha, targetC_alpha;
float dotC_size, d_dots, margin, targetL_x, targetL_y, targetL_size, targetC_x, targetC_y, targetC_size;


String minText;

color bgcolor = color(random(30, 210), random(30, 210), random(30, 210));

PFont minFont;

float delta_dots = 2;    //distance between each dot
float motion = 0.08;     //factor to slow down the animation

int d_alphaL = 150;      //alpha value left dots
int d_alphaR = 255;      //alpha value right dots
int d_alpha = 255;       //alpha value center dot

void setup() {

  size(displayWidth, displayHeight, P2D);
  smooth(4);
  frameRate(60);

  d_dots = height/100;            //dots diameter
  dotC_size = height/3;           //diameter of the cercle on the center

  minFont = createFont("BubblerOne-Regular.ttf", width/30);      //minute font

  dots = new ArrayList();
  generate(1);                    //function that generate the x and y position of each minute

  for (Dot d: dots) {             //draw each dot
    d.paint();
  }
}

void draw() {  

  background(bgcolor);

  if (oldMinute != minute()) {                //minute triggered function

    minutes = hour()*60 + minute(); 

    dots.clear();
    float margin = generate(1);                     //return the margin


    if ((height-dots.get(minutes-2).position.y) < (d_dots+delta_dots+margin)) {       //if the left column of dot is full
      targetL_x =   dots.get(minutes-2).position.x+d_dots+delta_dots;                 //the target position for the center dot is a new colum on top
      targetL_y =   margin+d_dots/2;
      targetL_size = dots.get(minutes-2).dot_size;

      targetC_x =   dots.get(minutes-1).position.x;
      targetC_y =   dots.get(minutes-1).position.y;
      targetC_size = dots.get(minutes-1).dot_size;
    }
    else {                                                                            //if the column is not full
      targetL_x =   dots.get(minutes-2).position.x;                                   //the target position for the center point is after the last point in the column
      targetL_y =   dots.get(minutes-2).position.y+d_dots+delta_dots;
      targetL_size = dots.get(minutes-2).dot_size;

      targetC_x =   dots.get(minutes-1).position.x;
      targetC_y =   dots.get(minutes-1).position.y;
      targetC_size = dots.get(minutes-1).dot_size;
    }

    bgcolor = color(random(30, 210), random(30, 210), random(30, 210));              //new random background color

    oldMinute = minute();
  }


  //get the position of the dot representing the past minute and animate it

  dots.get(minutes-1).animate(targetL_x, targetL_y, targetL_size, d_alphaL);

  //get the position of the dot representing the actual minute and animate it

  dots.get(minutes).animate(targetC_x, targetC_y, targetC_size, d_alphaR);


  for (Dot d: dots) {              //draw each dot
    d.paint();
  }


  //actual minute as text  

    if (minute()<10) {                       
    minText = "0" + minute();
  }
  else {
    minText = "" + minute();
  }

  pushStyle();                              
  pushMatrix();
  fill(bgcolor);
  textFont(minFont);
  textAlign(CENTER);
  text(minText, width/2, height/2+textDescent());
  popMatrix();
  popStyle();


  stroke(255, 100);

  pushMatrix();                        //hour needle
  strokeWeight(10);
  translate(width/2, height/2);
  rotate((TWO_PI/12*hour())-PI/2);
  line(dotC_size/2+d_dots*1.5, 0, dotC_size/2+4*d_dots, 0);
  popMatrix();

  pushMatrix();                        //second needle
  strokeWeight(4);
  translate(width/2, height/2);
  rotate((TWO_PI/60*second())-PI/2);
  line(dotC_size/2+d_dots, 0, dotC_size/2+2*d_dots, 0);
  popMatrix();
}


//GENERATE DOTS COORDINATES

float generate(float margin) {                 

  float dot_x, dot_y;                            //dot coordinate
  int minutesDay = 24*60;                        //minutes in a day


  int num_col_left;                                    //number of columns left
  int num_dot_left = hour() * 60 + minute() -1;        //dots on the left (passed minutes)

  int num_col_right;                                   //numer of columns left
  int num_dot_right = minutesDay - num_dot_left -1;    //dots on the right(left minutes)


  int num_dot_col = (int)(height/(d_dots+delta_dots));  //number of dots on each column
  margin = (height - num_dot_col*(d_dots+delta_dots) + delta_dots)/2;


  //LEFT SIDE DOTS

  d_alpha = d_alphaL;

  int rest_dot_left = (num_dot_left % num_dot_col);    

  if ( rest_dot_left != 0) {                            //if there is a rest add one column
    num_col_left = num_dot_left / num_dot_col + 1;
  }   
  else {                                                 //no rest condition
    num_col_left = num_dot_left / num_dot_col;
  }


  for (int i=0; i<num_col_left; i++) {                                //external loop for x coordinate
    dot_x = margin + d_dots/2 + i * (d_dots + delta_dots);

    //internal loop for y coordinate

    if (rest_dot_left !=0 && (i+1) == num_col_left) {                     //if last column non full of dots
      for (int j=0; j<rest_dot_left; j++) {
        dot_y = margin + d_dots/2 + j * (d_dots+delta_dots);
        dots.add(new Dot(dot_x, dot_y, d_dots, d_alpha));
      }
    }
    else {
      for (int j=0; j<num_dot_col; j++) {
        dot_y = margin + d_dots/2 + j * (d_dots+delta_dots);
        dots.add(new Dot(dot_x, dot_y, d_dots, d_alpha));
      }
    }
  }

  //CENTER DOT

  dots.add(new Dot(width/2, height/2, dotC_size, d_alpha));                            //actual minute dot


  //RIGHT SIDE DOTS

  d_alpha = d_alphaR;

  int rest_dot_right = (num_dot_right % num_dot_col);

  if ( rest_dot_right != 0) {                        //if there is a rest add one column
    num_col_right = num_dot_right / num_dot_col + 1;
  }   
  else {                                      //no rest condition
    num_col_right = num_dot_right / num_dot_col;
  }


  for (int i=0; i<num_col_right; i++) {                                //external loop for x coordinate
    dot_x = width - (margin + d_dots/2 + (num_col_right - 1) * (d_dots + delta_dots) - i * (d_dots + delta_dots));

    //internal loop for y coordinate
    if (rest_dot_right !=0 && i == 0) {                      //if first column right non full of dots
      for (int j=0; j<rest_dot_right; j++) {
        dot_y = height - (margin + d_dots/2 + (rest_dot_right - 1) * (d_dots+delta_dots) - j * (d_dots+delta_dots));
        dots.add(new Dot(dot_x, dot_y, d_dots, d_alpha));
      }
    }
    else {
      for (int j=0; j<num_dot_col; j++) {
        dot_y = margin + d_dots/2 + j * (d_dots+delta_dots);
        dots.add(new Dot(dot_x, dot_y, d_dots, d_alpha));
      }
    }
  }
  return margin;
}
