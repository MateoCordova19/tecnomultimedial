//https://youtu.be/5jtWiUtMpzE?si=3Z5s_3x7x_Dw7nnw
import java.util.Arrays;
import java.util.Random;

//Variables Globales 
boolean arr,aba,izq,der; //interacción con teclado

PImage imgBala;
PImage  f;               //imagen para fondo
PImage img[]=new PImage[3]; //imagenes nave
int imgActual = 0;//imagen acutal del jugador

int vida=100;
int puntaje = 0;
int dificultad=0;
ArrayList<ArrayList<Float>> balas;
ArrayList<ArrayList<Float>> items;
ArrayList<ArrayList<Float>> asteroides;
ArrayList<Float> nave;

PImage imgItem;
PImage imgAsteroide;

//setup se ejecuta una vez: INICIALIZAR
void setup() {
  size(350,500);   //zona interactiva  
  background(100); //fondo gris
  frameRate(30);   //FPS: cuadros por segundo
  f = loadImage("fondo.jpg"); //carga imagen
  imgItem = loadImage("itemVida.png");
  imgAsteroide = loadImage("asteroide3.png");
  imgBala = loadImage("b1.png");
  img[0] = loadImage("n1.png");
  img[1] = loadImage("n2.png"); //agrega otras visualizaciones de nave
  img[2] = loadImage("n3.png");
  nave =new ArrayList<>(Arrays.asList(width/2.0, height/2.0+100,0.0,0.0,0.0,0.0,img[0].width*1.0,img[0].height*1.0,3.0)); //x,y,xIzq,xDer,ySup,yInf,w,h,v

  items = new ArrayList<>(); 
  asteroides = new ArrayList<>(); 
  balas = new ArrayList<>(); 
  balas.add(crearBala(imgBala,nave.get(0),nave.get(1)));
}

//loop infinito: INTERACCIÓN
void draw() {
  imageMode(CORNER);         //especificar por esquina superior izquierda
  image(f,0,0,width,height); //mostrar imagen con esquina sup izq en 0,0 y tamaño de pantalla
  
  moverNave(nave);
  
  if(frameCount%20==0)
  //if(keyPressed == true && key=='d')
  
  nave_disparar(nave.get(0), nave.get(1));
  dibujarNave(nave,img);
  //J.dibujar();
  //J.eliminarEnemigo(asteroides);
  nave_eliminarAsteroide(asteroides);
  
  if(frameCount%500==0){
    //crear un item
    ArrayList<Float> item = crearItem(imgItem);
    items.add(item);
  } 
  
  if(puntaje>150){
    dificultad=15;
  }
  else if(puntaje>100){
    dificultad=30;
  }else if(puntaje>50){
    dificultad=50;
  }else{
    dificultad=70;
  }
  
  if(frameCount%dificultad==0){
     ArrayList<Float> asteroide = crearAsteroide(imgAsteroide);
     asteroides.add(asteroide);
 }
  
  
  for(int i=0; i<items.size(); i++){
    moverItem(items.get(i));
    //items.get(i).mover();
    dibujarItem(items.get(i),imgItem);
    //items.get(i).dibujar();

    if(impactaItem(items.get(i),nave)!=-1){
      if(vida+items.get(i).get(9)<=100) vida+=items.get(i).get(9);
      else vida=100;
      items.remove(i); 
    }
  }
  
  for(int i=0; i<items.size(); i++){
    if(enPantallaItem(items.get(i))==false) items.remove(i); 
  }
  
  for(int i=0; i<asteroides.size(); i++){
    moverAsteroide(asteroides.get(i));
    dibujarAsteroide(asteroides.get(i),imgAsteroide);

    
    if(impactaAsteroide(asteroides.get(i),nave)!=-1){
      vida-=asteroides.get(i).get(9);
      asteroides.remove(i); 
    }
  }
  
  for(int i=0; i<asteroides.size(); i++){
    if (enPantallaAsteroide(asteroides.get(i))==false) asteroides.remove(i); 
  }
  
  textSize(20);
  text("Puntos: "+puntaje, 10,10, 150, 40);
  text("Vida", 10,35, 150, 40);
  fill(0,255,0);
  rect(10,60,vida,20);
}

//--------------------------------------------------------------------------------------------------------------
//MOVER NAVE
void moverNave(ArrayList<Float> nave){
    imgActual = 0;   //resetea a vista frontal
    if (izq== true){ //mueve y cambia vista
      if(nave.get(2)>0)     //dentro del recuadro
          nave.set(0,nave.get(0)-nave.get(8));
          //x=x-v;
      imgActual = 1;
    }
    
    if (der== true) {//mueve y cambia vista
      if(nave.get(3)<width) //dentro del recuadro
        nave.set(0,nave.get(0)+nave.get(8));
        //x+=v;
      imgActual = 2;
    }
    
    if (arr== true){ //mueve 
      if(nave.get(4)>0)     //dentro del recuadro
        nave.set(1,nave.get(1)-nave.get(8));
        //y=y-v;
    }
    
    if (aba== true) {
      if(nave.get(5)<height) //dentro del recuadro
        nave.set(1,nave.get(1)+nave.get(8));
        //y=y+v;
    }  
}


void nave_disparar(float x, float y){
    balas.add(crearBala(imgBala,x,y));        //agrega una Bala
    for (int i = 0; i < balas.size(); i++) {  //la dispara
      balas.get(i).set(9,1.0);
     }
    
    //eliminar balas que ya no se ven o utilizan
    //se recorre de atras para adelante
    for (int i = balas.size() - 1; i >= 0; i--) {
      if (enPantallaBala(balas.get(i))==false) //ya no se ve
        balas.remove(i);        //remover 
    }
}

void dibujarNave(ArrayList<Float> nave,PImage[] imgNave){
    imageMode(CENTER);    // Dibujar a imagen actual utilizando el centro
    //w = imgNave[imgActual].width;
    nave.set(6,imgNave[imgActual].width*1.0);
    nave.set(7,imgNave[imgActual].height*1.0);
    //h = imgNave[imgActual].height;
    image(imgNave[imgActual], nave.get(0), nave.get(1), nave.get(6), nave.get(7));  
    
    nave.set(2, nave.get(0) - nave.get(6)/2);
    nave.set(3, nave.get(0) + nave.get(6)/2);
    nave.set(4, nave.get(1) - nave.get(7)/2);
    nave.set(5, nave.get(1) + nave.get(7)/2);
    
   //dibuja cada Bala en la Lista
    for (int i = 0; i<balas.size(); i++) {
      moverBala(nave.get(0),nave.get(1),balas.get(i));
      dibujarBala(balas.get(i),imgBala);
     }
}


void nave_eliminarAsteroide(ArrayList<ArrayList<Float>> asteroides){
    int pos;
     for (int i = 0; i<balas.size(); i++) {
        pos=impactaAsteroideBala(asteroides,balas.get(i).get(0),balas.get(i).get(1) );
        if(pos!=-1)  {
          balas.remove(i); 
          //aumentar puntos
          puntaje+=2;
        }
     }
}
//---------------------------------------------------------------------------------------------------------------
//BALAS
//--------------------------------------------------------------------------------------------------------------
//BALA
ArrayList<Float> crearBala(PImage imgItem, float _x, float _y){
    //PImage img; //imagen
    float x=_x;
    float y=_y;
    float w,h; //ancho y alto edl objeto
    float v=5; //velocidad

    w=imgItem.width;   //ancho del bojeto(imagen)
    h=imgItem.height;  //alto del objeto(imagen)
    float disparada=0.0;
    
    ArrayList<Float> bala = new ArrayList<>(Arrays.asList(x, y,0.0,0.0,0.0,0.0,w,h,v,disparada)); //x,y,xIzq,xDer,ySup,yInf,w,h,v,disparada
    return bala;  
  }
  
  int impactaAsteroideBala(ArrayList<ArrayList<Float>> enemigos,float x, float y){
    float minX,maxX;
    float minY,maxY;
    for(int i=0; i<enemigos.size(); i++){
     
      minX=enemigos.get(i).get(0)-20;
      maxX=minX+enemigos.get(i).get(6);
      minY=enemigos.get(i).get(1)-20;
      maxY=minY+enemigos.get(i).get(7);
      if(x<=maxX && x>=minX && y<=maxY && y>=minY) return i;
    }
    return -1;
  }
  
   void moverBala(float _x, float _y, ArrayList<Float> bala){
    if(bala.get(9)==0.0){
    //si no se ha disparado, la bala sigue el Jugador
      bala.set(0,_x);
      bala.set(1,_y);
    }
    else{
    //si ya se disparo la bala sale hacia arriba
      bala.set(1,bala.get(1)-bala.get(8));
    }
  }
  
  void dibujarBala(ArrayList<Float> bala,PImage imgBala){
    bala.set(6, imgBala.width*1.0);
    bala.set(7, imgBala.height*1.0);
    //w = imgBala.width;
    //h = imgBala.height;
    image(imgBala,bala.get(0), bala.get(1), bala.get(6), bala.get(7));  
    bala.set(2, bala.get(0) - bala.get(6)/2);
    bala.set(3, bala.get(0) + bala.get(6)/2);
    bala.set(4, bala.get(1) - bala.get(7)/2);
    bala.set(5, bala.get(1) + bala.get(7)/2);
  }
  

  boolean enPantallaBala(ArrayList<Float> bala){
    boolean sal = true;
    if( bala.get(1) <0) //límite superior
      sal = false;
    return sal;
  }


//--------------------------------------------------------------------------------------------------------------
//CREAR ITEM
ArrayList<Float> crearItem(PImage imgItem){
  //PImage img; //imagen
  float x=(int) (Math.floor(Math.random()*((width-25)-25+1)+25));
  float y=0; //posición del centro
  float w,h; //ancho y alto edl objeto
  float v=2; //velocidad
  float vidaRestaura=20;
  
  w=imgItem.width;   //ancho del bojeto(imagen)
  h=imgItem.height;  //alto del objeto(imagen)
  
  ArrayList<Float> item = new ArrayList<>(Arrays.asList(x, y,0.0,0.0,0.0,0.0,w,h,v,vidaRestaura)); //x,y,xIzq,xDer,ySup,yInf,w,h,v,vidaRestaura
  return item;  
}

void moverItem(ArrayList<Float> item){
  item.set(1, item.get(1)+item.get(8));
}

void dibujarItem(ArrayList<Float> item,PImage imgItem){
    imageMode(CENTER);    // Dibujar a imagen actual utilizando el centro
    item.set(6, imgItem.width*1.0);
    item.set(7, imgItem.height*1.0);
    image(imgItem, item.get(0), item.get(1), item.get(6), item.get(7));  
    
    item.set(2, item.get(0) - item.get(6)/2);
    item.set(3, item.get(0) + item.get(6)/2);
    item.set(4, item.get(1) - item.get(7)/2);
    item.set(5, item.get(1) + item.get(7)/2);
}

int impactaItem(ArrayList<Float> item, ArrayList<Float> nave){
    float minX,maxX;
    float minY,maxY;
    minX=nave.get(0)-20;
    maxX=minX+nave.get(6);
    minY=nave.get(1)-20;
    maxY=minY+nave.get(7);
    if(item.get(0)<=maxX && item.get(0)>=minX && item.get(1)<=maxY && item.get(1)>=minY) return 1;
    return -1;
}

boolean enPantallaItem(ArrayList<Float> item){
    boolean sal = true;
    if( item.get(1) <0) //límite superior
      sal = false;
    return sal;
}
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------

//ENEMIGO ASTEROIDE
ArrayList<Float> crearAsteroide(PImage imgAsteroide){
  Random rand = new Random();
  double random01 = rand.nextDouble();
  //PImage img; //imagen
  float x=(int) (Math.floor(Math.random()*((width-25)-25+1)+25));
  float y=0; //posición del centro
  float w,h; //ancho y alto edl objeto
  float v = (float)(2 + random01 * (8 - 2));//velocidad entre 2 y 8
  float danio=30;
  //img = loadImage("itemVida.png"); //carga imagen 0
  
  w=imgAsteroide.width;   //ancho del bojeto(imagen)
  h=imgAsteroide.height;  //alto del objeto(imagen)
  
  ArrayList<Float> asteroide = new ArrayList<>(Arrays.asList(x, y,0.0,0.0,0.0,0.0,w,h,v,danio)); //x,y,xIzq,xDer,ySup,yInf,w,h,v,daño
  return asteroide;  
}

void moverAsteroide(ArrayList<Float> asteroide){
  asteroide.set(1, asteroide.get(1)+asteroide.get(8));
}

void dibujarAsteroide(ArrayList<Float> asteroide,PImage imgAsteroide){
    imageMode(CENTER);    // Dibujar a imagen actual utilizando el centro
    asteroide.set(6, imgAsteroide.width*1.0);
    asteroide.set(7, imgAsteroide.height*1.0);
    image(imgAsteroide, asteroide.get(0), asteroide.get(1), asteroide.get(6), asteroide.get(7));  
    
    asteroide.set(2, asteroide.get(0) - asteroide.get(6)/2);
    asteroide.set(3, asteroide.get(0) + asteroide.get(6)/2);
    asteroide.set(4, asteroide.get(1) - asteroide.get(7)/2);
    asteroide.set(5, asteroide.get(1) + asteroide.get(7)/2);
}

boolean enPantallaAsteroide(ArrayList<Float> asteroide){
    boolean sal = true;
    if( asteroide.get(1) <0) //límite superior
      sal = false;
    return sal;
}

int impactaAsteroide(ArrayList<Float> asteroide, ArrayList<Float> nave){
    float minX,maxX;
    float minY,maxY;
    minX=nave.get(0)-20;
    maxX=minX+nave.get(6);
    minY=nave.get(1)-20;
    maxY=minY+nave.get(7);
    if(asteroide.get(0)<=maxX && asteroide.get(0)>=minX && asteroide.get(1)<=maxY && asteroide.get(1)>=minY) return 1;
    return -1;
}

//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
//interacción Teclado al presionar
void keyPressed(){
  if (key == CODED) {
    if (keyCode == LEFT) 
      izq=true;
    if (keyCode == RIGHT) 
      der=true;
    if(keyCode == UP) 
      arr=true;
    if(keyCode == DOWN)
      aba=true;
  }  
}  

//interacción Teclado al liberar tecla
void keyReleased(){
  if (key == CODED) {
    if (keyCode == LEFT) 
      izq=false;
    if (keyCode == RIGHT) 
      der=false;
    if(keyCode == UP) 
      arr=false;
    if(keyCode == DOWN)
      aba=false;
  }  
}
