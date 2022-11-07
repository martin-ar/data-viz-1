class Grafico {

  float x, y1, y2;
  float valor;
  float amplitud;
  color c;
  int resolucion;

  Grafico(int _y2, int _resolucion, color _c) {
    
    x = width;
    y2 = _y2;
    c = _c;
    resolucion = _resolucion;
  }

  void dibujar() {
    strokeWeight(resolucion);
    strokeCap(SQUARE);

    noStroke();
    fill(250);
    rect(width-1, 0, resolucion, height);

    stroke(c);
    strokeWeight(resolucion*3);
    line(x-resolucion, y1, x, y2);
    line(x-resolucion, y1, x, (y2-amplitud));
    copy(0, 0, width, height, 
         0-resolucion, 0, width, height);
  }

  void mover() {

    x  = width-1;
    y1 = y2 + amplitud;
  }
}
