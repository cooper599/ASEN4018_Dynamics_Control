%% SIMULINK INITIALIZATION SCRIPT
clear all; close all; clc;
% Constants, params, etc.
g = 9.81; % m/s^2
m = 5.6; % kg (max)
Ix = 0.213;
Iy = 0.213;
Iz = 0.425;

% Matrices to run with simulink
A = [0 0 0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 0 0 1 0 0 0 0;
     0 0 0 0 0 0 0 0 1 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 0 0 0 1 0;
     0 0 0 0 0 0 0 0 0 0 0 1;
     0 0 0 0 -g 0 0 0 0 0 0 0;
     0 0 0 g 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0];

B = [0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     1/m 0 0 0;
     0 1/Ix 0 0;
     0 0 1/Iy 0;
     0 0 0 1/Iz];

C = eye(12);
D = zeros(12,4);

% init_cond = [0; 0; 0;  % x,y,z
%              deg2rad(5); deg2rad(5); deg2rad(5);  % phi,theta,psi
%              0; 0; 0;  % u,v,w
%              0; 0; 0]; % p,q,r

init_cond = [0; 0; 0;  % x,y,z
             0; 0; 0;  % phi,theta,psi
             0; 0; 0;  % u,v,w
             0; 0; 0]; % p,q,r

%% Control Gains
% Vertical Gains
Kpz = 100.0;
Kiz = 40.0;
Kdz = 50.0; % w

% Roll and Pitch gains
Kpphi = 10.0;
Kiphi = 1.0;
Kdphi = 5.0; % p

Kptheta = 10.0;
Kitheta = 1.0;
Kdtheta = 5.0; % q

% Yaw gains
Kppsi = 10.0;
Kipsi = 1.0;
Kdpsi = 5.0; % r