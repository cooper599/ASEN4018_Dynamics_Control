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
Kpz = 150.0;
Kiz = 0.0;
Kdz = 60.0; % W

% Roll and Pitch gains
Kpphi = 20.0;
Kiphi = 5.0;
Kdphi = 15.0; % p

Kptheta = 20.0;
Kitheta = 5.0;
Kdtheta = 15.0; % q

% Yaw gains
Kppsi = 20.0;
Kipsi = 5.0;
Kdpsi = 15.0; % r

% Outerloop gains
Kpx = 0.25;
Kpy = 0.25;

% Velocity specific gains
Kpu = 1.0;
Kpv = 1.0;


%% Plotting
% Extract data
t = out.flight_history.Time;
state_hist = out.flight_history.Data';

figure(); grid on; hold on;
scatter3(state_hist(1,:),state_hist(2,:),state_hist(3,:),30,t,"filled")
% Create a colormap with 256 colors that goes from green to red.
m = 256; % Number of Colours
cMap = interp1([0;1], [0 1 0; 1 0 0], linspace(0,1,m)); % Start Green End Red
colormap(cMap);
cMap = colorbar;
xlabel("X Position (North +) [m]",FontSize=14);
ylabel("Y Position (East +) [m]",FontSize=14);
zlabel("Z Position (Up -) [m]",FontSize=14);
title("3D Visualization of Inertial Position",FontSize=18);
cMap.Title.String = "Time [s]";
zlim([-20 0])
set(gca,'YDir','reverse');
set(gca,'ZDir','reverse');
view(45,45)

%% Navigation 
%% MULTI-STEP WAYPOINT PROFILE TRAJECTORY
t_sim = 0:0.01:40; % Run simulation for 40 seconds
t_sim = t_sim(:);  % Force into column vector

% Initialize empty command profiles
x_data = zeros(length(t_sim), 1);
y_data = zeros(length(t_sim), 1);
z_data = zeros(length(t_sim), 1);
psi_data = zeros(length(t_sim), 1); % Keep heading flat at 0

%% Build the Waypoint Logic based on your time bounds
% Phase 1 (0 to 5s): Climb straight up to 2 meters (NED: Z = -2)
z_data(t_sim >= 0 & t_sim < 5)   = -2;

% Phase 2 (5 to 15s): Maintain 2m height, fly North 2 meters (NED: X = +2)
z_data(t_sim >= 5 & t_sim < 15)  = -2;
x_data(t_sim >= 5 & t_sim < 15)  = 2;

% Phase 3 (15 to 25s): Maintain North 2m, fly East 2 meters (NED: Y = +2)
z_data(t_sim >= 15 & t_sim < 25) = -2;
x_data(t_sim >= 15 & t_sim < 25) = 2;
y_data(t_sim >= 15 & t_sim < 25) = 2;

% Phase 4 (25 to 35s): Keep North/East coordinates, return to ground (NED: Z = 0)
z_data(t_sim >= 25 & t_sim < 35) = 0;
x_data(t_sim >= 25 & t_sim < 35) = 2;
y_data(t_sim >= 25 & t_sim < 35) = 2;

% Phase 5 (35s to end): Stay on the ground at final destination
z_data(t_sim >= 35) = 0;
x_data(t_sim >= 35) = 2;
y_data(t_sim >= 35) = 2;

%% Package the arrays for your Simulink "From Workspace" blocks
X_data = [t_sim, x_data];
Y_data = [t_sim, y_data];
Z_data = [t_sim, z_data];
psi_des = [t_sim, psi_data]; % Wire this to your Yaw input if needed