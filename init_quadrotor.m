%% SIMULINK INITIALIZATION SCRIPT
% clear all; close all; clc;
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

%% Navigation 
%% HELICAL TAKEOFF TRAJECTORY (NED Frame)
t_sim = 0:0.01:40; % Run simulation for 40 seconds
t_sim = t_sim(:);  % Force into column vector

% Initialize empty command profiles
x_data = zeros(length(t_sim), 1);
y_data = zeros(length(t_sim), 1);
z_data = zeros(length(t_sim), 1);
psi_data = zeros(length(t_sim), 1); 

%% Helical Parametrization
% Parameters for the helix (0 to 20 seconds)
t_takeoff = 20;               % Time duration of the helical takeoff
radius = 2;                  % 2-meter radius spiral
turns = 3;                    % Number of full 360-degree loops
w = (2 * pi * turns) / t_takeoff; % Angular velocity (rad/s)
max_altitude = -5;           % Target altitude (NED: Z = -5m is 5 meters up)

% Logical mask for the takeoff phase
takeoff_idx = (t_sim >= 0 & t_sim <= t_takeoff);

%% Phase 1: Helical Takeoff (0 to 20s)
% X and Y use sine/cosine to form the circle. 
% Offset X by -radius so the quadrotor starts exactly at (0,0) instead of a jump.
x_data(takeoff_idx) = radius * cos(w * t_sim(takeoff_idx)) - radius;
y_data(takeoff_idx) = radius * sin(w * t_sim(takeoff_idx));

% Z climbs linearly from 0 to max_altitude
z_data(takeoff_idx) = (max_altitude / t_takeoff) * t_sim(takeoff_idx);

% Optional: Point the nose (yaw) along the direction of travel
psi_data(takeoff_idx) = w * t_sim(takeoff_idx) + pi/2; 

%% Phase 2: Steady Hover at Apex (20s to end)
hover_idx = (t_sim > t_takeoff);

% Lock into the final position coordinates from the end of the helix
x_data(hover_idx) = x_data(find(takeoff_idx, 1, 'last'));
y_data(hover_idx) = y_data(find(takeoff_idx, 1, 'last'));
z_data(hover_idx) = max_altitude;
psi_data(hover_idx) = psi_data(find(takeoff_idx, 1, 'last'));

%% Package the arrays for your Simulink "From Workspace" blocks
X_data = [t_sim, x_data];
Y_data = [t_sim, y_data];
Z_data = [t_sim, z_data];
psi_des = [t_sim, psi_data]; 

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

figure(); hold on; grid on;
plot(t, state_hist(1:3,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Inertial Position [m]",FontSize=14);
title("Inertial Position vs Time",FontSize=18);
legend("x","y","z");

figure(); hold on; grid on;
plot(t, state_hist(4:5,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Radians [rad]",FontSize=14);
title("Euler Angles vs Time",FontSize=18);
legend("phi","theta");%,"psi");

figure(); hold on; grid on;
plot(t, state_hist(7:9,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Velocity [m/s]",FontSize=14);
title("Velocities vs Time",FontSize=18);
legend("u","v","w");

figure(); hold on; grid on;
plot(t, state_hist(10:12,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Angular velocities [rad/s]",FontSize=14);
title("Angular Velocities vs Time",FontSize=18);
legend("p","q","r");