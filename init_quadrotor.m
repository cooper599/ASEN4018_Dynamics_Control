%% SIMULINK INITIALIZATION SCRIPT
% clear all; close all; clc;
% Constants, params, etc.
g = 9.81; % m/s^2

% Will be changing
m = 872.10/1000; % kg (max)
% 
% J = [ 0.02079801611,  0.00530252330,  0.00751732970;
%       0.00530252330,  0.01801195838,  0.00977792229;
%       0.00751732970,  0.00977792229,  0.01101529893 ];

% Diagonal Moments of Inertia (Stay positive)
Ixx = 40973.01 * 1e-7; % 0.0040973 kg*m^2
Iyy = 75297.41 * 1e-7; % 0.0075297 kg*m^2
Izz = 41206.15 * 1e-7; % 0.0041206 kg*m^2

% Transpose/Parallel Axis effects disappear at CoM. Off-diagonals are negligible.
Ixy = -215.54  * 1e-7; 
Ixz =  387.34  * 1e-7; 
Iyz =  684.91  * 1e-7; 

J = [ Ixx, Ixy, Ixz; 
      Ixy, Iyy, Iyz; 
      Ixz, Iyz, Izz ];

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

%{
% Vertical Gains
% Kpz = 150.0;
% Kiz = 0.5;
% Kdz = 60.0; % W
Kpz = 13.80865;
Kiz = 0.0;
% Kiz = Kpz / 1000;
% Kdz = 8.4609; % W
Kdz = 6.94047;

% Roll and Pitch gains
Kpphi = 24.48955;
% Kiphi = 2.44895/2;
Kiphi = 2.44895;
Kdphi = 0.92686; % p
% Kdphi = 1.5;

Kptheta = 14.58697;
% Kitheta = 1.45870/2;
Kitheta = 1.45870;
Kdtheta = 0.55207; % q
% Kdtheta = 1.0;

% Yaw gains
Kppsi = 7.26562;
% Kipsi = 0.72656/2;
Kipsi = 0.72656;
Kdpsi = 0.36518; % r
% Kdpsi = 0.8;

% Velocity specific gains
% Kpu = 0.81125;
% Kpv = 0.81125;
Kpu = 1.62250/0.25;
Kpv = 1.62250/0.25;

% Outerloop gains
% Kpx = 0.39792;
% Kpy = 0.39792;
Kpx = 1.59167;
Kpy = 1.59167;
%}


% %{
Kpphi =   6.48691;  
Kiphi =    0.32435;  
Kdphi =    0.24546;

Kptheta = 11.92047;
Kitheta =  0.59602;
Kdtheta = 0.45107;

Kppsi = 6.52294;
Kipsi = 0.32615;
Kdpsi = 0.32785;

Kpz =    13.80868;  
Kiz =   0;  
Kdz =    6.94047;

Kpu = 0.81125;
Kpv = 0.81125;

Kpx = 0.39792;
Kpy = 0.39792;
% %}

%% Navigation (High-Fidelity Inset Lawnmower Generation & Kinematic Profile)
% 1. Grid Geometry, Camera Specs, and Kinematic Setup
p.areaWidth = 5;              % [m]
p.areaLength = 5;             % [m]
p.altitude = 2.0;             % [m]
p.vCruise = 0.40;             % [m/s]
p.g = 9.81;                   % [m/s^2]

% Path-following assumptions matching your requirements
p.accel = 0.40;               % [m/s^2]
p.cornerHold = 5.0;           % [s] (Locked 5-second corner hold)
p.overlap = 0.20;             % [-]
p.posErrorStd = 0.05;         % [m]
p.attitudeJitterStd = 1.0;    % [deg]
p.dt = 0.01;                  % [s]

% Camera Settings & Image Resolution
p.imageResolution = [3264, 2448]; % [px]
p.hFOV = 60;                  % [deg]
p.vFOV = 2*atand((p.imageResolution(2)/p.imageResolution(1))*tand(p.hFOV/2));

% Marker & Launch Coordinates
p.markerSize = 0.08;          % [m]
launchPoint = [-2, 0];        % [m]

% Compute Footprint and Error Margins
fp.width = 2*p.altitude*tand(p.hFOV/2);
fp.length = 2*p.altitude*tand(p.vFOV/2);
crossTrackMargin = 3*p.posErrorStd + p.altitude*tand(3*p.attitudeJitterStd);
alongTrackMargin = crossTrackMargin + p.altitude*(p.accel/p.g);

% Generate Inset Waypoints dynamically using your geometry formulas
half = p.markerSize/2;
halfWidth = fp.width/2 - half - crossTrackMargin;
halfLength = fp.length/2 - half - alongTrackMargin;

if halfWidth <= 0 || halfLength <= 0
    error("Error margins exceed the camera footprint")
end

span = p.areaWidth - 2*half;
trackSpacing = 2*halfWidth*(1 - p.overlap);
nTracks = max(1, ceil((span - 2*halfWidth)/trackSpacing) + 1);

if nTracks == 1
    xlines = p.areaWidth/2;
else
    xlines = linspace(half + halfWidth, p.areaWidth - half - halfWidth, nTracks);
end

yLow = min(half + halfLength, p.areaLength/2);
yHigh = max(p.areaLength - half - halfLength, p.areaLength/2);

wpDR2 = [];
for i = 1:nTracks
    if mod(i,2) == 1
        ys = [yLow, yHigh];
    else
        ys = [yHigh, yLow];
    end
    wpDR2 = [wpDR2; xlines(i), ys(1); xlines(i), ys(2)];
end

entryPoint = min(max(launchPoint, [0 0]), [p.areaWidth p.areaLength]);
wpDR2 = [entryPoint; wpDR2];

lastPoint = wpDR2(end,:);
edges = [0, p.areaWidth, 0, p.areaLength];
[~, k] = min(abs(lastPoint([1 1 2 2]) - edges));
exitPoint = lastPoint;
exitPoint(ceil(k/2)) = edges(k);
wpDR2 = [wpDR2; exitPoint];

% Format into the operational trajectory WP matrix
% Double-up the first vertex to separate the takeoff phase from leg tracking
WP = [wpDR2(1,1), wpDR2(1,2); wpDR2]; 
num_wp = size(WP, 1);

% Configure Kinematic Profile Constraints
target_altitude = -2; % NED Frame: 90% of 2m upward is Z = -1.8m
cruise_speed = p.vCruise;
accel = p.accel;
pause_time = p.cornerHold;
dt = p.dt;

t_acc = cruise_speed / accel; 
d_acc = 0.5 * accel * t_acc^2;

current_time = 0;
x_chunks = {}; y_chunks = {}; z_chunks = {}; t_chunks = {};

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
            t_acc_short = sqrt(d_total_z / accel);
            t_climb_total = 2 * t_acc_short;
            t_acc = t_acc_short;
            t_cruise_z = 0;
        end
        
        t_move_z = 0 : dt : t_climb_total;
        t_pause_z = (t_climb_total + dt) : dt : (t_climb_total + pause_time);
        t_takeoff = [t_move_z, t_pause_z];
        
        z_leg = zeros(size(t_takeoff));
        vz_leg = zeros(size(t_takeoff)); % --- ADDED ---

        for k = 1:length(t_takeoff)
            tk = t_takeoff(k);
            if tk <= t_acc
                dist_z = 0.5 * accel * tk^2;
                vel_z = accel * tk; % --- ADDED ---
            elseif tk <= (t_acc + t_cruise_z)
                dist_z = d_acc + cruise_speed * (tk - t_acc);
                vel_z = cruise_speed; % --- ADDED ---
            elseif tk <= t_climb_total
                t_dec = tk - t_acc - t_cruise_z;
                dist_z = d_total_z - (0.5 * accel * (t_acc - t_dec)^2);
                vel_z = cruise_speed - (accel * t_dec); % --- ADDED ---
            else
                dist_z = d_total_z;
                vel_z = 0; % --- ADDED ---
            end
            z_leg(k) = -dist_z;
            vz_leg(k) = -vel_z; % --- ADDED --- (Negative for upward velocity in NED)
        end
        
        t_chunks{i} = t_takeoff + current_time;
        x_chunks{i} = p1(1) * ones(size(t_takeoff));
        y_chunks{i} = p1(2) * ones(size(t_takeoff));
        z_chunks{i} = z_leg;

        vx_chunks{i} = zeros(size(t_takeoff));
        vy_chunks{i} = zeros(size(t_takeoff));
        vz_chunks{i} = vz_leg;
        
        current_time = current_time + t_climb_total + pause_time;
    else
        % Phase 2: Horizontal Inset Grid Segments (Trapezoidal + 5s Pause)
        % --- Inside Phase 2: Horizontal Inset Grid Segments ---
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
        v_mag = zeros(size(t_leg)); 
        
        for k = 1:length(t_leg)
            tk = t_leg(k);
            if tk <= t_acc
                dist = 0.5 * accel * tk^2;
                v_mag(k) = accel * tk; % --- ADDED ---
            elseif tk <= (t_acc + t_cruise)
                dist = d_acc + cruise_speed * (tk - t_acc);
                 v_mag(k) = cruise_speed; % --- ADDED ---
            elseif tk <= t_move_total
                t_dec = tk - t_acc - t_cruise;
                dist = d_total - (0.5 * accel * (t_acc - t_dec)^2);
                v_mag(k) = cruise_speed - (accel * t_dec); % --- ADDED ---
            else
                dist = d_total;
                v_mag(k) = 0; % --- ADDED ---
            end
            
            pos_2d = p1 + dist * direction;
            x_leg(k) = pos_2d(1);
            y_leg(k) = pos_2d(2);
        end
        
        % FIX: Add dt to the baseline timeline to prevent boundary coordinate overwriting
        t_chunks{i} = t_leg + current_time + dt;
        x_chunks{i} = x_leg;
        y_chunks{i} = y_leg;
        z_chunks{i} = target_altitude * ones(size(t_leg));

        vx_chunks{i} = v_mag * direction(1);
        vy_chunks{i} = v_mag * direction(2);
        vz_chunks{i} = zeros(size(t_leg));
        
        % Increment current_time cleanly by appending the dt separation
        current_time = current_time + t_move_total + pause_time + dt;

    end
end

% 3. Combine Chunks and Package for Simulink
t_sim = unique(cat(2, t_chunks{:})');
x_data = zeros(size(t_sim));
y_data = zeros(size(t_sim));
z_data = zeros(size(t_sim));

vx_data = zeros(size(t_sim));
vy_data = zeros(size(t_sim));
vz_data = zeros(size(t_sim));

for i = 1:length(t_chunks)
    [~, idx] = intersect(t_sim, t_chunks{i}');
    x_data(idx) = x_chunks{i};
    y_data(idx) = y_chunks{i};
    z_data(idx) = z_chunks{i};
    
    vx_data(idx) = vx_chunks{i};
    vy_data(idx) = vy_chunks{i};
    vz_data(idx) = vz_chunks{i};
end

% Keep Yaw locked at 0 so movement relies entirely on pitch and roll dynamics
psi_data = zeros(length(t_sim), 1); 

% Clean time-series matrices ready for From-Workspace blocks in Simulink
X_data   = [t_sim, x_data];
Y_data   = [t_sim, y_data];
Z_data   = [t_sim, z_data];
psi_des = [t_sim, psi_data];

Vx_data   = [t_sim, vx_data];
Vy_data   = [t_sim, vy_data];
Vz_data   = [t_sim, vz_data];

%% Plotting
% Extract data
t = out.flight_history.Time;
state_hist = out.flight_history.Data';

% 3D plot
figure(); grid on; hold on;
scatter3(state_hist(1,:),state_hist(2,:),state_hist(3,:),30,t,"filled")
plot3(x_data, y_data, z_data, '--k', 'LineWidth', 2); 
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
view(215,45)
legend("Actual Flight Path", "Desired Trajectory", 'Location', 'best');

% Position (x,y,z)
figure(); hold on; grid on;
plot(t, state_hist(1:3,:), LineWidth=1.2)
plot(t_sim, x_data, ':k', 'LineWidth', 1.0);
plot(t_sim, y_data, '-.k', 'LineWidth', 1.0);
plot(t_sim, z_data, '--r', 'LineWidth', 1.2); % Replaces your hardcoded yline
xlabel("Time [s]",FontSize=14);
ylabel("Inertial Position [m]",FontSize=14);
yline(-2.0,'--r') % Desired z height (90% of 2m to account for 10% overshoot error)
title("Inertial Position vs Time",FontSize=18);
legend("Actual x", "Actual y", "Actual z", ...
       "Desired x", "Desired y", "Desired z (Altitude)", ...
       'Location', 'best');

% Euler Angles
figure(); hold on; grid on;
plot(t, state_hist(4:6,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Radians [rad]",FontSize=14);
% Upper/Lower Bound limits  on roll angles set to 25 degrees
% yline(deg2rad(25),'--r')
% yline(-deg2rad(25),'--r')
title("Euler Angles vs Time",FontSize=18);
legend("\phi","\theta","\psi");%,"Upper Bound Roll Angle","Lower Bound Roll Angle");%,"psi");

% Linear Velocities
figure(); hold on;
plot(t, state_hist(7:9,:), 'LineWidth', 1.2);
yline(0.5, '--r', 'LineWidth', 1.0);
yline(-0.5, '--r', 'LineWidth', 1.0); % Combines into the single visual bound
yline(0.4, '--k', 'LineWidth', 1.0);
yline(-0.4, '--k', 'LineWidth', 1.0); % Combines into the single visual bound

xlabel("Time [s]", 'FontSize', 14);
ylabel("Velocity [m/s]", 'FontSize', 14);
title("Velocities vs Time", 'FontSize', 18);
legend("Actual u", "Actual v", "Actual w", ...
       "Velocity Bounds","", ...
       "Desired Cruise Velocities",...
       'Location', 'best');

% Angular Velocities
figure(); hold on; grid on;
plot(t, state_hist(10:12,:), LineWidth=1.2)
xlabel("Time [s]",FontSize=14);
ylabel("Angular velocities [rad/s]",FontSize=14);
title("Angular Velocities vs Time",FontSize=18);
legend("p","q","r");

%% Spatial Path Deviation Analysis for Localization Team (Time-Independent)
% 1. Re-structure the full planned path geometry as a [N x 3] coordinate matrix
path_geometry = [x_data(:), y_data(:), z_data(:)];

% Extract actual drone path history from state history matrix [3 x M] -> [M x 3]
actual_positions = state_hist(1:3, :)'; 

M = size(actual_positions, 1);
xy = zeros(M, 3);
distance_3d = zeros(M, 1);

% 2. Vectorized projection: Find the absolute closest point on the path for every time step
for i = 1:M
    % Compute Euclidean distances from the current drone position to ALL path points
    diffs = path_geometry - actual_positions(i, :);
    sq_distances = sum(diffs.^2, 2);
    
    % Find index of the absolute closest path point (orthogonal projection baseline)
    [~, min_idx] = min(sq_distances);
    
    xy(i, :) = path_geometry(min_idx, :);
    distance_3d(i) = sqrt(sq_distances(min_idx));
end

% 3. Extract components of geometric cross-track deviation
% deviation = Path Coordinate - Actual Coordinate
error_x_spatial = xy(:,1) - actual_positions(:,1);
error_y_spatial = xy(:,2) - actual_positions(:,2);
error_z_spatial = xy(:,3) - actual_positions(:,3);

% 4. Generate the Position Spatial Deviation Timeline Plot
figure(); hold on; grid on;
plot(t, error_x_spatial, 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5); % Blue
plot(t, error_y_spatial, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5); % Orange
plot(t, error_z_spatial, 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1.5); % Yellow
plot(t, distance_3d, ':k', 'LineWidth', 1.2); % Dashed Black for True Spatial Distance

% Reference bounds matching your path requirements
yline(p.posErrorStd*2, '--r', 'LineWidth', 1.0);
yline(-p.posErrorStd*2, '--r', 'LineWidth', 1.0);

xlabel("Time [s]", 'FontSize', 14);
ylabel("Cross-Track Deviation [m]", 'FontSize', 14);
title("Inertial Cross-Track Spatial Deviation vs Time", 'FontSize', 18);

legend("X Spatial Deviation (North)", "Y Spatial Deviation (East)", "Z Spatial Deviation (Up)", ...
       "Total 3D Spatial Distance", "Allowed 2\sigma Bounds (\pm0.10m)", ...
       'Location', 'best');

% 5. Print Descriptive Geometric Summary to Command Window for the Team
fprintf('\n==================================================\n');
fprintf('    LOCALIZATION METRICS: CROSS-TRACK DEVIATION   \n');
fprintf('   (Time-Independent Spatial Orthogonal Analysis) \n');
fprintf('==================================================\n');
fprintf('Max X Cross-Track Error:    %8.4f m\n', max(abs(error_x_spatial)));
fprintf('Max Y Cross-Track Error:    %8.4f m\n', max(abs(error_y_spatial)));
fprintf('Max Z Cross-Track Error:    %8.4f m\n', max(abs(error_z_spatial)));
fprintf('--------------------------------------------------\n');
fprintf('RMS X Cross-Track Error:    %8.4f m\n', rms(error_x_spatial));
fprintf('RMS Y Cross-Track Error:    %8.4f m\n', rms(error_y_spatial));
fprintf('RMS Z Cross-Track Error:    %8.4f m\n', rms(error_z_spatial));
fprintf('Peak Total 3D Path Distance: %8.4f m\n', max(distance_3d));
fprintf('==================================================\n');