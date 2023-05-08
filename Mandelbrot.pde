class Mandelbrot{
  int Nx=width,Ny=height; 
  
  double startReal=-2,endReal=2;  //Mandel di partenza
  double startImag=-2,endImag=2;  
  
  //float startReal=-0.7493186-0.0001,endReal=-0.7493186+0.0001;
  //float startImag=-0.06615235-0.0001,endImag=-0.06615235+0.0001;
  
  double w_Mandel = (endReal-startReal<0) ? -(endReal-startReal) : endReal-startReal;
  
  int iterMax=100;
  double mandelZoomIn=0.5;
  double mandelZoomOut=0.5;
  int mandelColor;
  int div1,div2;
  boolean daAggiornare=true;
    
  Mandelbrot(int colore, int d1, int d2){
    mandelColor=colore;
    div1=d1;
    div2=d2;
  }    //Costruttore con attributi di defalut.
  void incIter(){
    iterMax*=2;
    daAggiornare=true;
  }
  void decIter(){
    if(iterMax>100){
      iterMax/=2;
      daAggiornare=true;
    }
  }
  void reset(){
    mandelZoomIn=0.5;
    mandelZoomOut=0.5;    
    startReal=-2;endReal=2;
    startImag=-2;endImag=2;
    w_Mandel = (endReal-startReal<0) ? -(endReal-startReal) : endReal-startReal;
    iterMax=100;
    daAggiornare=true;    
  }
  color sequenzaMandelbrot(Complex c){
    Complex Zn = new Complex(0,0);
    Complex Zprec;
    int iter=0;
    //Punto p=new Punto(convertToCart(c));
    while(Zn.modulo()<2){
      if(iter==iterMax){//Appartiene a mandelbrot
         return color(0);
         //point((c.real*scala)+centro.posX,(c.imag*scala)+centro.posY);
         //point((c.real*scala),(c.imag*scala));
         //point(p.posX,p.posY);
        //return true;
      }
      Zprec=Zn;
      Zn=(Zprec.mul(Zprec)).somma(c);
      iter++;      
    }
    //NON appartiene a madelbrot
    return color(iter*mandelColor % 255,iter*mandelColor/div1 % 255,iter*mandelColor/div2 % 255);
    //return color(255/Zn.modulo(),255/Zn.modulo(),255/Zn.modulo());
    //point((c.real*scala)+centro.posX,(c.imag*scala)+centro.posY);
    //point((c.real*scala),(c.imag*scala));
    //point(p.posX,p.posY);
    //return false;
  }
  void zoomIn(int x,int y){
    Punto p=new Punto(float(x),float(y));
    Complex z= new Complex(convertToComplex(p));
    z.stampa();
    p.print();
    mandelZoomIn/=2;
    mandelZoomOut/=2;    
    startReal=z.real-mandelZoomIn;
    endReal=z.real+mandelZoomIn;
    startImag=z.imag-mandelZoomIn;
    endImag=z.imag+mandelZoomIn;
    w_Mandel = (endReal-startReal<0) ? -(endReal-startReal) : endReal-startReal;
   

    daAggiornare=true;
  }
  void zoomOut(int x,int y){
    Punto p=new Punto(float(x),float(y));
    Complex z= new Complex(convertToComplex(p));
    z.stampa();
    p.print();
   mandelZoomOut*=2;
   mandelZoomIn*=2;       
    startReal-= mandelZoomOut;
    endReal+= mandelZoomOut;
    startImag-=mandelZoomOut;
    endImag+=mandelZoomOut;
    w_Mandel = (endReal-startReal<0) ? -(endReal-startReal) : endReal-startReal;

   daAggiornare=true;
  }  
  /*Punto convertToCart(Complex c){Il 
    return new Punto(((c.real*(width-1))/(w_Mandel))+((width-1)/2),((c.imag*(height-1))/(w_Mandel))+((height-1)/2));
    //return new Punto((c.real*width)/(w_Mandel/2),(c.imag*height)/(w_Mandel/2));
  }*/
  Complex convertToComplex(Punto p){
    return new Complex(((p.posX*w_Mandel)/(width-1))-(w_Mandel/2-(startReal+endReal)/2),((p.posY*w_Mandel)/(height-1))-(w_Mandel/2-(startImag+endImag)/2));
    //return new Complex(((p.posX*w_Mandel)/(width-1))-(w_Mandel/2),((p.posY*w_Mandel)/(height-1))-(w_Mandel/2));
    //return new Complex((((p.posX-width/2)*w_Mandel)/width),(((p.posY-height/2)*w_Mandel)/height)*-1);
    //return new Complex(((p.posX*(w_Mandel/2))/width),((p.posY*(w_Mandel/2))/height)*-1);
  }
  void draw(){
    /*stroke(255,0,0);
    line(width/2,0,width/2,height);
    line(0,height/2,width,height/2);
    text(startReal,0,height/2-10);
    text(endReal,width-40,height/2-10);
    text(startImag,width/2-40,10);
    text(endImag,width/2-40,height-10);*/
    //Pianodeinumeri complessi --> Piano cartesiano
    stroke(255);
    pg.text("MaxIteration: "+iterMax,10,20);
    if(daAggiornare){
      pg.clear();
      println("Calcolo di Mandel...");
    }
    for(int i=0;i<Nx && daAggiornare;i++){
      for(int j=0;j<Ny;j++){
        pg.stroke(sequenzaMandelbrot(new Complex(convertToComplex(new Punto(i,j)))));
        pg.point(i,j);
      }
    }
    /*//Pianodeinumeri complessi --> Piano cartesiano
    for(float i=startReal;i<=endReal;i+=w_Mandel/float(Nx)){
      for(float j=startImag;j<=endImag;j+=w_Mandel/float(Ny)){
        stroke(sequenzaMandelbrot(new Complex(i,j)));
        Punto p = new Punto(convertToCart(new Complex(i,j)));
        point(p.posX,p.posY);
      }
    }*/
    if(daAggiornare)println("Fine calcolo");
    daAggiornare=false;
   //println("Fine disegno");   
  }
}
