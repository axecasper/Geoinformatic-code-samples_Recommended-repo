%The position of the sun is an afterthought for most, unless it is blinding you on your commute home. However, the position of the sun remains incredibly important, even in the modern age. While solar navigation through sextants was common until GPS came along, architects/engineers still track the sun for building shading and solar panel optimization. This script dives into the "analemma" which is an interesting phenomenon associated with solar observations. Try testing different latitudes to see how the sun's trajectory changes and what the analemma looks like!
x=[];
y=[];
for i=1:365
 [gelisi,altitude]=sunPosition(i,12,40); %saat ve enlem. burdan istediðimiz saati ve enlemi deðiþtirebiliriz.
 x=[x,gelisi];
 y=[y,altitude];
end
plot(x,y)
xlabel('The Azimuth angle of the sun (in highnoon(12.00))')
ylabel('The Altitude of the sun')

