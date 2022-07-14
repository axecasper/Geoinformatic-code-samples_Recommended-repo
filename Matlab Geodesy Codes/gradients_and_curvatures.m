format long G

%  Matrix=[405.0144 410.8375 414.1418;
%     393.7644 400.9146 407.2235;
%      382.5619 390.1601 397.9959];
% Matrix=[409.5326 415.0636 418.2310;
%     398.4424 405.0110 410.8375;
%     386.8943 393.7644 400.9146];

 Matrix=[391.9633 398.4424 405.0114;
    380.4913 386.8943 393.7644;
    369.3205 375.6274 382.5619];

d=50;

z5=Matrix(1,1);
z2=Matrix(1,2);
z6=Matrix(1,3);

z1=Matrix(2,1);
z0=Matrix(2,2);
z3=Matrix(2,3);

z8=Matrix(3,1);
z4=Matrix(3,2);
z7=Matrix(3,3);

%Local gradients
G=(z3-z1)/(2*d) %dx/dy
H=(z2-z4)/(2*d) %dy/dz
%math curvature
D=(z3-2*z0+z1)/(d^2)
E=(z2-2*z0+z4)/(d^2)
F=(z6-z5-z7+z8)/(4*d^2)
%PlanCurvature
PlanC=-((H^2*D-2*G*H*F+G^2*E)/((G^2+H^2)^1.5))
%Profile Curvaure
ProfC=-((G^2*D+2*G*H*F+H^2*E)/((G^2+H^2)*(1+G^2+H^2)^1.5))
%mEAN cURVATURE:
Meanc=-((1+H^2)*D-2*G*H*F+(1+G^2)*E)/(2*(1+G^2+H^2)^1.5)

%radius mean
Radius_mean=abs(1/Meanc)

%radius profile
Radius_profile=abs(1/ProfC)

nx=-G;
ny=-H;
normal_vector=[nx; ny; 1]
slope_gradient=sqrt(nx^2+ny^2)
azimuth_of_slope=atand(nx/ny)
slope_grad_angle=atand(slope_gradient)
