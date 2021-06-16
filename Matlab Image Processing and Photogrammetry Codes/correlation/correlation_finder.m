%importing image
img=imread('Sentl_20170629.tif');

%dividing into bands
bant1 = img(:, :, 1);
bant2 = img(:, :, 2);
bant3 = img(:, :, 3);
bant4 = img(:, :, 4);

% median
med1=median(bant1(:));
a1=fprintf('median bant1 %.0f\n',med1); %it prints and %.0f\n for showing results numeric format


med2=median(bant2(:));
a2=fprintf('median bant2 %.0f\n',med2);


med3=median(bant3(:));
a3=fprintf('median bant3 %.0f\n',med3);


med4=median(bant4(:));
a4=fprintf('median bant4 %.0f\n',med4);

% mean
m1 = mean(bant1(:));
a12=fprintf('mean bant1 %.0f\n',m1);

m2 = mean(bant2(:));
a22=fprintf('mean bant2 %.0f\n',m2);

m3 = mean(bant3(:));
a32=fprintf('mean bant3 %.0f\n',m3);

m4 = mean(bant4(:));
a42=fprintf('mean bant4 %.0f\n',m4);

%mode

mo1=mode(bant1(:));
a13=fprintf('mode bant1 %.0f\n',mo1);

mo2=mode(bant2(:));
a23=fprintf('mode bant2 %.0f\n',mo2);

mo3=mode(bant3(:));
a33=fprintf('mode bant3 %.0f\n',mo3);

mo4=mode(bant4(:));
a43=fprintf('mode bant4 %.0f\n',mo4);

%min
mi1=min(bant1(:));
fprintf('min value bant1 %.0f\n',mi1)

mi2=min(bant2(:));
fprintf('min value bant2 %.0f\n',mi2)

mi3=min(bant3(:));
fprintf('min value bant3 %.0f\n',mi3)

mi4=min(bant4(:));
fprintf('min value bant4 %.0f\n',mi4)

%max
ma1=max(bant1(:));
fprintf('max value bant1 %.0f\n',ma1)

ma2=max(bant2(:));
fprintf('max value bant2 %.0f\n',ma2)

ma3=max(bant3(:));
fprintf('max value bant3 %.0f\n',ma3)

ma4=max(bant4(:));
fprintf('max value bant4 %.0f\n',ma4)

%standart deviation
S1 = std(double(bant1(:)));
fprintf('standart deviation of bant1 %.0f\n',S1)

S2 = std(double(bant2(:)));
fprintf('standart deviation of bant2 %.0f\n',S2)

S3 = std(double(bant3(:)));
fprintf('standart deviation of bant3 %.0f\n',S3)

S4 = std(double(bant4(:)));
fprintf('standart deviation of bant1 %.0f\n',S4)

%covariance matrixes between bands

cov12=cov(double(bant1(:)),double(bant2(:)))
cov13=cov(double(bant1),double(bant3))
cov14=cov(double(bant1(:)),double(bant4(:)))
cov23=cov(double(bant2(:)),double(bant3(:)))
cov24=cov(double(bant2(:)),double(bant4(:)))
cov34=cov(double(bant3(:)),double(bant4(:)))

%Correlation Histograms of pixel’s gray value to nearest pixel’s gray value
x1 = double(bant3(:,1:end-1));
y1 = double(bant3(:,2:end));
randIndex1 = randperm(numel(x1));
randIndex1 = randIndex1(1:x1.*y1);
x = x1(randIndex1);
y = y1(randIndex1);
r_xy = corrcoef(x,y);
scatter(x,y);
xlabel('Pixel gray value on location (x,y)')
ylabel('Pixel gray value on location (x+1,y)')



%correlation between bands.
%bant1-2
corr2(bant1,bant2); 
bant1n = double(bant1)./sum(sum(double(bant1)));
bant2n = double(bant2)./sum(sum(double(bant2)));
c12=fprintf('bant 1 and bant 2 correlation is');
cor12=corr2(bant1n,bant2n)

%bant1-3
corr2(bant1,bant3) ;
bant1n = double(bant1)./sum(sum(double(bant1)));
bant3n = double(bant3)./sum(sum(double(bant3)));
c13=fprintf('bant 1 and bant 3 correlation is');
cor13=corr2(bant1n,bant3n)
%bant1-4

corr2(bant1,bant4) ;
bant1n = double(bant1)./sum(sum(double(bant1)));
bant4n = double(bant4)./sum(sum(double(bant4)));
c14=fprintf('bant 1 and bant 4 correlation is');
cor14=corr2(bant1n,bant4n) 

%bant2-3
corr2(bant2,bant3) ;
bant2n = double(bant2)./sum(sum(double(bant2)));
bant3n = double(bant3)./sum(sum(double(bant3)));
c24=fprintf('bant 2 and bant 3 correlation is');
cor23=corr2(bant2n,bant3n) 

%bant2-4
corr2(bant2,bant4) ;
bant2n = double(bant2)./sum(sum(double(bant2)));
bant4n = double(bant4)./sum(sum(double(bant4)));
c24=fprintf('bant 2 and bant 4 correlation is');
cor24=corr2(bant2n,bant4n) 

%bant3-4
corr2(bant3,bant4) ;
bant3n = double(bant3)./sum(sum(double(bant3)));
bant4n = double(bant4)./sum(sum(double(bant4)));
c34=fprintf('bant 3 and bant 4 correlation is');
cor34=corr2(bant3n,bant4n) 

