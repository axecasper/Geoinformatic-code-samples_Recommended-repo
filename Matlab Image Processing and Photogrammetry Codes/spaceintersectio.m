%% Berk Kývýlcým %%
  %% 21632734 %%

%Tie Point Coordinates on Image
Tielist=[];
%1. photo tie A
Tielist(1,1) = -12.843;
Tielist(1,2) = -54.155;
%2. photo tie A
Tielist(1,3) = -87.550;
Tielist(1,4) = -51.157;
%1. photo tie B
Tielist(2,1) = -22.720;
Tielist(2,2) = -4.828;
%2. photo tie B
Tielist(2,3) = -98.272;
Tielist(2,4) = -1.702;
%1. photo tie C
Tielist(3,1) = -0.433;
Tielist(3,2) = 70.321;
%2. photo tie C
Tielist(3,3) = -75.465;
Tielist(3,4) = 75.310;
%1. photo tie D
Tielist(4,1) = -25.993;
Tielist(4,2) = -58.086; 
%2. photo tie D
Tielist(4,3) = -101.077;
Tielist(4,4) = -55.213;
%Focal length of camera
f=152.057;
%exterior orientation parameters of first image
%Used def2rad function because matlab needs rad for correct calculation
	Im1.w= deg2rad(1.4022);
	Im1.p= deg2rad(-0.3112);
	Im1.k= deg2rad(0.6470);
	Im1.X = 9577.252;
	Im1.Y = 10214.285;
	Im1.Z = 555.192;  
%exterior orientation parameters of second image
	Im2.w =deg2rad(-0.1557);
	Im2.p =deg2rad(-1.7063);
	Im2.k =deg2rad(0.5513);
	Im2.X = 9803.241;
	Im2.Y = 10219.622;
	Im2.Z = 556.601;
%Principal Point Coordinates ( no given calibrated value)
xp=0;
yp=0;  
% Initial GP Approximations
  X=[]; 
    %for x
    X(1, 1) = 9539;
	X(2, 1) = 9505;
	X(3, 1) = 9576;
	X(4, 1) = 9500;
    % for y
	X(1, 2) = 10051;
	X(2, 2) = 10210;
	X(3, 2) = 10455;
	X(4, 2) = 10040;
    %for Z
	X(1, 3) = 60;
	X(2, 3) = 68;
	X(3, 3) = 65;
	X(4, 3) = 65;
%design matrix
  A=zeros(4,3);
%reduced observation vector
  l=zeros(4,1);
 % Looping it 4 because i have 4 gcp points A-B-C-D
  for i=1:4
     %reset correction to make sure loop goes on.  
    dx=[1,1,1];
    %loop until dx is really small
    while (sum(dx)>10^-6) %correction values must be <0.00001
      Xa=X(i,1);
      Ya=X(i,2);    
      Za=X(i,3);      
      %first Image variables  
      Xl=Im1.X;
      Yl=Im1.Y;      
      Zl=Im1.Z;      
      phi=Im1.p;
      kappa=Im1.k;
      omega=Im1.w;  
      %rotation Matrix for first Image
        m11 = cos(phi) * cos(kappa);
	    m12 = sin(omega) * sin(phi) * cos(kappa) + cos(omega) * sin(kappa);
	    m13 = -cos(omega) * sin(phi) * cos(kappa) + sin(omega) * sin(kappa);
	    m21 = -cos(phi) * sin(kappa);
	    m22 = -sin(omega) * sin(phi) * sin(kappa) + cos(omega) * cos(kappa);
	    m23 = cos(omega) * sin(phi) * sin(kappa) + sin(omega) * cos(kappa);
	    m31 = sin(phi);
        m32 = -sin(omega) * cos(phi);
	    m33 = cos(omega) * cos(phi);   
%colliniarty equation parts for partial derivatives
      q=m31*(Xa-Xl)+m32*(Ya-Yl)+m33*(Za-Zl);
      r=m11*(Xa-Xl)+m12*(Ya-Yl)+m13*(Za-Zl);
      s=m21*(Xa-Xl)+m22*(Ya-Yl)+m23*(Za-Zl);
%design matrix first part for first image partial derivatives 
      A(1,1)=(f/(q^2))*(r*m31-q*m11);
      A(1,2)=(f/(q^2))*(r*m32-q*m12);
      A(1,3)=(f/(q^2))*(r*m33-q*m13);
      A(2,1)=(f/(q^2))*(s*m31-q*m21);
      A(2,2)=(f/(q^2))*(s*m32-q*m22);      
      A(2,3)=(f/(q^2))*(s*m33-q*m23);  
%reduced observation vector for first image      
      l(1,1)=Tielist(i,1)-xp+f*(r/q);
      l(2,1)=Tielist(i,2)-yp+f*(s/q);
     
%Starting second image    
    
      %Second Image Variables
      Xl=Im2.X;
      Yl=Im2.Y;      
      Zl=Im2.Z;      
      phi=Im2.p;
      kappa=Im2.k;
      omega=Im2.w;
      %rotation matrix for second Image
        m11 = cos(phi) * cos(kappa);
	    m12 = sin(omega) * sin(phi) * cos(kappa) + cos(omega) * sin(kappa);
	    m13 = -cos(omega) * sin(phi) * cos(kappa) + sin(omega) * sin(kappa);
	    m21 = -cos(phi) * sin(kappa);
	    m22 = -sin(omega) * sin(phi) * sin(kappa) + cos(omega) * cos(kappa);
	    m23 = cos(omega) * sin(phi) * sin(kappa) + sin(omega) * cos(kappa);
	    m31 = sin(phi);
        m32 = -sin(omega) * cos(phi);
	    m33 = cos(omega) * cos(phi); 
%colliniarty equation parts for partial derivatives      
      q=m31*(Xa-Xl)+m32*(Ya-Yl)+m33*(Za-Zl);
      r=m11*(Xa-Xl)+m12*(Ya-Yl)+m13*(Za-Zl);
      s=m21*(Xa-Xl)+m22*(Ya-Yl)+m23*(Za-Zl);
%design matrix first part for second image partial derivatives        
      A(3,1)=(f/(q^2))*(r*m31-q*m11);
      A(3,2)=(f/(q^2))*(r*m32-q*m12);
      A(3,3)=(f/(q^2))*(r*m33-q*m13);
      A(4,1)=(f/(q^2))*(s*m31-q*m21);
      A(4,2)=(f/(q^2))*(s*m32-q*m22);      
      A(4,3)=(f/(q^2))*(s*m33-q*m23); 
      l(3,1)=Tielist(i,3)-xp+f*(r/q);
      l(4,1)=Tielist(i,4)-yp+f*(s/q);    
%Least Square Time      
%calculate dx (Corrections to unknown parameters) 
      N=inv(A'*A);
      b=A'*l;
      dx=N*b;
%Apply Corrections to Initial Values       
      for j=1:3 % its a 3 times loop because we gonna adjust X,Y,Z(3 values)
        X(i,j)=X(i,j)+dx(j); %Adding corrections to initial gp coordinates  
      end;  
    end; 
  end;
  %Show adjusted gp coordinates
  disp(X)