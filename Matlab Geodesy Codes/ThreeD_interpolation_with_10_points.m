x=[5 1000 1000 18 194 -23 247 257 596 770] ;
y=[82 118 931 1000 249 721 1119 855 531 362];
z=[320 400 420 390 303.5 422.3 445 447.8 423.9 405.1];
x0=260;
y0=520;
L=length(x)

%%%%%%%%%%%%%%%%%%%SECOND ORDER POLYNOMIAL INTERPOLATION%%%%%%%%%%%%%%%%%
for i=1:L
    A(i,1)=1
    A(i,2)=[x(i)];
    A(i,3)=[y(i)];
    A(i,4)=[x(i)^2];
    A(i,5)=[y(i)^2];
    A(i,6)=[x(i)*y(i)];
end

X=inv(transpose(A)*A)*transpose(A)*transpose(z)
A0=[1 x0 y0 x0^2 y0^2 x0*y0];
z0=A0*X

v=A*X-transpose(z);
var=(transpose(v)*v)/(10-6);
rmse=sqrt(var)


wi=A0*inv(transpose(A)*A)*transpose(A);
total_wi=0;

for i=1:L
    total_wi=wi(i)+total_wi;
end

%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%
%%%2D OBSERVATION LOCATIONS
figure
hold on 
plot(x,y,'r+')
plot([0 1000 1000 0 0],[0 0 1000 1000 0],'k:')
axis([-100 1100 -100 1100]);
axis equal
xlabel('x')
ylabel('y')

%%% 3D OBSERVATION LOCATIONS
figure
hold on
view(-30,45);
plot3(x,y,z,'r+');
hold on
plot3(x0,y0,z0,'g+');
axis([-100 1100 -100 1100 0 700]);
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
zlim([0 1000])

%%%2D DELANUAY
TRI=delaunay(x,y);
%2d plot
triplot(TRI,x,y);
%TIN SURFACE
trisurf(TRI,x,y,z,'EdgeColor','b','FaceColor','y');

%%%%%%6%%%%%%%%%%

%Tor is point ten (10) 770 362     (10)
%Corner1 point one     5    82     (1)
%Slope a corner1 to Tor is
a=(362-82)/(770-5); %slope
number_of_points=5;
x_change=(770-5)/number_of_points; %for 5 different point x is changing 153 in each points

%first y is 82
cumilative_y=82;
cumilative_x=5;
for i=1:number_of_points
    cumilative_y=cumilative_y+a*x_change;
    linear_y(i)=cumilative_y;
    
    cumilative_x=cumilative_x+x_change;
    linear_x(i)=cumilative_x;
end
%Linear line between tor and corner1

%Getting Z values of this linear points

for i=1:number_of_points
    A0_linear(i,1)=1;
    A0_linear(i,2)=[linear_x(i)];
    A0_linear(i,3)=[linear_y(i)];
    A0_linear(i,4)=[linear_x(i)^2];
    A0_linear(i,5)=[linear_y(i)^2];
    A0_linear(i,6)=[linear_x(i)*linear_y(i)];
end
linear_z=A0_linear*X;
%distance_pieces=sqrt(((x(10)-x(1))^2)+((y(10)-y(1))^2))/6; %total of 6 equal piece between this two points

line_z=[z(1),transpose(linear_z),z(10)];
line_x=[x(1),linear_x,x(10)];
plot3(linear_x,linear_y,linear_z,'b*')

figure
plot(linear_x,linear_y,'ro')
figure
plot(line_x,line_z)
ylim([0 420])
