format long g

%camera positions
X0=497312.996;
Y0=5419477.065;
Z0=1158.888; 

img=imread('106.jp2');
imshow(img,[]);
hold on

omega= (-0.53451+200)*(pi/200); %(pi/200) grad to radian formula. +200 for back projection
phi= (-0.19025)*(pi/200);;  
kappa=(-0.13489)*(pi/200);  

f=10000; %focal lenght in pixel unit

%principal point of camera as pixel coordinate.
rowpixel=6912; 
colpixel=3840;

%rotation matrix elements
r11=cos(phi)*cos(kappa)+sin(phi)*sin(omega)*sin(kappa);
r12=cos(omega)*sin(kappa);
r13=-sin(phi)*cos(kappa)+cos(phi)*sin(omega)*sin(kappa);
r21=-cos(phi)*sin(kappa)+sin(phi)*sin(omega)*cos(kappa);
r22=cos(omega)*cos(kappa);
r23=sin(phi)*sin(kappa)+cos(phi)*sin(omega)*cos(kappa);
r31=sin(phi)*cos(omega);
r32=-sin(omega);
r33=cos(omega)*cos(phi);

%rotation matrix
rotmat=[r11 r12 r13 0; r21 r22 r23 0; r31 r32 r33 0; 0 0 0 1];

%focal lenght matrix with coordinate origin translation
%I used this principal point coordinates in focmat matrix. It offset the origin, center to upper-left.
focmat=[f 0 colpixel 0; 0 f rowpixel 0; 0 0 1 0];

%shift matrix
transmat=[1 0 0 -X0 ; 0 1 0 -Y0; 0 0 1 -Z0; 0 0 0 1];

data=m_shaperead("sonhali");
for i=1:149 %number of polygon
    worldcor=cell2mat(data.ncst(i));
    [bina_say,bin]=size(worldcor);
    points=zeros(bina_say,2);
    for j=1:bina_say
        pixelcor=focmat*rotmat*transmat*[worldcor(j,:)';1]; %matrix formula to world coordinate to pixel coordinate
        pixelcor=pixelcor/pixelcor(3);
        points(j,:)=pixelcor(1:2);
    end
    plot(points(:,1),points(:,2),'-pr'); %ploting each polygon's point
end  
