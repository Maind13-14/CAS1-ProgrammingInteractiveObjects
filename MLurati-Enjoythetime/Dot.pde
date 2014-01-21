class Dot {

  PVector position;
  color col;
  float dot_size;
  int d_alpha;

  Dot(float posx, float posy, float dsize, int alpha) {        //constructor
    position = new PVector(posx, posy);
    dot_size = dsize;
    col = 255;
    d_alpha = alpha;
  }

  void paint() {                     //draw a dot
    noStroke();
    fill(col, d_alpha); 
    ellipse(position.x, position.y, dot_size, dot_size);
  }

  //animation of the old/new minute

    void animate(float target_x, float target_y, float target_size, int target_alpha) {

    position.x += (target_x - position.x)*0.08;
    position.y += (target_y - position.y)*0.08;
    dot_size += (target_size - dot_size)*0.08;
    d_alpha += (target_alpha - d_alpha)*0.08;
        
    paint();
  }
}
