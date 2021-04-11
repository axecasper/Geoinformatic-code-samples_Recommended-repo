%Import images
I1 = imread('im1.png');
I2 = imread('im2.png');

%Converting rgb to gray scale this imported images
J1 = rgb2gray(I1);
J2 = rgb2gray(I2);

%calculating disparity image
%max-min value must be divide by 16
disparityRange = [-224 0]; 
disparityMap = disparity(J2,J1,'Method','SemiGlobal','BlockSize',7,'disparityRange',disparityRange);
%imshow(disparityMap,disparityRange)

%Importing Ground truth Images
gt_1 = imread('GTdisp_im1.png');
gt_2 = imread('GTdisp_im2.png');


[row column]=size(J1);

% We convert the (-) values to (+) from orginal disparity Map because pixel values are (-)
for i=1:row
    for j=1:column
            Positive_Disparity(i,j)= -disparityMap(i,j);
    end
end

%Converting it to uint8.
%We need this because black values looks -3.4028235e+38  instead of 0 and
%all values not always integer
inverse=uint8(Positive_Disparity);

imshow(inverse)

different=0;
black_pixels=0;
for i=1:row
    for j=1:column+disparityRange(1) %with this 1:column+disparityRange(1) it does not count most right 224 column of image (lost datas).
        if gt_2(i,j)~=0 %checking pixel coordinates which is not black in ground truth
            %I used double because when ý try to take difference and ýf the
            %result will be negative; function not work well.
            %It count negative values as 0. The double function fix
            %this problem
            if abs(double(inverse(i,j))-double(gt_2(i,j)))>1; %We check the unmatched pixels between ground truth and disparity >1. The value 1 defined in pdf
                different=different+1; %We count the amount unmatched pixels
            end
            
        else
            %We count the number of black pixels in ground truth image
            black_pixels=black_pixels+1;
        
        end
    end   
end

% We calculate the difference percantege. 
%numeretor is number of different pixels
%denumerator is number of non-black pixels but we don't count the lost
%pixel datas
percentage=(different/((row*(column+disparityRange(1)))-black_pixels))*100;        

disp('differences with percantage');
disp(percentage);
disp('similarities with percantage');
disp(100-percentage);