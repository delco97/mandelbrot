class Punto{
  double posX,posY;
  //Costruttori
  Punto(double x,double y){
    posX = x;
    posY = y;
  }
  Punto(){
    posX = 0;
    posY = 0;
       
  }  
  Punto(Punto a){
    posX = a.posX;
    posY = a.posY;
  } 
  //Metodi
  void setX(double x){posX = x;}
  void setY(double y){posY = y;}
  void print(){println(posX +"x  "+ posY +"y");}
}
