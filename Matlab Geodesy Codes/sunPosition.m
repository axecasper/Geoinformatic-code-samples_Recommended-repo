function [azimuthAngle,elevationAngle] = sunPosition(dayOfYear,timeHour,latitude)
if size(timeHour,1) == 1 && size(timeHour,2) > 1
    timeHour = timeHour';
end
if size(dayOfYear,2) == 1 && size(dayOfYear,1) > 1
    dayOfYear = dayOfYear';
end
numTime = numel(timeHour);
numDays = numel(dayOfYear);
timeHour = repmat(timeHour,1,numDays);
longitudeShift = 0;
equationTime = 9.87*sind(2*360/365*(dayOfYear-81)) - ...
    7.53*cosd(360/365*(dayOfYear-81)) - ...
    1.5*sind(360/365*(dayOfYear-81));
solarTimeCorrection = equationTime/60 + longitudeShift/15;
solarTime = timeHour + repmat(solarTimeCorrection,numTime,1);
hourAngle = 180*(12-solarTime)/12;
sunDeclinationAngle = 23.45*sind(360/365*(dayOfYear-81));
cosineZenith = bsxfun(@plus,sind(latitude)*sind(sunDeclinationAngle),...
    cosd(latitude)*bsxfun(@times,cosd(sunDeclinationAngle),cosd(hourAngle)));
zenithAngle = acosd(cosineZenith);
elevationAngle = 90 - zenithAngle;
eastVertical = bsxfun(@times,cosd(sunDeclinationAngle),sind(hourAngle));
southVertical = bsxfun(@plus,-sind(sunDeclinationAngle)*cosd(latitude), ...
    bsxfun(@times,cosd(sunDeclinationAngle),sind(latitude)*cosd(hourAngle)));
posAngle = eastVertical > 0;
azimuthAngle = zeros(numTime,numDays);
azimuthAngle(posAngle) = acosd(-southVertical(posAngle)./ ...
    sqrt(eastVertical(posAngle).^2 + southVertical(posAngle).^2));
azimuthAngle(~posAngle) = 180 + acosd(southVertical(~posAngle)./ ...
    sqrt(eastVertical(~posAngle).^2+southVertical(~posAngle).^2));
azimuthAngle = azimuthAngle;
end