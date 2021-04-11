img=imread('Image_HW05.tif');

bant1 = img(:, :, 1);

[r c]=size(bant1);
%[-1 -1 -1 , -1 8 -1 , -1 -1 -1] filter
 for i=2:c-1 %without if row and column directly start from 2 and finish in just before last lines.
    
    for j=2:r-1 
                           
        farkli(j,i)=((-1*double(I(j+1,i-1)))+(-1*double(I(j+1,i)))+(-1*double(I(j+1,i+1)))+(-1*double(I(j,i-1)))+(-1*double(I(j,i+1)))+(-1*double(I(j-1,i-1)))+(-1*double(I(j-1,i)))+(-1*double(I(j-1,i+1)))+(8*double(I(j,i))));
       
    
    end
 end
 
 %making negative values zero
 for i=2:c-1 %without if
    
    for j=2:r-1 
          if farkli(j,i)<0
              farkli(j,i)=0;
          else
              farkli(j,i)=farkli(j,i);
      
          end
    
    end
 end
 
 %Adding filtered image to orginal image
 
 for i=2:c-1 
    for j=2:r-1 
          added(j,i)=farkli(j,i)+bant1(j,i);
          
    end
 end
 
 imshow(added)
 
