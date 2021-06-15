format long g
%sum of 21632734=28
sum=28;
ab=0.21;
cd=0.63;
ef=0.27;
gh=0.34;                 %added "+" to geoid height
          %x            y         l (geoid height) 
koor=[	531121.569	4171060.477	34+ab;
        522139.007	4175249.228	34.61;
        521965.772	4177055.988	34+cd;
        525985.901	4181645.566	34.71;
        527321.854	4177938.485	34+ef;
        532702.166	4184439.027	35.00;
        531409.083	4183177.180	34+gh;
        528687.730	4181432.714	34.79;
        530800.931	4182399.516	34+ab;
        524599.277	4181624.668	34.69;
        530080.624	4174023.790	34+cd;
        527448.386	4180150.776	34.76;
        522187.785	4180966.223	34+ef;
        523840.797	4181543.848	34.71;
        533721.734	4172811.346	35+gh;
        530128.716	4182144.569	34.87;
        533041.683	4170351.896	34+ab;
        518442.199	4174291.701	34.41;
        532328.018	4170762.774	34+cd;
        530030.643	4172850.093	34.91];
    
    %p1 and p2 x and y
    p1x=525000.000+1*sum;
    p1y=4179000.000+2*sum;
    p2x=530000.000+3*sum;
    p2y=4177000.000+4*sum;
    
    %Calculating mean x and y of given 20 coordinates
    xtire=0;
    ytire=0;
    [r c]=size(koor);
    
    for i=1:r;
        xtire=xtire+koor(i,1);
    end    
    xort=xtire/r; 
    
    for i=1:r;
        ytire=ytire+koor(i,2);
    end    
    yort=ytire/r;
    
    %scaling with  (mean-input)/1000
    %creating a new matrix and add this new scaled values into them.
    %its 20x2 number of 20 scaled point's x and y
    yenitablo=[];
    for i=1:r;
        yenitablo(i,1)=(xort-koor(i,1))/1000; %Xi
    end
    
    for i=1:r;
        yenitablo(i,2)=(yort-koor(i,2))/1000;  %Yi
    end   
    
    %Creating A matrix for least square with second degree poynomial
    %1 + x + y + x^2 + x*y + y^2
    A=[];
    for i=1:r;
       A(i,1)=1; %1
       A(i,2)=yenitablo(i,1); %x
       A(i,3)=yenitablo(i,2); %y
       A(i,4)=yenitablo(i,1)^2; %x^2
       A(i,5)=yenitablo(i,1)*yenitablo(i,2); %x*y
       A(i,6)=yenitablo(i,2)^2; %y^2
    end    
    
    %L matrix of the least square adjustment is geoid height. Because we
    %will estimate the geoid height of two points
    L=[];
    for i=1:r;
        L(i)=koor(i,3);
    end  
    L=transpose(L); %the matrix must be 20x1 instead of 1x20 for calculation so we get the transpose of it
    
    
    x=(inv(transpose(A)*A))*(transpose(A)*L); %least square formula
    V=A*x-L; %residual
    mo=sqrt((transpose(V)*V)/(20-6)); %u=6 because there are 6 unknown parameters in second order polynomial (a00,a10,a01...)
    
    %Scaling the given two points. All coordinates must be in same scale.
    x1=(xort-p1x)/1000;
    y1=(yort-p1y)/1000;
    x2=(xort-p2x)/1000;
    y2=(yort-p2y)/1000;
    
    %Calculation whole second order polynomial
    N1 = x(1) + (x(2)*x1) + (x(3)*y1) + (x(4)*(x1^2)) + (x(5)*x1*y1) + (x(6)*y1^2);
    N2 = x(1) + x(2)*x2 + x(3)*y2 + x(4)*x2^2 + x(5)*x2*y2 + x(6)*y2^2;

    disp("mo = " + mo)
    disp("geoid height of N1 = "+  N1)
    disp("geoid height of N2 = "+  N2)
    