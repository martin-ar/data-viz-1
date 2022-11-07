void calcularMaxMin() {

  for (int i=0; i<6040; i++) {
    partes    = split(indicadores[i+1], ",");
    agro[i]   = float(partes[1]);
    metal[i]  = float(partes[2]);
    petrol[i] = float(partes[3]);
  }
  agroMin   = min(agro);
  agroMax   = max(agro);
  metalMin  = min(metal);
  metalMax  = max(metal);
  petrolMin = min(petrol);
  petrolMax = max(petrol);
  //println(agroMin + " " + agroMax);
  //println(metalMin + " " + metalMax);
  //println(petrolMin + " " + petrolMax);
}

void mapearValores() {

  agropecuario.valor = map(float(partes[1]), agroMin, agroMax, 0, 1); 
  metales.valor      = map(float(partes[2]), metalMin, metalMax, 0, 1);
  petroleo.valor     = map(float(partes[3]), petrolMin, petrolMax, 0, 1);
}

void asignarAmplitud() {

  agropecuario.amplitud = 0.6*height*(agropecuario.valor / (agropecuario.valor+metales.valor+petroleo.valor));
  metales.amplitud      = 0.6*height*(metales.valor      / (agropecuario.valor+metales.valor+petroleo.valor));
  petroleo.amplitud     = 0.4*height*(petroleo.valor     / (agropecuario.valor+metales.valor+petroleo.valor));
}

void animarGraficos() {

  agropecuario.mover();
  metales.mover();
  petroleo.mover();
  agropecuario.dibujar();
  metales.dibujar();
  petroleo.dibujar();
}

void mandarSMS(){
  
  OscMessage mensaje1 = new OscMessage("/coordenadas");
    
    mensaje1.add(agropecuario.valor);  //float entre 0 y 1
    mensaje1.add(agropecuario.y1);     //float entre 0 y 1600
    mensaje1.add(metales.valor);
    mensaje1.add(metales.y1);
    mensaje1.add(petroleo.valor);
    mensaje1.add(petroleo.y1);
    oscP5.send(mensaje1, pablo);
    oscP5.send(mensaje1, manu);
    
    //println(agropecuario.valor + "///" + agropecuario.y1 + "///" +metales.valor + "///" + metales.y1); 
}

void dibujarHUD() {
  
  int k = 5;
  fill(255);
  noStroke();
  rect(k+10, k, k*95, 20);
  
  //stroke(255,0,0);
  //strokeWeight(2);
  //line(width-20,0,width-20,height);
  
  
  fill(0);
  text(partes[0], 20, 20);
  text("AG " + agropecuario.valor, k+120, 20);
  text("ME " + metales.valor, k+245, 20);
  text("PE " + petroleo.valor, k+375, 20);
}
