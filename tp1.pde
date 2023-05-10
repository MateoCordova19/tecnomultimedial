class Texto{
  String texto;
  int tam;
  int r;
  int g;
  int b;
  int posX;
  int posY;
  int velocidad;
  int opMovimiento;
  int ancho;
  int alto;
  
  Texto(String texto, int tam, int r, int g, int b, int velocidad,int opMovimiento,int ancho, int alto){
    this.texto=texto;
    this.tam=tam;
    this.r=r;
    this.g=g;
    this.b=b;
    this.opMovimiento=opMovimiento;
    this.ancho=ancho;
    this.alto=alto-50;
    this.velocidad=velocidad;
    establecerPosicion(); 
  }
  
  public void establecerPosicion(){
     if(opMovimiento==1){
        posX=0;
        posY=alto/2-50;
     }else if(opMovimiento==2){
        posX=this.ancho/2-200;
        posY=0;
     }else if(opMovimiento==3){
        posX=this.ancho/2-200;
        posY=this.alto;
     }  
  }
  
  public void moverDerecha(){
    if(posX<(this.ancho/2)-200) posX+=velocidad;
  }
  
  public void moverAbajo(){
    if(posY<(this.alto/2)-50) posY+=velocidad;
  }
  
  public void moverArriba(){
    if(posY>(this.alto/2)-50) posY-=velocidad;
  }
  
  public void dibujar(){
    if(opMovimiento==1)moverDerecha();
    else if(opMovimiento==2)moverAbajo();
    else if(opMovimiento==3) moverArriba();
    
    noStroke();
    fill(200, 200, 200,150);
    rect(posX-10, posY-30, 500, 240);
    
    textSize(tam);
    fill(r, g, b);
    text(texto,posX,posY);
    
  }
}


class Diapositiva{
  String imagen;
  Texto texto;

  
  Diapositiva(String imagen, Texto texto){
    this.imagen=imagen;
    this.texto=texto;
  }
  
  public void dibujar(){
    texto.dibujar();
  }
}

boolean rectOver = false;

PImage  f;
ArrayList<Diapositiva> diapositivas;
int pos;
void setup() {
  size(800,800);   //zona interactiva  
  background(255); //fondo blanco
  frameRate(30);   //FPS: cuadros por segundo
  
  pos=0;
  diapositivas = new ArrayList<Diapositiva>();
  diapositivas.add(new Diapositiva("leon1.jpg",new Texto("El león es un mamífero carnívoro\nde la familia de los félidos.\nEl león es el segundo félido viviente más grande\n después del tigre, con unas extremidades potentes,\n una fuerte mandíbula y unos dientes caninos\n de ocho centímetros, el león puede matar grandes presas",20,23,27,143,3,(int)(Math.random()*3+1),width,height)));
  diapositivas.add(new Diapositiva("leon2.jpeg",new Texto("Los leones salvajes viven en poblaciones cada vez más\n dispersas y fragmentadas del África subsahariana \n y una pequeña zona del noroeste de India (una población \nen peligro crítico en el parque nacional del Bosque de Gir\n y alrededores), habiendo desaparecido del resto de Asia \ndel Sur, Asia Occidental, África del Norte y la península\n balcánica en tiempos históricos.",20,18,117,50,3,(int)(Math.random()*3+1),width,height)));
  diapositivas.add(new Diapositiva("leon3.jpg",new Texto("Los leones son animales potentes que suelen cazar en\n grupos coordinados y sitian la presa elegida. Sin embargo,\n no tienen una resistencia particularmente elevada, Las\nhembras pueden alcanzar una velocidad punta de unos\n 59 km/h; solo lo pueden hacer en rápidas, pero cortas\n aceleraciones",20,235,51,36,3,(int)(Math.random()*3+1),width,height)));

  f = loadImage(diapositivas.get(pos).imagen);
}



void draw() {
  
  
  imageMode(CORNER);         //especificar por esquina superior izquierda
  image(f,0,0,width,height-50); //mostrar imagen con esquina sup izq en 0,0 y tamaño de pantalla
  
  diapositivas.get(pos).dibujar();
  if(frameCount%250==0){
     pos++;
    if(pos==diapositivas.size()) pos=0;
    f = loadImage(diapositivas.get(pos).imagen);
    diapositivas.get(pos).texto.establecerPosicion(); 
  }
  
  fill(color(255));
  noStroke();
  rect(0, height-50, width, 50);
  
  overRect(10, height-50, 200, 40);
  if (rectOver) {
    fill(color(51));
  } else {
    fill(color(0));
  }
  stroke(255);
  rect(10, height-45, 200, 40);
  stroke(0);
  fill(255);
  textSize(18);
  text("Ir a primera diapositiva",20,height-20);
  
}

void mousePressed() {
  if (rectOver) {
    pos=0;
    f = loadImage(diapositivas.get(pos).imagen);
    diapositivas.get(pos).texto.establecerPosicion();
    frameCount=0;
  }
}

void overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}
