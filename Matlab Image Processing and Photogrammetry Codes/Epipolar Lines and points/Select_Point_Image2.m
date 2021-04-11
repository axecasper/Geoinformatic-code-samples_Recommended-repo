% !!Please select points with the same selecting order from image1 point selection.

%upload image
img=imread('florence2.jpg');
%get points x and y
imshow(img)
[x2,y2]=getpts
%build a matrix which is correspond to z values (all 1) according to amount
%of selected point size
number_of_point=size(x2);
z2=ones(number_of_point)



