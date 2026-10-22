%% SIMULINK INITIALIZATION SCRIPT
% clear all; close all; clc;
% Constants, params, etc.
g = 9.81; % m/s^2

% Will be changing
m = 872.10/1000; % kg (max)

J = [ 0.02079801611,  0.00530252330,  0.00751732970;
      0.00530252330,  0.01801195838,  0.00977792229;
      0.00751732970,  0.00977792229,  0.01101529893 ];

Ix = J(1,1);
Iy = J(2,2);
Iz = J(3,3);

Jinv = inv(J);

cond(J)

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

B = zeros(12,4);
B(9,1) = m;
B(10:12, 2:4) = Jinv;

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
% Kpz = 150.0;
% Kiz = 0.5;
% Kdz = 60.0; % W
Kpz = 10.80567;
Kiz = 1.08057;
Kdz = 6.13958; % W

% Roll and Pitch gains
Kpphi = 24.48955;
Kiphi = 2.44895;
Kdphi = 0.92686; % p

Kptheta = 14.58697;
Kitheta = 1.45870;
Kdtheta = 0.55207; % q

% Yaw gains
Kppsi = 0.16519;
Kipsi = 0.01652;
Kdpsi = 0.05506; % r

% Velocity specific gains
Kpu = 0.81125;
Kpv = 0.81125;

% Outerloop gains
Kpx = 0.39792;
Kpy = 0.39792;

%% Navigation 
% LAWNMOWER SEARCH TRAJECTORY (0.4 m/s Cruise, 5s Corner Pauses, Fixed Heading)
% 1. Grid Geometry & Kinematic Setup
box_size = 5.0;        % 5x5 meter bounding area
sep = 1.25;            % 1.25 meter horizontal leg separation
target_altitude = -1.8; % NED Frame: 90% of 2m upward is Z = -1.8m
cruise_speed = 0.4;    % Locked velocity profile (m/s) for both Horiz & Vert
accel = 0.4;           % Acceleration / Deceleration rate (m/s^2)
pause_time = 5.0;      % Pause duration at corners (seconds)

% Define the geometric vertices of the lawnmower pattern
WP = [ ...
    0.00,  0.00;   % WP1: Start Corner (Ground)
    0.00,  0.00;   % WP2: At Altitude (After initial climb)
    0.00,  5.00;   % WP3: End of Leg 1
    1.25,  5.00;   % WP4: End of Transition 1
    1.25,  0.00;   % WP5: End of Leg 2
    2.50,  0.00;   % WP6: End of Transition 2
    2.50,  5.00;   % WP7: End of Leg 3
    3.75,  5.00;   % WP8: End of Transition 3
    3.75,  0.00;   % WP9: End of Leg 4
    5.00,  0.00;   % WP10: End of Transition 4
    5.00,  5.00];  % WP11: Final Destination Corner

num_wp = size(WP, 1);

% 2. Calculate Exact Kinematic Profiles for Each Segment
t_acc = cruise_speed / accel; 
d_acc = 0.5 * accel * t_acc^2; % Distance covered during acceleration/deceleration

current_time = 0;
x_chunks = {}; y_chunks = {}; z_chunks = {}; t_chunks = {};
dt = 0.01; % 100Hz timeline matching Pixhawk loop

for i = 1:(num_wp - 1)
    p1 = WP(i, :);
    p2 = WP(i+1, :);
    
    if i == 1
        % Phase 1: Trapezoidal Vertical Takeoff Climb up to 1.8m
        d_total_z = abs(target_altitude);
        
        if d_total_z >= (2 * d_acc)
            d_cruise_z = d_total_z - (2 * d_acc);
            t_cruise_z = d_cruise_z / cruise_speed;
            t_climb_total = (2 * t_acc) + t_cruise_z;
        else
            % Fallback for short profiles if they never hit full cruise
            t_acc_short = sqrt(d_total_z / accel);
            t_climb_total = 2 * t_acc_short;
            t_acc = t_acc_short;
            t_cruise_z = 0;
        end
        
        % Build time arrays for takeoff segment
        t_move_z = 0 : dt : t_climb_total;
        t_pause_z = (t_climb_total + dt) : dt : (t_climb_total + pause_time);
        t_takeoff = [t_move_z, t_pause_z];
        
        z_leg = zeros(size(t_takeoff));
        
        for k = 1:length(t_takeoff)
            tk = t_takeoff(k);
            if tk <= t_acc
                dist_z = 0.5 * accel * tk^2;
            elseif tk <= (t_acc + t_cruise_z)
                dist_z = d_acc + cruise_speed * (tk - t_acc);
            elseif tk <= t_climb_total
                t_dec = tk - t_acc - t_cruise_z;
                dist_z = d_total_z - (0.5 * accel * (t_acc - t_dec)^2);
            else
                dist_z = d_total_z;
            end
            z_leg(k) = -dist_z;
        end
        
        t_chunks{i} = t_takeoff + current_time;
        x_chunks{i} = p1(1) * ones(size(t_takeoff));
        y_chunks{i} = p1(2) * ones(size(t_takeoff));
        z_chunks{i} = z_leg;
        
        current_time = current_time + t_climb_total + pause_time;
    else
        % Phase 2: Horizontal Grid Segments (Trapezoidal + 5s Pause)
        d_total = norm(p2 - p1);
        direction = (p2 - p1) / d_total;
        
        if d_total >= (2 * d_acc)
            d_cruise = d_total - (2 * d_acc);
            t_cruise = d_cruise / cruise_speed;
            t_move_total = (2 * t_acc) + t_cruise;
        else
            t_acc_short = sqrt(d_total / accel);
            t_move_total = 2 * t_acc_short;
            t_acc = t_acc_short;
            t_cruise = 0;
        end
        
        t_move = 0 : dt : t_move_total;
        t_pause = (t_move_total + dt) : dt : (t_move_total + pause_time);
        t_leg = [t_move, t_pause];
        
        x_leg = zeros(size(t_leg));
        y_leg = zeros(size(t_leg));
        
        for k = 1:length(t_leg)
            tk = t_leg(k);
            if tk <= t_acc
                dist = 0.5 * accel * tk^2;
            elseif tk <= (t_acc + t_cruise)
                dist = d_acc + cruise_speed * (tk - t_acc);
            elseif tk <= t_move_total
                t_dec = tk - t_acc - t_cruise;
                dist = d_total - (0.5 * accel * (t_acc - t_dec)^2);
            else
                dist = d_total;
            end
            
            pos_2d = p1 + dist * direction;
            x_leg(k) = pos_2d(1);
            y_leg(k) = pos_2d(2);
        end
        
        t_chunks{i} = t_leg + current_time;
        x_chunks{i} = x_leg;
        y_chunks{i} = y_leg;
        z_chunks{i} = target_altitude * ones(size(t_leg));
        
        current_time = current_time + t_move_total + pause_time;
    end
end

% 3. Combine Chunks and Package for Simulink
t_sim = unique(cat(2, t_chunks{:})');
x_data = zeros(size(t_sim));
y_data = zeros(size(t_sim));
z_data = zeros(size(t_sim));

for i = 1:length(t_chunks)
    [~, idx] = intersect(t_sim, t_chunks{i}');
    x_data(idx) = x_chunks{i};
    y_data(idx) = y_chunks{i};
    z_data(idx) = z_chunks{i};
end

% Keep Yaw locked at 0 so movement relies entirely on pitch and roll dynamics
psi_data = zeros(length(t_sim), 1); 

X_data = [t_sim, x_data];
Y_data = [t_sim, y_data];
Z_data = [t_sim, z_data];
psi_des = [t_sim, psi_data];

%% Plotting
% Extract data
t = out.flight_history.Time;
state_hist = out.flight_history.Data';

% 3D plot
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

% Position (x,y,z)
figure(); hold on; grid on;
plot(t, state_hist(1:3,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Inertial Position [m]",FontSize=14);
yline(-1.8,'--r') % Desired z height (90% of 2m to account for 10% overshoot error)
title("Inertial Position vs Time",FontSize=18);
legend("x","y","z","Desired z");

% Euler Angles
figure(); hold on; grid on;
plot(t, state_hist(4:5,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Radians [rad]",FontSize=14);
% Upper/Lower Bound limits  on roll angles set to 25 degrees
% yline(deg2rad(25),'--r')
% yline(-deg2rad(25),'--r')
title("Euler Angles vs Time",FontSize=18);
legend("phi","theta");%,"Upper Bound Roll Angle","Lower Bound Roll Angle");%,"psi");

% Linear Velocities
figure(); hold on; grid on;
plot(t, state_hist(7:9,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Velocity [m/s]",FontSize=14);
% Velocity limits
yline(0.5,'--r')
yline(-0.5,'--r')
title("Velocities vs Time",FontSize=18);
legend("u","v","w","Upper/Lower Bounds on Velocity");

% Angular Velocities
figure(); hold on; grid on;
plot(t, state_hist(10:12,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Angular velocities [rad/s]",FontSize=14);
title("Angular Velocities vs Time",FontSize=18);
legend("p","q","r");