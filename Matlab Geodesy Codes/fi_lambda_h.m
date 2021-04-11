function [output] = rotation(x,y,z)
a=6378137;
b=6356752.3147;

fii=arctan(z+et*b*sin(teta)*sin(teta)*sin(teta))/(p-e2*a*cos(teta)*cos(teta)*cos(teta));
N=a/sqrt((a^2*cos(fii)*cos(fii))+(b^2*sin(fii)*sin(fii)));

x=(N+h)*cos(fii)*cos(lambda);
y=(N+h)*cos(fii)*sin(lambda);
z=((b^2)/(a^2)*N+h)*sin(fii);

p=(N+h)*cos(fii);
h=p/cos(fii)-N;
e2=(a^2-b^2)/a^2;

z=(N+h-e2*N)*sin(fii)

teta=atand(z*a/p*b);
et=(a^2-b^2)/b^2;
lambda=atand(y/x);
output=[fii,lambda,h];

end