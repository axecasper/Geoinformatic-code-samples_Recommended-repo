%Fundemantal matrix values.
F23=[3.03994528999160e-08 2.65672654114295e-07 -0.000870550254997210; 4.67606901933558e-08 -1.11709498607089e-07 -0.00169128012255720; -1.38310618285550e-06 0.00140690091935993 0.999997201170569];
unnormalized=[];
F13=[6.04444985855117e-08 2.56726410274219e-07 -0.000602529673152695;
2.45555247713476e-07 -8.38811736871429e-08 -0.000750892330636890;
-0.000444464396704832 0.000390321707113558 0.999999361609429];
unnormalized13=[];
[r c]=size(x2)

% calculating the epipolar line values for image3 from image2
% this for loop generate 3x1 matrix and add them to a list. In the end we
% have 3x5 matrix which is include unnormalised a,b,c values.
for i=1:r
    unnormalized=[unnormalized , F23*[x2(i); y2(i);z2(i)] ]
end 
%calculating the epipolar line values for image3 from image1
for i=1:r
    unnormalized13=[unnormalized13 , F13*[x1(i); y1(i);z1(i)] ]
end 

a=[];
b=[];
c=[];

a13=[];
b13=[];
c13=[];
%normalizing the epipolar line values (I tested both unnormalized and
%normalized values during the ploting and both do the same)
for i=1:r
    kare=sqrt(unnormalized(1,i)^2+unnormalized(2,i)^2);
    a=[a,unnormalized(1,i)/kare];
    b=[b,unnormalized(2,i)/kare];
    c=[c,unnormalized(3,i)/kare];
end 

for i=1:r
    kare13=sqrt(unnormalized13(1,i)^2+unnormalized13(2,i)^2);
    a13=[a13,unnormalized13(1,i)/kare13];
    b13=[b13,unnormalized13(2,i)/kare13];
    c13=[c13,unnormalized13(3,i)/kare13];
end 


%uploading image3 for epipolar line background
img2=imread('florence3.jpg');
[rimg rcol]=size(img2);
figure,imshow(img2);
hold on

% During to point visualization it needs a domain for faster implement. The
% domain determined from image size. 
if rimg>rcol
    domain=rimg;
else
    domain=rcol;
end   

%We calculate the both epipolar lines between image1-3 and image2-3.
%Now we calculate the intersected points between those lines in our domain.
for i=1:r
   durum=@(x,y) a(i)*x+b(i)*y+c(i);
   durum2=@(x,y) a13(i)*x+b13(i)*y+c13(i);
   int= fsolve(@(X)[durum(X(1),X(2));durum2(X(1),X(2))],[0 domain]);
   scatter(int(1),int(2),'r')
end    


