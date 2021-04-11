d=linspace(1,365);
xlabel("Day of Year")
ylabel("Minutes of Time")
title("The Equation of Time")

y3=-7.655*sin(2*pi*d/365); %earts eliptic orbit
y4=9.873*sin((4*pi*d/365)+3.588); %tilt of earth axis
y5=y3+y4; %orbit+tilt
plot(d,y5,"b")
hold on
plot(d,y3,"r")
hold on
plot(d,y4,"y")
hold on
legend("orbit+tilt","earth's eliptic orbit","tilt of earth axis")