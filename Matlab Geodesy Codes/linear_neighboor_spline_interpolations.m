format long g
t=[0 0.475 0.625 1.450 2.050];
s=[0.411 0.320 0.305 0.300 0.410];
    
t0=1.257
ti_1=0.625
ti=1.450

a=(0.300-0.305)/(1.450-0.625)
alpha=tand(a)
s0=0.305+a*(1.257-0.625)

wi=(t0-ti_1)/(ti-ti_1)
wi_1=1-wi

%ploting orginal values without interpolation

%Linear
figure
s0_linear=interp1(t,s,t0,'linear');
plot(t0,s0_linear,"ro");
hold on
plot(t,s,"ro")
hold on
plot(t,s)

title('Linear-nearest-spline-legende Interpolation');

%Nearest
%figure
tfun=[-0.1:0.05:2.2]
s0_nearest=interp1(t,s,tfun,'nearest');
s0_near=interp1(t,s,t0,'nearest');
plot(t,s,'o',t0,s0_near,"ro");
hold on 
plot(tfun,s0_nearest,'g')
%title('Nearest Interpolation');


%Interpolating spline

tfun=[-0.1:0.05:2.2]
s0_spline=interp1(t,s,tfun,'spline');
s0_line=interp1(t,s,t0,'spline');
plot(t,s,'o',t0,s0_line,"ro");
hold on 
plot(tfun,s0_spline,'k')

xlabel("T");
ylabel("S");

%title('Spline Interpolation');


A=[1 t(1) t(1)^2 t(1)^3 t(1)^4 ; 
   1 t(2) t(2)^2 t(2)^3 t(2)^4;
   1 t(3) t(3)^2 t(3)^3 t(3)^4;
   1 t(4) t(4)^2 t(4)^3 t(4)^4;
   1 t(5) t(5)^2 t(5)^3 t(5)^4];
x=inv(A)*transpose(s)

A0=[1 t0 t0^2 t0^3 t0^4];

s0_leg=A0*inv(A)*transpose(s)

tfun=[-0.1:0.05:2.2]';

[ndat,dummy]=size(tfun);
sfun=zeros(ndat,1);

for i=1:ndat
    ti=tfun(i);
    si=0
    for j=1:5
        si=si+x(j)*ti^(j-1);
    end
    sfun(i)=si;
end

plot(t,s,'k*');
hold on
plot(t0,s0_leg,'ro');
hold on
plot(tfun,sfun,'b');
xlabel('t');
ylabel('s');
for ifun=1:ndat
    ti=tfun(ifun);
    si=sfun(ifun);
    tLine=[ti ti];
    sLine=[0.0 si];
    plot(tLine,sLine,'-k');
end
grid on

tb=1.5;
ta=1.0;
tc=2.0;
Aa=[1 ta ta^2 ta^3 ta^4];
Ab=[1 tb tb^2 tb^3 tb^4];
Ac=[1 tc tc^2 tc^3 tc^4];
sa=Aa*inv(A)*transpose(s)
sb=Ab*inv(A)*transpose(s)
sc=Ac*inv(A)*transpose(s)

grada=(sb-sa)/(tb-ta)
gradb=(sc-sb)/(tc-tb)
curvM_b=(gradb-grada)/(tb-ta)
curvG_b=curvM_b/((1+gradb^2)^3/2)

grad0=(sb-s0)/(tb-t0)
curvM_0=(grad0-gradb)/(t0-tb)
curvG_0=curvM_0/((1+grad0^2)^3/2);