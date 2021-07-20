% SIO 229 Gravity and Geomagnetism HW #2
clear all; close all; clc

%% Question 2A
% Write in the data vector d associated with this data

% Site location in latitude and longitude. Converted to theta and phi
siteLat = [-85.00; 85.00; 85.00; 37.80; 51.50; 30.00; 40.70; -23.5; -33.90;
    -31.95; -33.90];
siteLon = [180.00; 0.00; 116.40; -122.40; -0.13; 31.20; -74.00; -46.60;
    18.42; 115.90; 151.20];

theta = 90 - siteLat;           % theta in degrees
phi = siteLon;                  % phi in degrees
N = length(theta);

% Elements of the magnetic field in nT
X = -[-11489.98; 4299.58; 28149.16; 22271.61; 19513.26; 31272.19; 20512.93;
    16604.76; 9202.13; 23415.41; 24400.95];
Y = [9038.53; 7.02; -3373.34; 5685.59; -241.62; 2841.33; -4781.95; -5766.60;
    -4666.18; -549.91; 5652.93];
Z = -[-56215.10; 55749.08; 46548.43; 42496.19; 44814.76; 30123.66; 46697.48;
    -14384.17; -23644.95; -53993.09; -50885.50];

% Data vector containing all the magnetic field
d = [X; Y; Z]

%% Question 2C
% Evaluate the elements of this G matrix

% Columns of G
G1 = [sind(theta); zeros(N,1); 2*cosd(theta)];
G2 = [-cosd(theta).*cosd(phi); -sind(phi); 2*sind(theta).*cosd(phi)];
G3 = [-cosd(theta).*sind(phi); cosd(phi); 2*sind(theta).*sind(phi)];
 
G = [G1 G2 G3]

%% Question 2D
% Calculate G'G, G'd, (G'G)^-1

GtG  = G'*G
Gtd = G'*d
invGtG = inv(GtG)

%% Question 2E
% Find the least squares solution for the l=1 model parameters

% b is the vector g01 g11 h11 in nT
b = G\d

%% Question 2F

IFRP2020 = [-29404.58; -1450.9; 4652.5];
difference = abs((IFRP2020 - b)./(IFRP2020))*100

%% Question 2G
% Do your results depend on the available data distribution?

figure(1)
plot(siteLon, siteLat,'*')
set(gcf,'color','w');
xlabel('Longitude (degrees)','FontSize',15)
ylabel('Latitude (degrees)','FontSize',15)
title('Data Distribution','FontSize',20)

%% Question 2h

f = 1/(298.257);
