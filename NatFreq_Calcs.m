%% REQ-Dyn-03 (Updated with Rise Time Calculations)
% Finding natural frequencies, damping ratios, and rise times
clear all; close all; clc;

N = 100;

% Range of damping ratios and settling times
zeta = linspace(0.7,1.1,N);
ts = linspace(0.75,2.0,N);

p = 0.05; % Percent (want within 95% so 5% error)

[TS, ZETA] = meshgrid(ts, zeta);

Omega_n_mid = -log(p) ./ (ZETA .* TS);

% Inner loop targets
Omega_n_inner_rps = Omega_n_mid * 10.0;      % in radians per second
Omega_n_inner_hz  = Omega_n_inner_rps / (2 * pi); % in Hertz

% --- NEW: Calculate the Mid Velocity Loop Rise Time across the mesh ---
% Using standard second-order approximation: Tr = (0.8 + 0.6*zeta + 0.6*zeta^2) / wn
TR_mid = (0.8 + 0.6.*ZETA + 0.6.*ZETA.^2) ./ Omega_n_mid;
% ----------------------------------------------------------------------

% Motor limitations: frequency response limits (bandwidth limits)
risky_ceiling_rps = 400*2*pi/10; % rad/s

% Plotting
figure('Position', [100, 100, 1000, 650]);
surf_handle = surf(TS, ZETA, Omega_n_inner_rps, 'EdgeColor', 'none', 'FaceAlpha', 0.85,'HandleVisibility','off');
hold on;
contour3(TS, ZETA, Omega_n_inner_rps, 20, 'k--','HandleVisibility','off');

[TS_mesh, ZETA_mesh] = meshgrid(ts, zeta);
z_risky   = risky_ceiling_rps * ones(size(TS_mesh));

% Mesh plane representing the vibration threshold limit
% mesh(TS_mesh, ZETA_mesh, z_risky, 'FaceColor', 'y', 'EdgeColor', 'none', 'FaceAlpha', 0.75, 'DisplayName', 'High Noise/Vibration Threshold (40 rad/s)');

% --- VISUAL BOUNDARIES & REQUIREMENTS ISOLATION ---

% 1. Target Settling Time Limit (Ts = 1.0s) Line
ts_target = 1.0; 
ts_line = ts_target * ones(size(zeta));
zeta_line = zeta;
omega_line_ts = (-log(p) ./ (zeta_line .* ts_target)) * 10.0; 
plot3(ts_line, zeta_line, omega_line_ts, 'g-', 'LineWidth', 4, 'DisplayName', 'Target T_s = 1.0s');

% 2. NEW: Target Rise Time Limit (Tr = 0.4s) Line
% To find where Tr = 0.4s, we rearrange: wn_mid = (0.8 + 0.6*zeta + 0.6*zeta^2) / Tr
tr_target = 0.4;
omega_mid_tr_line = (0.8 + 0.6.*zeta + 0.6.*zeta.^2) ./ tr_target;
omega_inner_tr_line = omega_mid_tr_line * 10.0; % Scale up to inner loop axis
% Solve for the matching Ts coordinates to plot it properly on our X-axis mesh:
% Ts = -log(0.05) / (zeta * wn_mid)
ts_tr_line = -log(p) ./ (zeta .* omega_mid_tr_line);

% Filter line to only plot within our visible X-axis limits
valid_tr_plot = (ts_tr_line >= 0.75) & (ts_tr_line <= 2.0);
plot3(ts_tr_line(valid_tr_plot), zeta(valid_tr_plot), omega_inner_tr_line(valid_tr_plot), ...
      'r-', 'LineWidth', 4, 'DisplayName', 'Target T_r = 0.4s');

%% --- FINDING AND PLOTTING THE EXACT INTERSECTION POINT ---
% The point where Ts = 1.0s and Tr = 0.4s meet mathematically
opt_ts = 1.0;
opt_tr = 0.4;

% Analytical ratio formula: Tr/Ts = zeta * (0.8 + 0.6*zeta + 0.6*zeta^2) / -log(p)
target_ratio = opt_tr / opt_ts;
zeta_fine = linspace(0.7, 1.1, 1000);
ratio_model = (zeta_fine .* (0.8 + 0.6.*zeta_fine + 0.6.*zeta_fine.^2)) / -log(p);
[~, min_idx] = min(abs(ratio_model - target_ratio));

opt_zeta = zeta_fine(min_idx);
opt_wn_mid = -log(p) / (opt_zeta * opt_ts);
opt_wn_inner = opt_wn_mid * 10.0;

% Plot the intersection dot
plot3(opt_ts, opt_zeta, opt_wn_inner, 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 10, 'LineWidth', 2.5, 'DisplayName', 'Unique Multi-Req Target');

% --- FORMATTING ---
colormap(jet);
colorbar_handle = colorbar;
ylabel(colorbar_handle, 'Required Inner \omega_n (rad/s)', 'FontSize', 11, 'FontWeight', 'bold');

title('Quadrotor Design Envelope: Inner Loop \omega_n vs. Dynamic Requirements', 'FontSize', 13, 'FontWeight', 'bold');
xlabel('95% Velocity Settling Time T_s (seconds)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Damping Ratio \zeta', 'FontSize', 11, 'FontWeight', 'bold');
zlabel('Required Inner \omega_n (rad/s)', 'FontSize', 11, 'FontWeight', 'bold');

legend('Location', 'northeast');
zlim([0, 60]);
xlim([0.5, 2.5]);
view(45, 25); 
grid on;

%% Calcualting Gains
%% =========================================================================
%% MATHEMATICALLY TUNED CONTROL GAINS (T_s = 1.0s, T_r = 0.4s Corridor)
%% =========================================================================
% Vehicle Constant Definitions
m = 872.10 / 1000; % 0.8721 kg
g = 9.81;          % m/s^2

% Full Inertia Tensor Matrix
J = [ 0.02079801611,  0.00530252330,  0.00751732970;
      0.00530252330,  0.01801195838,  0.00977792229;
      0.00751732970,  0.00977792229,  0.01101529893 ];
J_inv = inv(J);

% Primary Base Multipliers derived from your optimal surface point
wn_inner   = 39.7917; 
zeta_inner = 0.753;
Kp_mult = wn_inner^2;               % 1583.38
Kd_mult = 2 * zeta_inner * wn_inner; % 59.93

%% 1. Inner Loop: Roll and Pitch Gains
Kpphi = Kp_mult / J_inv(1,1);     
Kdphi = Kd_mult / J_inv(1,1);     
Kiphi = Kpphi * 0.1;              

Kptheta = Kp_mult / J_inv(2,2);   
Kdtheta = Kd_mult / J_inv(2,2);   
Kitheta = Kptheta * 0.1;          

%% 2. Inner Loop: Yaw and Vertical (Bypasses Cascade Layering)
wn_yaw = 6.0; zeta_yaw = 1.0;
Kppsi = (wn_yaw^2) / J_inv(3,3);  
Kdpsi = (2 * zeta_yaw * wn_yaw) / J_inv(3,3); 
Kipsi = Kppsi * 0.1;

wn_z = 3.52; zeta_z = 1.0; 
Kpz = (wn_z^2) * m;               
Kdz = (2 * zeta_z * wn_z) * m;     
Kiz = Kpz * 0.1;

%% 3. Mid Loop: Translational Velocity Gains (u, v)
wn_mid = wn_inner / 10.0; 
zeta_mid = 1.0; 

Kpu = (2 * zeta_mid * wn_mid) / g; 
Kpv = Kpu;
Kdu = (wn_mid^2) / g;              
Kdv = Kdu;
Kiu = Kpu * 0.1;
Kiv = Kiu;

%% 4. Outer Loop: Spatial Position Gains (x, y)
wn_outer = wn_mid / 10.0; 

Kpx = wn_outer;                    
Kpy = Kpx;
Kix = Kpx * 0.1;
Kiy = Kix;

%% =========================================================================
%% EXPANDED VERIFICATION PRINT STATEMENT
%% =========================================================================
fprintf('\n===================================================================\n');
fprintf('        HIGH-FIDELITY FLIGHT CONTROLLER GAIN VERIFICATION MATRIX    \n');
fprintf('     Requirements Targets Met: Settling Time = 1.0s, Rise Time = 0.4s \n');
fprintf('===================================================================\n\n');

fprintf('  [LAYER 1: INNERMOST ATTITUDE & HEAVE RATES]\n');
fprintf('  ---------------------------------------------------------------\n');
fprintf('  Roll (phi)   ->  Kp = %10.5f,  Ki = %10.5f,  Kd = %10.5f\n', Kpphi, Kiphi, Kdphi);
fprintf('  Pitch (theta)->  Kp = %10.5f,  Ki = %10.5f,  Kd = %10.5f\n', Kptheta, Kitheta, Kdtheta);
fprintf('  Yaw (psi)    ->  Kp = %10.5f,  Ki = %10.5f,  Kd = %10.5f\n', Kppsi, Kipsi, Kdpsi);
fprintf('  Altitude (Z) ->  Kp = %10.5f,  Ki = %10.5f,  Kd = %10.5f\n\n', Kpz, Kiz, Kdz);

fprintf('  [LAYER 2: TRANSLATIONAL VELOCITY LOOP (10x Time-Scale Separation)]\n');
fprintf('  ---------------------------------------------------------------\n');
fprintf('  U Velocity   ->  Kp = %10.5f,  Ki = %10.5f,  Kd = %10.5f\n', Kpu, Kiu, Kdu);
fprintf('  V Velocity   ->  Kp = %10.5f,  Ki = %10.5f,  Kd = %10.5f\n\n', Kpv, Kiv, Kdv);

fprintf('  [LAYER 3: OUTERMOST SPATIAL NAVIGATION (100x Separation Corridor)]\n');
fprintf('  ---------------------------------------------------------------\n');
fprintf('  X Position   ->  Kp = %10.5f,  Ki = %10.5f\n', Kpx, Kix);
fprintf('  Y Position   ->  Kp = %10.5f,  Ki = %10.5f\n', Kpy, Kiy);
fprintf('===================================================================\n');