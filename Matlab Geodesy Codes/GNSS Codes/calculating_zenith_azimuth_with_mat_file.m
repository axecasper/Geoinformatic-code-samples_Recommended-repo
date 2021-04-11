format long g
Mat=load('igs20993.mat')
deneme(:,:,:)=Mat.sat.gps(:,:,:);

%(2+1+6+3+2+7+3+4)*720=20160 but in 20160th epoch not seen 5 gps satellite
%so i added +720 more and my new epoch is 20880
%20160/900=22.4 
%20880/900=23.2
%satellites ankr that seen in this epoch  5,7,9,28,30
t=20880;
epoch=round((t/900)+1); %rows of my epoch in .mat file +1 cause round makes 23.2 to 23. If round makes 23.6 like to 24 then we should delete +1

a=6378137; 
b=6356752.3;
w = 7.292115e-5;
%w=7292115.0*(10^-11);
c = 299792458;
ANKR = [4121934.2600 2652189.8120 4069034.9110];

f=(a-b)/a;
ekare=2*f-f^2;

%gps number and pseudo range 
NumC1=[5 21668962.829;
       7 21223566.242;
       9 22495445.424;
       28 21565550.382;
       30 20531203.306];
   
[uydusayisi verisayisi]=size(NumC1);

lagrangeEpoch=[17100 18000 18900 19800 20700 21600 22500 23400 24300 25200]; %Lagrange epochs in second
emission=[];
error=[];
%t1=[]
Koordinatlar=zeros(5,3);
for j=1:uydusayisi %Doing it for 5 satellite
    t1=t-(NumC1(j,2)/c); %Calculating new time from each satellites pseudo ranges.
        
    E_lagrange=0;
    %Starting lagrange for clock error.
    for i=epoch-4:epoch+5 %my lagrange range 24-4=20 to 29 rows. 20 means 4 hours 45 min and 29th row means 7 hours 0 minutes.
        A=1;
        for k=epoch-4:epoch+5
            if i~=k
                A=A*((t1-lagrangeEpoch(1,k-19))/(lagrangeEpoch(1,i-19)-lagrangeEpoch(1,k-19)));  %i-19 means 24-4-19=1 , 24-3-19=2... that get lagrangeEpochs 1x10's elements counting 1 to 10.
            end
        end   
        
        E_lagrange=E_lagrange+deneme(i,4,NumC1(j,1))*A; %i means epoch rows , 4 means column and that means clock error , NumcCL(j,1)) means rows and that means sat numbers
        
    end  
    error=[error,E_lagrange]; %1x5 matrix include clock error for 5 satellites.
    emission=[emission,t1-error(1,j)]; %1x5 emission time matrix
end   
disp("clock errors")
disp(error) 
disp("emission times")
disp(emission)
for j=1:uydusayisi
    
    for xyz=1:3
       
        Koor=0;
        for i=epoch-4:epoch+5
            A=1;
            for k=epoch-4:epoch+5
                 if i~=k
                      A=A*((emission(1,j)-lagrangeEpoch(1,k-19))/(lagrangeEpoch(1,i-19)-lagrangeEpoch(1,k-19))); %epoch calcualting from emission time matrix for each satellite.
                 end
            end
            Koor=Koor+deneme(i,xyz,NumC1(j,1))*A; %Getting xyz values.
            
        end
        Koordinatlar(j,xyz)=Koor;  %Replacing xyz for 5 satellites into 5x3 matrix.
    end   
end

pseudo2=[];
for j=1:uydusayisi
   yenipseudo=sqrt((ANKR(1)-Koordinatlar(j,1))^2+(ANKR(2)-Koordinatlar(j,2))^2+(ANKR(3)-Koordinatlar(j,3))^2);
   pseudo2=[pseudo2,yenipseudo]; %saving all result into a list
   delta_t2(1,j) = pseudo2(1,j)/c;
   omega(1,j) = w*delta_t2(1,j);
   R3 = [cos(omega(1,j)) sin(omega(1,j)) 0;-sin(omega(1,j)) cos(omega(1,j)) 0;0 0 1];
   Coordinates = transpose(R3*transpose(Koordinatlar)); % getting transpose again to make it 3x5 to 5x3 again.
end
disp("Sat Coordinates")
disp(Coordinates)


%cartesian to elipsoid. building 1x5 matrix for each value for each satellite
%h fi lambda
lambda=atand(ANKR(2)/ANKR(3)); 
p=sqrt(ANKR(1)^2+ANKR(2)^2);
fiapprox=atand(ANKR(3)/p*((1-ekare))^-1); %h=0 iken
u=0;
N=a/sqrt(1-ekare*(sind(fiapprox).^2));
h=(p/cosd(fiapprox))-N;
fii=atand(ANKR(3)/p*((1-ekare*(N/(N+h)))^-1));
while u==0
    if abs(fii-fiapprox)>10^-12
        N=a/sqrt(1-ekare*(sind(fii).^2));
        h=(p/cosd(fii))-N;
        fii=atand(ANKR(3)/p*((1-ekare*(N/(N+h)))^-1));
        u=~0;
        disp('h is =')
        disp(h);
        disp('fii is =')
        disp(fii);
        disp('lambda is =')
        disp(lambda);
    else
        fii=fiapprox;
    end
end


zenith=[];
azimuth=[];
for j=1:uydusayisi
    A=[-sind(fii)*cosd(lambda) -sind(lambda) cosd(fii)*cosd(lambda); -sind(fii)*sind(lambda) cosd(lambda) cosd(fii)*sind(lambda); cosd(fii) 0 sind(fii)];
  
    DX=[Coordinates(j,1)-ANKR(1); Coordinates(j,2)-ANKR(2); Coordinates(j,3)-ANKR(3)];
    S=sqrt((Coordinates(j,1)-ANKR(1))^2+(Coordinates(j,2)-ANKR(2))^2+(Coordinates(j,3)-ANKR(3))^2);      
    dx=transpose(A)*DX;
    zenith(1,j)=acosd(dx(3,1)/S);
    azimuth(1,j)=atan2d(dx(2,1),dx(1,1));
    %disp(S)
end   
disp("zenith")
disp(transpose(zenith))
disp("azimuth")
disp(transpose(azimuth))