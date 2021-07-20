% SIO 229 Homework 2
clear all; close all; clc

%% Problem 2.1
% Use MacCullagh's Formula to compare the difference in gravity at the pole
% and at the equator without Earth's spin and assume present shape and
% interior structure.

% g = -gradient of V
% V is MacCullagh's Formula
mEarth = 5.972e24;           % Mass of Earth (kg)
J = 0.001;                   % J_2 value for flattening roughly, unitless
a = 6378000;                 % Radius of Earth at equator m
G = 6.6743e-11;              % Gravitational constant N*m^2/kg^2

% radius and theta
rPole = 6357000;            % radius at the pole meters
thetaPole = 0;              % theta at the pole degrees

rEquator = a;               % radius at the equator meters
thetaEquator = 90;          % theta at the equator degrees

% component for g at the poles without phi
g_rPole = G*(mEarth/rPole^2-(3*a^2*J*(3*cosd(thetaPole)^2-1))/(2*rPole^4));
g_thetaPole = G*(-3*a^2*J*sind(thetaPole)*cosd(thetaPole))/rPole^4;

% component for g at the equator without phi
g_rEquator = G*(mEarth/rEquator^2-(3*a^2*J*(3*cosd(thetaEquator)^2-1))/(2*rEquator^4));
g_thetaEquator = G*(-3*a^2*J*sind(thetaEquator)*cosd(thetaEquator))/rEquator^4;

%% Problem 2.2

% Calculate the value of the geopotential U on the geoid

w = 7.2921150e-5;       % Earth's spin rate (rad/s)
theta = 0:180;          % degrees of latitude

f = (3/2)*J+(a^3*w^2)/(2*G*mEarth);     % flattening, unitless
r0 = a*(1-f*cosd(theta).^2);            % changing radius value in meters
P = (1/2)*(3*cosd(theta).^2-1);         % Legrende Polynomial, unitless

mono = -G*mEarth./r0;                   % Monopole  N*m/kg
quad = (G*mEarth*a^2)*(J*P)./(r0.^3);   % Quadrupole  N*m/kg
spin = -(1/2)*w^2*r0.^2.*sind(theta).^2;  % Rotation  m^2/s^2

U0= mono+quad+spin;                     % Geopoential U on the geoid

U0mean = mean(U0)

figure(1)
subplot(2,1,1)
plot(theta, U0,'LineWidth',1)
hold on
plot(theta, mono,'LineWidth',1)
ylabel('Potential (m^2/s^2 or Nm/kg)','FontSize',15)
legend('U_0','Monopole')
hold off
title('U_0 Summation of Monopole, Quadrupole, and Rotation','FontSize',15)
subplot(2,1,2)
plot(theta,quad,'r','LineWidth',1)
hold on
plot(theta, spin,'k','LineWidth',1)
ylabel('Potential (m^2/s^2 or Nm/kg)','FontSize',15)
legend('Quadrupole','Rotation')
xlabel('Colatitude \theta (degrees)','FontSize',15)
set(gcf,'color','w');
hold off

%% Problem 2.3

% Find the rotation rate, omega, when the Mississippi starts to flow
% backward from South to North. Assuming the Earth does not change shape.
% The source of the Mississippi is 47 degrees North and the delta is 29
% degrees North of the Equator.

MissLatS = 43;          % Mississippi source colatitude from the pole degrees
MissLatD = 61;          % Mississippi delta colatitude from the pole degrees

radiusSource = r0(44)+450;      % radius of source in meters
Psource = (1/2)*(3*cosd(MissLatS).^2-1);         % Legrende Polynomial for Source

% Vary omega for when potential for the source and delta are equal
omega = (-1e-4:1e-7:1e-4);   % Spin radian/sec

% Calculate the source gravitational potential, V source in N*m/kg or
% m^2/s^2
Vsource = -G*mEarth/radiusSource + G*mEarth*a^2*J*Psource/(radiusSource^3);

% Calculate the source apparent centrifugal force, depends on omega m^2/s^2
SpinSource = -(1/2)*omega.^2*radiusSource^2*sind(MissLatS)^2;

% Calculate the delta gravitational potential, geoid potential, V in N*m/kg
% depends on omega
f = (3/2)*J+(a^3*omega.^2)/(2*G*mEarth);    % flattening depends on rot. rate
r0Delta = a*(1-f.*cosd(MissLatD).^2);            % radius meters depends on rotation rate
Pdelta = (1/2)*(3*cosd(MissLatD)^2-1);         % Legrende Polynomial, unitless
Vdelta = -G*mEarth./r0Delta + G*mEarth*a^2*J*Pdelta./(r0Delta.^3);

% Calculate the delta apparent centrifugal force m^2/s^2, depends on omega
SpinDelta = -(1/2)*omega.^2.*r0Delta.^2*sind(MissLatD)^2;

% Source and Delta potential equalling zero
SandDequal0 = -Vsource - SpinSource + Vdelta + SpinDelta;

T = (2*pi./omega)/(60*60);      % Period of rotation of Earth in hours
Topp = T(300)                   % Period in the opposite direction
Tsame = T(1702)                 % Period for the same direction today

figure(2)
plot(omega, SandDequal0,'LineWidth',1)
hold on
plot(omega, zeros(length(omega)),'LineWidth',1)
plot([omega(1702) omega(300)],[SandDequal0(1702) SandDequal0(300)],'k*','LineWidth',1)
% plot(omega(300), SandDequal0(300),'k*','LineWidth',1)
plot(w, 0,'mx','LineWidth',1)
ylabel('Potential (m^2/s^2 or Nm/kg)','FontSize',15)
xlabel('\omega rad/sec','FontSize',15)
title('Potential of Varying \omega','FontSize',15)
set(gcf,'color','w')
hold off













