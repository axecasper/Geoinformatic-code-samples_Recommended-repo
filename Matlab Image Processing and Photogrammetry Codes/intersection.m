%Tie Point Coordinates on Image
Ties=[];
Ties(1,1) = -12.843;
Ties(1,2) = -54.155;
Ties(1,3) = -87.550;
Ties(1,4) = -51.157;
Ties(2,1) = -22.720;
Ties(2,2) = -4.828;
Ties(2,3) = -98.272;
Ties(2,4) = -1.702;
Ties(3,1) = -0.433;
Ties(3,2) = 70.321;
Ties(3,3) = -75.465;
Ties(3,4) = 75.310;
Ties(4,1) = -25.993;
Ties(4,2) = -58.086; 
Ties(4,3) = -101.077;
Ties(4,4) = -55.213;
%Focal length of camera
f=152.057;
%%Exterior Orientation Parameters of First Image
	Im1.w= deg2rad(1.4022);
	Im1.p= deg2rad(-0.3112);
	Im1.k= deg2rad(0.6470);
	Im1.X = 9577.252;
	Im1.Y = 10214.285;
	Im1.Z = 555.192;  
%Exterior Orientation Parameters of Second Image
	Im2.w =deg2rad(-0.1557);
	Im2.p = deg2rad(-1.7063);
	Im2.k =deg2rad(0.5513);
	Im2.X = 9803.241;
	Im2.Y = 10219.622;
	Im2.Z = 556.601;
%Principal Point Coordinates
xp=0;
yp=0;  
%% Initial Approximations
  X=[];
  
  X(1, 1) = 9539;
	X(2, 1) = 9505;
	X(3, 1) = 9576;
	X(4, 1) = 9500;

	X(1, 2) = 10051;
	X(2, 2) = 10210;
	X(3, 2) = 10455;
	X(4, 2) = 10040;

	X(1, 3) = 60;
	X(2, 3) = 68;
	X(3, 3) = 65;
	X(4, 3) = 65;
%%Design Matrix
  B=zeros(4,3);
%%Reduced Observation Vector
  l=zeros(4,1);
 for i=1:4
    %%Reset correction to make sure loop goes on.  
    dx=[1,1,1];
    %Loop until dx is really small
    while (sum(dx)>10^-6)
      Xa=X(i,1);
      Ya=X(i,2);    
      Za=X(i,3);      
      %First Image Variables
      Xl=Im1.X;
      Yl=Im1.Y;      
      Zl=Im1.Z;      
      phi=Im1.p;
      kappa=Im1.k;
      omega=Im1.w;  
      %Rotation Matrix for first Image
      m11 = cos(phi) * cos(kappa);
	    m12 = sin(omega) * sin(phi) * cos(kappa) + cos(omega) * sin(kappa);
	    m13 = -cos(omega) * sin(phi) * cos(kappa) + sin(omega) * sin(kappa);
	    m21 = -cos(phi) * sin(kappa);
	    m22 = -sin(omega) * sin(phi) * sin(kappa) + cos(omega) * cos(kappa);
	    m23 = cos(omega) * sin(phi) * sin(kappa) + sin(omega) * cos(kappa);
	    m31 = sin(phi);
      m32 = -sin(omega) * cos(phi);
	    m33 = cos(omega) * cos(phi);   
%%%%%%Colliniarty Equation parts for partial derivatives
      q=m31*(Xa-Xl)+m32*(Ya-Yl)+m33*(Za-Zl);
      r=m11*(Xa-Xl)+m12*(Ya-Yl)+m13*(Za-Zl);
      s=m21*(Xa-Xl)+m22*(Ya-Yl)+m23*(Za-Zl);
%%%%%%Design Matrix first part for first image partial derivatives      
      B(1,1)=(f/(q^2))*(r*m31-q*m11);
      B(1,2)=(f/(q^2))*(r*m32-q*m12);
      B(1,3)=(f/(q^2))*(r*m33-q*m13);
      B(2,1)=(f/(q^2))*(s*m31-q*m21);
      B(2,2)=(f/(q^2))*(s*m32-q*m22);      
      B(2,3)=(f/(q^2))*(s*m33-q*m23);  
%%%%%%Reduced Observation Vector forfirst image      
      l(1,1)=Ties(i,1)-xp+f*(r/q);
      l(2,1)=Ties(i,2)-yp+f*(s/q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%END OF FIRST DERIVATIVES      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
      %Second Image Variables
      Xl=Im2.X;
      Yl=Im2.Y;      
      Zl=Im2.Z;      
      phi=Im2.p;
      kappa=Im2.k;
      omega=Im2.w;
      %Rotation Matrix for second Image
      m11 = cos(phi) * cos(kappa);
	    m12 = sin(omega) * sin(phi) * cos(kappa) + cos(omega) * sin(kappa);
	    m13 = -cos(omega) * sin(phi) * cos(kappa) + sin(omega) * sin(kappa);
	    m21 = -cos(phi) * sin(kappa);
	    m22 = -sin(omega) * sin(phi) * sin(kappa) + cos(omega) * cos(kappa);
	    m23 = cos(omega) * sin(phi) * sin(kappa) + sin(omega) * cos(kappa);
	    m31 = sin(phi);
      m32 = -sin(omega) * cos(phi);
	    m33 = cos(omega) * cos(phi); 
%%%%%%Colliniarty Equation parts for partial derivatives      
      q=m31*(Xa-Xl)+m32*(Ya-Yl)+m33*(Za-Zl);
      r=m11*(Xa-Xl)+m12*(Ya-Yl)+m13*(Za-Zl);
      s=m21*(Xa-Xl)+m22*(Ya-Yl)+m23*(Za-Zl);
%%%%%%Design Matrix first part for second image partial derivatives        
      B(3,1)=(f/(q^2))*(r*m31-q*m11);
      B(3,2)=(f/(q^2))*(r*m32-q*m12);
      B(3,3)=(f/(q^2))*(r*m33-q*m13);
      B(4,1)=(f/(q^2))*(s*m31-q*m21);
      B(4,2)=(f/(q^2))*(s*m32-q*m22);      
      B(4,3)=(f/(q^2))*(s*m33-q*m23); 
      l(3,1)=Ties(i,3)-xp+f*(r/q);
      l(4,1)=Ties(i,4)-yp+f*(s/q);    
%%%%%%Calculate DX (Corrections to unknown parameters)
      N=inv(B'*B);
      b=B'*l;
      dx=N*b;
%%%%%%Apply Corrections to Initial Values       
      for j=1:3
        X(i,j)=X(i,j)+dx(j);   
      end;  
    end; 
  end;
  %%Show Final X
  X