import oscP5.*;
import netP5.*;

Grafico agropecuario, petroleo, metales;

OscP5 oscP5;
NetAddress pablo, manu;

String [] indicadores;
String [] partes;
float  [] agro   = new float[6040];
float  [] metal  = new float[6040];
float  [] petrol = new float[6040];

int indice = 4;
float agroMin, metalMin, petrolMin;
float agroMax, metalMax, petrolMax;

int tRef = millis();
int tRef2 = millis();
int tEspera = 24;
int tEspera2 = 500;
float velocidad;

int resolucion = 1;
PImage HUD;

void setup() {


  fullScreen();
  background(255);
  noCursor();
  
  oscP5 = new OscP5(this,4000);                         
  pablo = new NetAddress("192.168.0.115",4001);
  manu  = new NetAddress("192.168.0.121", 4009);
  
  

  indicadores = loadStrings("indice-precios-materias-primas-2001-2018.csv");
  calcularMaxMin();

  agropecuario = new Grafico(int(height*0.20), resolucion, color(145, 214, 212));
  metales      = new Grafico(int(height*0.5),  resolucion, color(184, 143, 240));
  petroleo     = new Grafico(int(height*0.80), resolucion, color(240, 170, 143));
  
  HUD = createImage(width,height,RGB); 
}

void draw() {

  if (millis()-tRef > tEspera) {

    partes = split(indicadores[indice], ",");
    tRef = millis();

    mapearValores();
    asignarAmplitud();
    dibujarHUD();
    animarGraficos();
    
    indice ++;

    if (indice == 4041) {
      indice = 2;
    }
  }
  
  if(millis()-tRef2 > (tEspera2)){
     
    mandarSMS();
    tRef2 = millis();
  }
}

void oscEvent(OscMessage theOscMessage) {

  println(theOscMessage.addrPattern());
  
  if (theOscMessage.checkAddrPattern("/cantidad") == true) {

  
    velocidad   =  theOscMessage.get(1).floatValue();
    tEspera =  int(map(velocidad,70,150,80,1));
    println("velocidad" + tEspera);
  }
}
