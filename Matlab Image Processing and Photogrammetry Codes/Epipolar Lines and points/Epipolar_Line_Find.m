F23=[3.03994528999160e-08 2.65672654114295e-07 -0.000870550254997210; 4.67606901933558e-08 -1.11709498607089e-07 -0.00169128012255720; -1.38310618285550e-06 0.00140690091935993 0.999997201170569];
unnormalized=[];

[r c]=size(x2)

% calculating the epipolar line values for image3 from image2
% this for loop generate 3x1 matrix and add them to a list. In the end we
% have 3x5 matrix which is include unnormalised a,b,c values.
for i=1:r
    unnormalized=[unnormalized , F23*[x2(i); y2(i);z2(i)] ]
end 


a=[];
b=[];
c=[];

%normalizing the epipolar line values (I tested both unnormalized and
%normalized values during the ploting and both do the same)
for i=1:r
    kare=sqrt(unnormalized(1,i)^2+unnormalized(2,i)^2);
    a=[a,unnormalized(1,i)/kare];
    b=[b,unnormalized(2,i)/kare];
    c=[c,unnormalized(3,i)/kare];
end 



img2=imread('florence3.jpg');
[rimg rcol]=size(img2);
figure,imshow(img2);
hold on;

% During to line visualization it needs a domain for x axis. The
% domain determined from image size. 
[rimg rcol]=size(img2);
if rimg>rcol
    domain=rimg;
else
    domain=rcol;
end   

%plot(fimplicit(@(x,y) unnormalized(1,1)*x+unnormalized(2,1)*y+unnormalized(3,1)) , fimplicit(@(x,y) x.*a(2)+y.*b(2)+c(2)), fimplicit(@(x,y) a(3)*x+b(3)*y+c(3)), fimplicit(@(x,y) a(4)*x+b(4)*y+c(4)) , fimplicit(@(x,y) a(5)*x+b(5)*y+c(5)))

%Plotting lines. The line equation evaluate from ax+by+c=0 with leaving y
%alone.
for i=1:r
    x=0:domain;
    m=-a(i)/b(i);
    value=-c(i)/b(i);
    y=m*x+value;
    plot(x,y)
end   


