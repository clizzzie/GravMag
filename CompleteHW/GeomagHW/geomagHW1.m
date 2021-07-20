% SIO 229 Homework 3, Magnetism HW # 1
clear all; close all; clc

%% Question 1: Plot magnetic field elements against latitude
% Suppose we have a magnetic dipole with dipole moment m at Earth's
% center and oriented along Earth's axis. Calculate (i) the magnetic field
% elements B_r, B_{theta}, B_{phi}, and (ii) the declination , inclination,
% and intensity as a function of latitude.

% Calculate the magnetic field as a function of latitude

rEarth = 6371000;               % Earth's radius in m
mu0 = 4*pi*1e-7;                % Permeability of vacuum in henries/meters
m = 8e22;                       % Dipole moment in ampere*m^2
theta = 0:180;                  % colatitude in degrees
phi = 0:360;                     % longitude in degrees
B_r = mu0*m*(2*cosd(theta))/(4*pi*rEarth^3); % Magnetic field in tesla for unit r
B_theta = mu0*m*(sind(theta))/(4*pi*rEarth^3); % Magnetic field in tesla for unit theta
B_phi =zeros(1,length(theta));              % Magnetic field in tesla for unit phi

figure(1)
plot(theta, B_r,'LineWidth',1)
hold on
plot(theta, B_theta,'LineWidth',1)
plot(theta, B_phi,'LineWidth',1)
title('B_r, B_{\theta}, B_{\phi} vs. Colatitude','FontSize',15)
xlabel('Colatitude \theta in degrees','FontSize',15)
ylabel('B components T','FontSize',15)
set(gcf,'color','w');
legend('B_r', 'B_{\theta}', 'B_{\phi}')
hold off

% Convert B to inclination in degrees
inclin = atand(-B_r./sqrt(B_theta.^2+B_phi.^2));
% Convert B to declination in degrees
declin = atand(B_r./-B_theta); 
% Convert B to intensity in teslas
inten = sqrt(B_r.^2+B_theta.^2+B_phi.^2);

figure(2)
yyaxis left
plot(theta, inclin,'LineWidth',1)
hold on
plot(theta, declin,'LineWidth',1)
ylabel('Degrees')
yyaxis right
plot(theta, inten,'LineWidth',1)
title('Inclination, Declination, and Intensity vs. Colatitude','FontSize',15)
xlabel('Colatitude \theta in degrees')
ylabel('Intensity (T)')
legend('Inclination (degrees)','Declination (degrees)','Intensity (tesla)')
set(gcf,'color','w');
hold off

%% Question 2c: Calculate the magnetic dipole from Gauss Coefficients

% Gauss Coefficients from IGRF-2000
g10_2000 = -29615e-9;
g11_2000 = -1728e-9;
h11_2000 = 5186e-9;

% Gauss Coefficients from IGRF-2020
g10_2020 = -29404.8e-9;
g11_2020 = -1450.9e-9;
h11_2020 = 4652.5e-9;

% Dipole moment

m_2000=4*pi*rEarth^3*norm([g10_2000 g11_2000 h11_2000])/mu0
m_2020=4*pi*rEarth^3*norm([g10_2020 g11_2020 h11_2020])/mu0
