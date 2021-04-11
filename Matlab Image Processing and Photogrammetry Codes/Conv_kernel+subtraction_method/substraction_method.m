img=imread('Image_HW05.tif');

bant1 = img(:, :, 1);

[r c]=size(bant1);


%For loop that not contains first and last rows and columns because this
%lines not have any next value for 3x3 kernel

%3x3 mean
 for i=1:c
    if i ~=	1 & i~= c %with if
    for j=1:r 
        if j ~=	1  &  j ~=	r                
        mean(j,i)=(double(bant1(j+1,i-1))+double(bant1(j+1,i))+double(bant1(j+1,i+1))+double(bant1(j,i-1))+double(bant1(j,i+1))+double(bant1(j-1,i-1))+double(bant1(j-1,i))+double(bant1(j-1,i+1))+double(bant1(j,i)))/9;
        end
    end
    end
 end
 
 %substraction
 for i=2:c-1
    
    for j=2:r-1 
                           
        meanlifark(j,i)=bant1(j,i)-mean(j,i);
       
    
    end
 end
 
 
 %Adding weighted portion of the mask back to the orginal image.
 k=9
 for i=2:c-1
    
    for j=2:r-1 
                           
        boosto(j,i)=bant1(j,i)+k*meanlifark(j,i);
       
    
    end
 end
 
 imshow(boosto)