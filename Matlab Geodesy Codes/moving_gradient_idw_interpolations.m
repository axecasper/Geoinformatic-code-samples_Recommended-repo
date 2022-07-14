t=[0 0.475 0.625 1.450 2.050];
s=[0.411 0.320 0.305 0.300 0.410];
t0=1.2570
L=length(s)
%%%%%%%%%%%%%%%%%%%SECOND ORDER POLYNOMIAL INTERPOLATION%%%%%%%%%%%%%%%%%
for i=1:L
    A(i,1)=1
    A(i,2)=[t(i)];
    for j=1:3    
    A(1,j)=0
    A(i,3)=[t(i)^2];
    end
end
A(1,1)=1
x=inv(transpose(A)*A)*transpose(A)*transpose(s)
A0=[1 t0 t0^2];
s0=A0*x

v=A*x-transpose(s);

var=(transpose(v)*v)/(5-3);
rmse=sqrt(var)


wi=A0*inv(transpose(A)*A)*transpose(A)
total_wi=0;

for i=1:L
    total_wi=wi(i)+total_wi;
end


%%%%%%%%%%%%%%%%%%%%%%%IDW INTERPOLATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:L
    di(i)=[abs(t(i)-t0)];
end

for i=1:L
    pi(i)=1/sqrt(0.000001+di(i)^2);
end
total_pi=0;
for i=1:L
    total_pi=total_pi+pi(i)
end

for i=1:L
    above(i)=pi(i)*s(i);
end
total_above_idw=0;
for i=1:L
    total_above_idw=total_above_idw+above(i);
end

for i=1:L
    wi_idw(i)=pi(i)/total_pi;
end
total_wi_idw=0;
for i=1:L
    total_wi_idw=wi_idw(i)+total_wi_idw;
end

s0_idw_with_weight=wi_idw*transpose(s) %total above s0 (w1*s1 + w2*s2 + ... +wn*sn)

s0_idw=total_above_idw/total_pi;

%%%%%%%%%%%%%%%%%%%ISDW INTERPOLATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:L
    pi2(i)=1/(di(i)^2);
end
total_pi2=0;
for i=1:L
    total_pi2=total_pi2+pi2(i)
end

for i=1:L
    above2(i)=pi2(i)*s(i);
end
total_above2=0;
for i=1:L
    total_above2=total_above2+above2(i);
end
s0_isdw=total_above2/total_pi2;

for i=1:L
    wi_isdw(i)=pi2(i)/total_pi2;
end


total_wi_isdw=0;
for i=1:L
    total_wi_isdw=wi_isdw(i)+total_wi_isdw;
end
s0_isdw_with_weight=wi_isdw*transpose(s)

%%%%%%%%%%%%%%%%%%%%%%%%%%MOVING GRADIENT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A0_moving=[1 t0];

d0=0.35;
for i=1:L
    pi_moving(i)=exp(-(di(i)^2)/(2*d0^2));
    A2(i,1)=1;
    A2(i,2)=t(i);
end

P = diag(pi_moving);
x_moving = inv(transpose(A2)*P*A2)*transpose(A2)*P*transpose(s);
s0_moving_gradient=A0_moving*x_moving
%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tfun=[-0.1:0.01:2.2]';
[ndat,dummy]=size(tfun);
sfun=zeros(ndat,1);

%%%%%%second order polynomial%%%%%%%
for i=1:ndat
    ti=tfun(i);
    si=0
    for j=1:3
        si=si+x(j)*ti^(j-1);
    end
    sfun(i)=si;
end

plot(tfun,sfun,'b');
hold on
%%%%%%%%%%Plotting IDW%%%%%%%%%%%%%%%%%%%%%%
for i=1:ndat
    ti=tfun(i);
    for j=1:L
        di_plot(j)=[abs(t(j)-ti)];
    end
    for j=1:L
        pi_plot(j)=1/sqrt(0.000001+di_plot(j)^2);
    end
    total_pi_plot=0;
    for j=1:L
        total_pi_plot=total_pi_plot+pi_plot(j)
    end
    for j=1:L
        above_plot(j)=pi_plot(j)*s(j);
    end
    total_above_idw_plot=0;
    for j=1:L
        total_above_idw_plot=total_above_idw_plot+above_plot(j);
    end

    s0_idw_plot(i)=total_above_idw_plot/total_pi_plot;
    
end
plot(tfun,s0_idw_plot)
hold on
%%%%%%%%%%%%%%%%Ploting ISDW%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:ndat
    ti=tfun(i);
    for j=1:L
        di_plot(j)=[abs(t(j)-ti)];
    end
    for j=1:L
        pi_plot2(j)=1/(di_plot(j)^2);
    end
    total_pi_plot2=0;
    for j=1:L
        total_pi_plot2=total_pi_plot2+pi_plot2(j)
    end
    for j=1:L
        above_plot2(j)=pi_plot2(j)*s(j);
    end
    total_above_isdw_plot=0;
    for j=1:L
        total_above_isdw_plot=total_above_isdw_plot+above_plot2(j);
    end

    s0_isdw_plot(i)=total_above_isdw_plot/total_pi_plot2;
    
end
plot(tfun,s0_isdw_plot,'m')
hold on
%%%%%%%%%%Ploting moving gradient
for i=1:ndat
    ti=tfun(i);
    si=0
    for j=1:2
        si=si+x_moving(j)*ti^(j-1);
    end
    sfun_moving(i)=si;
end

%%%%same ploting same with the upper for loop%%%%%
for i=1:ndat
    sfun_move(i) = [1, tfun(i)] * x_moving;
end
plot(tfun,sfun_moving,'r');
hold on


%%%%%%%%%ploting main elements%%%%%%%%
plot(t,s,'k*');
hold on


xlabel('t');
ylabel('s')

%%%%%%ploting s0 points%%%%%%
plot(t0,s0,'ro');
hold on
plot(t0,s0_idw,'go');
hold on
plot(t0,s0_isdw,'bo');
hold on
plot(t0,s0_moving_gradient,'yo');
hold on

%%%%grids%%%%%%%%%
for ifun=1:ndat
    ti=tfun(ifun);
    si=sfun(ifun);
    tLine=[ti ti];
    sLine=[0.0 si];
    plot(tLine,sLine,'-k');
end
grid on
