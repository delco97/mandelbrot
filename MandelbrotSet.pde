
Mandelbrot mandel;
PGraphics pg;
int scelta=0;
PImage sfondo;
PImage titolo;
Button[] frattali;
int k;
float trasp=0;

void setup(){
  size(600,600);
  textSize(16);
  int cX=0,cY=0;
  pg= createGraphics(600,600);
  //Configurazioni colori:
  /*
  19,5,9
  5,7,34
  264,76,19
  230,70,21
  */
  sfondo=loadImage("/img/sfondo.jpg");
  titolo=loadImage("/img/fractal.png");
  frattali=new Button[4];
  for(k=0;k<2;k++){
    frattali[k]=new Button("/img/"+(k+1)+".png",70+cX,220+cY);
    cX+=300;
    cY+=4;
  }
  cX=0;
  cY=0;
  for(k=2;k<4;k++){
    frattali[k]=new Button("/img/"+(k+1)+".png",70+cX,392-cY);
    cX+=300;
    cY+=8;
  }
}


void draw(){
  println(mouseX +"  " +mouseY );
  
  switch(scelta){
    case 0:
      image(sfondo,0,0);
      tint(255,trasp);
      image(titolo,50,50);
      noTint();
      if(trasp<255)
        trasp+=2;
      for(k=0;k<4;k++)
        frattali[k].drawButton();
      textSize(14);
      fill(255,255,255,trasp);
      text("Controlli:",10,height-55);
      text("  m: Torna al menù",10,height-35);
      text("  0: Reset del frattale",10,height-15);
      text("  UP/DOWN: aumenta/diminusisci iterazioni",200,height-35);
      text("  click_Sx/Dx: Zoom dentro/fuori",200,height-15);
      break;
    case 1:
           //background(255,0,0);
           //text(mouseX + "x " + mouseY + "y",mouseX,mouseY);
           noCursor();
           pg.beginDraw();
           mandel.draw();
           pg.endDraw();
           image(pg,0,0);
           fill(255,255,255,175);
           rect(mouseX-30,mouseY-30,60,60);
           line(mouseX,mouseY-30,mouseX,mouseY+30);
           line(mouseX-30,mouseY,mouseX+30,mouseY);
  }
}

void mousePressed(){
  switch(scelta){
    case 0:
           if(frattali[0].pressedButton(mouseX,mouseY)){
              mandel=new Mandelbrot(19,5,9);
              scelta=1;
           }
           if(frattali[1].pressedButton(mouseX,mouseY)){
              mandel=new Mandelbrot(5,7,34);
              scelta=1;
           }
           if(frattali[2].pressedButton(mouseX,mouseY)){
              mandel=new Mandelbrot(264,76,19);
              scelta=1;
           }
           if(frattali[3].pressedButton(mouseX,mouseY)){
              mandel=new Mandelbrot(230,70,21);
              scelta=1;
           }
           break;
    case 1://Mandelbrot 
           if(mouseButton == LEFT){mandel.zoomIn(mouseX,mouseY);}
           if(mouseButton == RIGHT){mandel.zoomOut(mouseX,mouseY);}
  }
}

void keyPressed(){
  switch(scelta){
    case 0:break;
    case 1:
      if(keyCode==UP)mandel.incIter();
      if(keyCode==DOWN)mandel.decIter();
      if(key=='0')mandel.reset();
      if(key=='m')scelta=0;
  }
}

