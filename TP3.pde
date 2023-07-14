class Boton{
  boolean esPresionado = false;
  String texto;
  int x;
  int y;
  int largo;
  int alto;
  boolean estado;
  
  public Boton(String texto,int largo,int alto,boolean estado_){
    this.texto=texto;
    this.largo=largo;
    this.alto=alto;
    this.estado=estado_;
  }
  
 
  
  void dibujarBoton(int x, int y,int distTexto){
    this.x=x;
    this.y=y;
     overRect(x, y, largo, alto);
     if(estado){
       if (esPresionado) {
         fill(color(200,200,200,90));
       }else {
         fill(color(151,151,151,90));
       }
       
       stroke(255);
       rect(x, y,largo, alto);
       stroke(0);
       fill(255);
       textFont(createFont("Arial Bold Italic", 24)); // Fuente en negrita
       textAlign(CENTER, CENTER); 
       text(texto,x+distTexto,y+20);
     }
  }
  
  void overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      esPresionado = true;
    } else {
      esPresionado = false;
    }
  }
}


class Secuencia{
  String rutaImg;
  Texto texto;
  

  
  Secuencia(String rutaImg, Texto texto){
    this.rutaImg=rutaImg; 
    this.texto=texto;
  }
  
  
  public void dibujar(){
    texto.dibujar();
  }
}


class Texto{
  String texto;
  int tam;
  int r;
  int g;
  int b;
  int posX;
  int posY;
  int ancho;
  int alto;
  
  Texto(String texto, int tam, int r, int g, int b,int ancho, int alto){
    this.texto=texto;
    this.tam=tam;
    this.r=r;
    this.g=g;
    this.b=b;
    this.ancho=ancho;
    this.alto=alto;
    this.posX=100;
    this.posY=50;
  }
  

  public void dibujar(){
    fill(200, 200, 200,150);//color de rectangulo
    rect(posX, posY, ancho, alto);//rectangulo
    fill(r, g, b);//color de letra
    textFont(createFont("Arial Bold Italic", tam)); // Fuente en negrita
    textAlign(CENTER, CENTER); 
    text(texto,posX,posY,ancho,alto);
    
  }
}


Secuencia[] secuencias;
Secuencia secuencia;
Boton btnOpcionA;
Boton btnOpcionB;
Boton btnOpcionC;
Boton btnVerdadero;
Boton btnFalso;
Boton btnPantalla;
Boton btnFinalAlter;
Boton btnIniciar;
Boton btnCreditos;
Boton btnAtras;
PImage  f;
int pos;
boolean msjError;
String estado;
String subEstado;

void setup() {
  estado="inicio";
  subEstado="";
  size(600, 600);//tamaño pantalla: w,h
  background(255); //fondo blanco
  pos=0;
  msjError=false;
  secuencias= new Secuencia[9];
  secuencia= new Secuencia("",new Texto("",17,23,27,143,400,150));
  
  
  secuencias[0]= new Secuencia("1.jpg",new Texto("Cenicienta es una joven maltratada por su madrastra y hermanastras,tras la muerte de su padre. A pesar de todo, Cenicienta conserva una actitud amable y optimista",17,23,27,143,400,150));
  secuencias[1]=new Secuencia("2.png",new Texto("Un día, el príncipe anuncia un baile en el palacio real.",17,23,27,143,400,150));
  secuencias[2]=new Secuencia("3.png",new Texto("Cenicienta no puede asistir debido a las órdenes de su madrastra.",17,23,27,143,400,150));
  secuencias[3]=new Secuencia("4.png",new Texto("Su hada madrina aparece para:(A).-Transformarla en una joven hermosa y presentable para la fiesta. (B).- Ayudarle con la limpieza",17,23,27,143,400,150));
  secuencias[4]=new Secuencia("5.png",new Texto("Cenicienta asiste al baile y captura la atención del príncipe, quien se enamora de ella. (A).-Bailan toda la noche.  (B).- Nunca se saludan",17,23,27,143,400,150));
  secuencias[5]=new Secuencia("6.png",new Texto("Pero Cenicienta debe irse antes de la medianoche, momento en que su encantamiento se desvanecerá. En su prisa, pierde un: (A).- Zapato de cristal. (B).- Un brazalete (C).- Una cartera",17,23,27,143,400,150));
  secuencias[6]=new Secuencia("7.png",new Texto("El príncipe encuentra el zapato y decide buscar a la dueña en: (A).- Todo el reino, (B).- solo en el castillo. Muchas jóvenes intentan probárselo",17,23,27,143,400,150));
  secuencias[7]=new Secuencia("8.png",new Texto("Pero solo Cenicienta logra que le ajuste perfectamente.",17,23,27,143,400,150));
  secuencias[8]=new Secuencia("9.png",new Texto("El príncipe y Cenicienta se encuentran nuevamente y deciden casarse, viviendo felices para siempre.",17,23,27,143,400,150));
  f = loadImage("inicio.png");
  
  btnOpcionA= new Boton("A",80,40,true);
  btnOpcionB= new Boton("B",80,40,true);
  btnOpcionC= new Boton("C",80,40,true);
  btnVerdadero= new Boton("Verdadero",150,40,true);
  btnFalso= new Boton("Falso",120,40,true);
  btnPantalla= new Boton("",width,height,false);
  btnFinalAlter= new Boton("Final Alternativo",200,40,true);
  btnIniciar= new Boton("Iniciar",140,40,true);
  btnCreditos= new Boton("Créditos",140,40,true);
  btnAtras= new Boton("Inicio",140,40,true);

}

void draw() {
   imageMode(CORNER);         //especificar por esquina superior izquierda
   image(f,0,0,width,height); //mostrar imagen con esquina sup izq en 0,0 y tamaño de pantalla
   //mostrar botones
   if(pos==2){
     subEstado="mostrarVerdadFalso";
   }else if(pos==3 || pos==4 || pos==6){
     subEstado="botonAB";
   }else if(pos==5){
     subEstado="botonABC";
   }
   else if(pos==7){
     subEstado="";
   }
   else if(pos==8){
     subEstado="botonFinalAlter";
   }
   
   if(pos==secuencias.length-1){
     subEstado="";
     estado="fin";
   } 
   
   //mostrar imagenes
   if(estado.equals("inicio")){
     btnIniciar.dibujarBoton(220,220,70);
     btnCreditos.dibujarBoton(220,290,70);
   }
   else if(estado.equals("creditos")){
     fill(255, 0, 0);
     textFont(createFont("Arial Bold Italic", 40));
     text("CREDITOS",290,50);
     textSize(30);
     text("Director",150,150);
     text("Mateo Cordova",410,150);
     text("Artista",150,230);
     text("Mateo Cordova",410,230);
     text("Programador",150,310);
     text("Mateo Cordova",410,310);
     btnAtras.dibujarBoton(220,500,70);
   }
   else if(estado.equals("comenzar")){
     if(msjError){
       fill(255, 0, 0);
       text("¡Opción incorrecta!", width/2, height/2);
     }
     else if(subEstado.equals("")){
       secuencias[pos].dibujar();
       btnPantalla.dibujarBoton(0,0,0);
     }else if(subEstado.equals("mostrarVerdadFalso")){
       secuencias[pos].dibujar();
       btnVerdadero.dibujarBoton(50,220,70);
       btnFalso.dibujarBoton(400,220,60);
     }else if(subEstado.equals("botonAB")){
       secuencias[pos].dibujar();
       btnOpcionA.dibujarBoton(50,220,40);
       btnOpcionB.dibujarBoton(460,220,40);
     }else if(subEstado.equals("fin")){
       secuencia.dibujar();
       btnPantalla.dibujarBoton(0,0,0);
     }
     else if(subEstado.equals("botonABC")){
       secuencias[pos].dibujar();
       btnOpcionA.dibujarBoton(50,220,40);
       btnOpcionB.dibujarBoton(250,220,40);
       btnOpcionC.dibujarBoton(460,220,40);
     }
     
     
   }else if(estado.equals("fin") && !subEstado.equals("fin")){
     pos=-1;
     btnPantalla.dibujarBoton(0,0,0);
     btnFinalAlter.dibujarBoton(50,500,100);
   }else if(estado.equals("fin") && subEstado.equals("fin")){
     secuencia.dibujar();
     btnPantalla.dibujarBoton(0,0,0);
   }
   
}

void keyPressed() {

  msjError = false;
}



void mousePressed() {
  if(btnCreditos.esPresionado){
    estado="creditos";
    f = loadImage("creditos.png");
    btnCreditos.esPresionado=false;
  }
  
  if(btnAtras.esPresionado){
    estado="inicio";
    f = loadImage("inicio.png");
    btnAtras.esPresionado=false;
  }
  
  if(btnIniciar.esPresionado){
    estado="comenzar";
    subEstado="";
    pos=0;
    f = loadImage(secuencias[pos].rutaImg);
    btnIniciar.esPresionado=false;
  }
  
  if(btnPantalla.esPresionado){
    if(pos!=-1){
      pos++;
      f = loadImage(secuencias[pos].rutaImg);
      btnPantalla.esPresionado=false;
    }else{
       estado="creditos";
       f = loadImage("creditos.png");
        btnPantalla.esPresionado=false;
    }
  }
  
  if(btnVerdadero.esPresionado){
    pos++;
    f = loadImage(secuencias[pos].rutaImg);
    btnVerdadero.esPresionado=false;
  }
  
  if (btnOpcionA.esPresionado) {
    pos++;
    f = loadImage(secuencias[pos].rutaImg);
    btnOpcionA.esPresionado=false;
  }
  
  if(btnFalso.esPresionado){
    subEstado="fin";
    pos=-1;
    secuencia.rutaImg="final1Alternativo.png";
    secuencia.texto.texto="El Hada madrina nunca apareció frente a cenicienta, por lo cual nunca conocio al príncipe y nunca pudo ser feliz.";
    f = loadImage(secuencia.rutaImg);
    btnFalso.esPresionado=false;
  }
  
  if(btnOpcionB.esPresionado && pos!=6){
    subEstado="error";
    msjError=true;
    btnOpcionB.esPresionado=false;
  }
  
  if(btnOpcionB.esPresionado && pos==6){
    subEstado="fin";
    pos=-1;
    secuencia.rutaImg="tercerFinal.png";
    secuencia.texto.texto="La madrastra de cenicienta la encierra para siempre por lo que nuca conocerá al príncipe y nunca vivirá feliz.";
    f = loadImage(secuencia.rutaImg);
    btnOpcionB.esPresionado=false;
  }
  
  if(btnOpcionC.esPresionado){
    subEstado="error";
    msjError=true;
    btnOpcionC.esPresionado=false;
  }
  
  if(btnFinalAlter.esPresionado){
    subEstado="fin";
    estado="fin";
    pos=-1;
    secuencia.rutaImg="4FinalAlternativo.png";
    secuencia.texto.texto="Despues de mucho tiempo, El Príncipe muere de una enfermedad dejando sola a cenicienta.";
    f = loadImage(secuencia.rutaImg);
    btnFinalAlter.esPresionado=false;
  }
  
}
