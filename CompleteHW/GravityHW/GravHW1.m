% SIO 229 Homework 1
clear all; close all; clc

%% Problem 1.1a
% Calculate the interia of Earth using I = mr^2 for four spherical layers

% Calculate the mass for the layers if the sphere is filled entire of that
% material
% Inner core mass
radiusIC = 1215;            % radius of inner core km
densityIC = 13e12;          % density of inner core kg/km^3
massIC = (4/3)*pi*(radiusIC)^3*densityIC;
% Outer core mass
radiusOC = 2255+radiusIC;            % radius of outer core km
densityOC = 12.2e12;                   % density of outer core kg/km^3
massOC = (4/3)*pi*(radiusOC)^3*densityOC;
% Mantle mass
radiusMan = 2900 +radiusOC;            % radius of mantle km
densityMan = 4.5e12;                    % density of mantle kg/km^3
massMan = (4/3)*pi*(radiusMan)^3*densityMan;
% Ocean mass
radiusOcean = 3 +radiusMan;            % radius of ocean km
densityOcean = 1.03e12;                    % density of mantle kg/km^3
massOcean = (4/3)*pi*(radiusOcean)^3*densityOcean;

% Calculate the inertia for the layers
% Inertia inner core
inertiaIC = (2/5)*massIC*radiusIC^2;
% Inertia outer core
inertiaOC = (2/5)*massOC*radiusOC^2 - (2/5)*massOC*radiusIC^2;
% Inertia mantle
inertiaMan = (2/5)*massMan*radiusMan^2 - (2/5)*massMan*radiusOC^2;
% Inertia ocean
inertiaOcean = (2/5)*massOcean*radiusOcean^2 - (2/5)*massOcean*radiusMan^2;

% Sum of all layers (kg)
inertiaEarth = inertiaIC + inertiaOC + inertiaMan + inertiaOcean

%% Problem 1.1b

%  Earth's inerta tensor assuming spherical layers of inner core, outer
%  core, mantle, and a layer of ocean

% spherical inertia tensor
Mearth = inertiaEarth*eye(3)

%% Problem 1.1c
% angular momentum of Earth's spin axis assuming spherical and rotation
% rate of 7.2921150e-5 rad/s

earthRot= 7.2921150e-5;         % Earth's rotation rate radian/sec
omega = [0; 0; earthRot];       % Angular velocity radians/ sec
tperiod = 2*pi/omega;           % Earth's period, length of a day in sec
L = Mearth*omega                % Angular momentum kg*km^2/sec

%% Problem 2.1a

% Thin spherical shell of 400 Gt of ocean inertia
ocean400Gt = 4e14;              % 400 Gt of water to kg
M400Gt = (2/3)*ocean400Gt*radiusOC^2*eye(3) % inertia of water 400Gt

% Point mass location of Greenland approximate 70 degrees N of Equator
% x3 is the axial spin
s2 = radiusOcean*sind(20)          % km
s3 = radiusOcean*sind(70)          % km
s1 = 0;                             % km

% Inertia of Greenland as a pointmass
greenInertia = [s2^2+s3^2 -s1*s2 -s1*s3; -s2*s1 s1^2+s3^2 -s2*s3; -s3*s1 -s3*s2 s1^2+s2^2];
Mgreen = ocean400Gt*greenInertia

% Inertia tensor of Earth with Greenland as a pointmass
Mearth2 = Mearth-M400Gt+Mgreen

%% Problem 2.1b

% Calculate new angular velocity assuming angular momentum vector is
% conserved.
omega2 = Mearth2\L

% Earth's period, length of a day in seconds
tperiod2 = 2*pi/omega2

tperiod-tperiod2






