I=double(imread('l7_ms.tif')); 

resim=reshape(I,size(I,1)*size(I,2),size(I,3));
[coeff,score,latent] = pca (resim); 
%latent=eigen value 
%coeff=eigen vector in other name rotation matrix or transformation matrix.

%getting total of all eigen values
toplam=0
for i=1:6
    toplam=toplam+latent(i,1) 
end
%calculating %percentage of the eigen values
yuzdelik=[];
for i=1:6
    yuzdelik=[yuzdelik,(latent(i,1)*100/toplam)];
end
%getting cumulative of the percentage of the eigen values.
cumulative=[];
cumu=0;
for i=1:6
    cumu=cumu+yuzdelik(1,i)
    cumulative=[cumulative,cumu];
end  
disp(yuzdelik)
disp(cumulative)
trans=resim*coeff; %transformed data Bwn'=W*Bwn W=coeff means transformation matrix.

img=zeros(size(I,1),size(I,2),size(I,3)); %zeros matrix
%create new image
for i=1:size(I,3);
    img(:,:,i)=reshape(trans(:,i),size(I,1),size(I,2));
end
%principal components
figure;imshow(img(:,:,1),[]);
figure;imshow(img(:,:,2),[]);
figure;imshow(img(:,:,3),[]);
figure;imshow(img(:,:,4),[]);
figure;imshow(img(:,:,5),[]);
figure;imshow(img(:,:,6),[]);

for j=1:size(I,3)
    img(:,:,j)=mat2gray(img(:,:,j));
    
end

imwrite(img(:,:,1:3),'ilk_3.tif');



