% !!Please select points with the same selecting order from image1 point selection.

%upload image
img=imread('florence1.jpg');
imshow(img)
%get points x and y
[x1,y1]=getpts
%build a matrix which is correspond to z values (all 1) according to amount
%of selected point size
number_of_point=size(x1);
z1=ones(number_of_point)


