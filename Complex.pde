class Complex{
  
  double real;
  double imag;
  
  Complex(){
    real = 0;
    imag = 0;
  }
  
  Complex(double x,double y){
    real = x;
    imag = y;
  }
  
  Complex(Complex z){
    real=z.real;
    imag=z.imag;
  }
  
  Complex somma(Complex z){
    return new Complex(real+z.real,imag+z.imag);
  }
  
  Complex diff(Complex z){
    return new Complex(real-z.real,imag-z.imag);
  }
  
  Complex divi(Complex z){
    return new Complex (((real*z.real+imag*z.imag)/(z.real*z.real+z.imag*z.imag)),((imag*z.real-real*z.imag)/(z.real*z.real+z.imag*z.imag)));
  }
  
  Complex mul(Complex z){
    return new Complex ((real*z.real)-(imag*z.imag),(real*z.imag)+(z.real*imag));
  }
  
  double modulo(){return Math.sqrt((real*real)+(imag*imag));}
    
  void stampa(){println("z= "+real+" i"+imag);}
}
