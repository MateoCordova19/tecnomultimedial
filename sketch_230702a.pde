//video de recuperatorio: //https://youtu.be/5jtWiUtMpzE
PImage  f;
int pos;
boolean msjError;
String estado;
String subEstado;
int[] esPresionado={0,0,0,0,0,0,0,0,0,0};
String[] imagenes= {"1.jpg","2.png","3.png","4.png","5.png","6.png","7.png","8.png","9.png"};
String[] mensajes={"Cenicienta es una joven maltratada por su madrastra y hermanastras,tras la muerte de su padre. A pesar de todo, Cenicienta conserva una actitud amable y optimista",
                  "Un día, el príncipe anuncia un baile en el palacio real.",
                  "Pero solo Cenicienta logra que le ajuste perfectamente.",
                  "Cenicienta no puede asistir debido a las órdenes de su madrastra.",
                  "Su hada madrina aparece para:(A).-Transformarla en una joven hermosa y presentable para la fiesta. (B).- Ayudarle con la limpieza",
                  "Cenicienta asiste al baile y captura la atención del príncipe, quien se enamora de ella. (A).-Bailan toda la noche.  (B).- Nunca se saludan",
                  "El príncipe encuentra el zapato y decide buscar a la dueña en: (A).- Todo el reino, (B).- solo en el castillo. Muchas jóvenes intentan probárselo",
                  "Pero Cenicienta debe irse antes de la medianoche, momento en que su encantamiento se desvanecerá. En su prisa, pierde un: (A).- Zapato de cristal. (B).- Un brazalete (C).- Una cartera",
                  "Despues de mucho tiempo, El Príncipe muere de una enfermedad dejando sola a cenicienta.",
                  "El Hada madrina nunca apareció frente a cenicienta, por lo cual nunca conocio al príncipe y nunca pudo ser feliz.",
                  "La madrastra de cenicienta la encierra para siempre por lo que nuca conocerá al príncipe y nunca vivirá feliz.",
                  "Despues de mucho tiempo, El Príncipe muere de una enfermedad dejando sola a cenicienta."
                };
String aux="";
void setup() {
  estado="inicio";
  subEstado="";
  size(600, 600);//tamaño pantalla: w,h
  background(255); //fondo blanco
  pos=0;
  msjError=false;

  f = loadImage("inicio.png");

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
   
   if(pos==8){
     subEstado="";
     estado="fin";
   } 
   
   //mostrar imagenes
   if(estado.equals("inicio")){
     esPresionado[0]=dibujarBoton(220,220,70,"Iniciar",140,40,true,esPresionado[0]);
     esPresionado[1]=dibujarBoton(220,290,70,"Créditos",140,40,true,esPresionado[1]);
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
     esPresionado[2]=dibujarBoton(220,500,70,"Inicio",140,40,true,esPresionado[2]);
   }
   else if(estado.equals("comenzar")){
     if(msjError){
       fill(255, 0, 0);
       text("¡Opción incorrecta!", width/2, height/2);
     }
     else if(subEstado.equals("")){
        if(pos==0) dibujar(mensajes[0],17,23,27,143,400,150);
        if(pos==1) dibujar(mensajes[1],17,23,27,143,400,150);
        if(pos==7) dibujar(mensajes[2],17,23,27,143,400,150);
       esPresionado[3]=dibujarBoton(0,0,0,"",width,height,false,esPresionado[3]);
     }else if(subEstado.equals("mostrarVerdadFalso")){//pos=2
       dibujar(mensajes[3],17,23,27,143,400,150);
       esPresionado[4]=dibujarBoton(50,220,70,"Verdadero",150,40,true,esPresionado[4]);
       esPresionado[5]=dibujarBoton(400,220,60,"Falso",120,40,true,esPresionado[5]);
     }else if(subEstado.equals("botonAB")){//pos=3,4,6
       if(pos==3) dibujar(mensajes[4],17,23,27,143,400,150);
       if(pos==4) dibujar(mensajes[5],17,23,27,143,400,150);
       if(pos==6) dibujar(mensajes[6],17,23,27,143,400,150);
       esPresionado[6]=dibujarBoton(50,220,40,"A",80,40,true,esPresionado[6]);
       esPresionado[7]=dibujarBoton(460,220,40,"B",80,40,true,esPresionado[7]);
     }else if(subEstado.equals("fin")){//pos=6
       dibujar(aux,17,23,27,143,400,150);
       esPresionado[3]=dibujarBoton(0,0,0,"",width,height,false,esPresionado[3]);
     }
     else if(subEstado.equals("botonABC")){//pos=5
       dibujar(mensajes[7],17,23,27,143,400,150);
       esPresionado[6]=dibujarBoton(50,220,40,"A",80,40,true,esPresionado[6]);
       esPresionado[7]=dibujarBoton(250,220,40,"B",80,40,true,esPresionado[7]);
       esPresionado[8]=dibujarBoton(460,220,40,"C",80,40,true,esPresionado[8]);
     }
     
     
   }else if(estado.equals("fin") && !subEstado.equals("fin")){
     pos=-1;
     esPresionado[3]=dibujarBoton(0,0,0,"",width,height,false,esPresionado[3]);
     esPresionado[9]=dibujarBoton(50,500,100,"Final Alternativo",200,40,true,esPresionado[9]);
   }else if(estado.equals("fin") && subEstado.equals("fin")){
     dibujar(mensajes[8],17,23,27,143,400,150);
     esPresionado[3]=dibujarBoton(0,0,0,"",width,height,false,esPresionado[3]);
   }
   
}

void keyPressed() {

  msjError = false;
}



void mousePressed() {
  if(esPresionado[1]==1){
    estado="creditos";
    f = loadImage("creditos.png");
    esPresionado[1]=0;
  }
  
  if(esPresionado[2]==1){
    estado="inicio";
    f = loadImage("inicio.png");
    esPresionado[2]=0;
  }
  
  if(esPresionado[0]==1){
    estado="comenzar";
    subEstado="";
    pos=0;
    f = loadImage(imagenes[pos]);
    esPresionado[0]=0;
  }
  
  if(esPresionado[3]==1){
    if(pos!=-1){
      pos++;
      f = loadImage(imagenes[pos]);
      esPresionado[3]=0;
    }else{
       estado="creditos";
       f = loadImage("creditos.png");
       esPresionado[3]=0;
    }
  }
  
  if(esPresionado[4]==1){
    pos++;
    f = loadImage(imagenes[pos]);
    esPresionado[4]=0;
  }
  
  if (esPresionado[6]==1) {
    pos++;
    f = loadImage(imagenes[pos]);
    esPresionado[6]=0;
  }
  
  if(esPresionado[5]==1){
    subEstado="fin";
    pos=-1;
    aux=mensajes[9];
    f = loadImage("final1Alternativo.png");
    esPresionado[5]=0;
  }
  
  if(esPresionado[7]==1 && pos!=6){
    subEstado="error";
    msjError=true;
    esPresionado[7]=0;
  }
  
  if(esPresionado[7]==1 && pos==6){
    subEstado="fin";
    pos=-1;
    aux=mensajes[10];
    f = loadImage("tercerFinal.png");
    esPresionado[7]=0;
  }
  
  if(esPresionado[8]==1){
    subEstado="error";
    msjError=true;
    esPresionado[8]=0;
  }
  
  if(esPresionado[9]==1){
    subEstado="fin";
    estado="fin";
    pos=-1;
    aux=mensajes[11];
    f = loadImage("4FinalAlternativo.png");
    esPresionado[9]=0;
  }
  
}



int dibujarBoton(int x, int y,int distTexto, String texto, int largo,int alto,boolean estado, int esPresionado){
     if (mouseX >= x && mouseX <= x+largo && 
          mouseY >= y && mouseY <= y+alto) {
        esPresionado = 1;
      } else {
        esPresionado = 0;
      }
     if(estado){
       if (esPresionado==1) {
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
     return esPresionado;
 }
 
 public void dibujar(String texto, int tam, int r, int g, int b,int ancho, int alto){
    int posX=100;
    int posY=50;
    fill(200, 200, 200,150);//color de rectangulo
    rect(posX, posY, ancho, alto);//rectangulo
    fill(r, g, b);//color de letra
    textFont(createFont("Arial Bold Italic", tam)); // Fuente en negrita
    textAlign(CENTER, CENTER); 
    text(texto,posX,posY,ancho,alto);
    
  }
 
