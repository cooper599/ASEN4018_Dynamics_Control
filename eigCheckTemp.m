%% Quadrotor 16x16 Closed-Loop Eigenvalue Calculator
clear all; close all; clc;

%% 1. Physical Drone Parameters
g  = 9.81; % m/s^2
m = 872.10/1000;

J = [ 0.02079801611,  0.00530252330,  0.00751732970;
      0.00530252330,  0.01801195838,  0.00977792229;
      0.00751732970,  0.00977792229,  0.01101529893 ];

Ix = J(1,1);
Iy = J(2,2);
Iz = J(3,3);

Jinv = inv(J);

%% 2. Exact User-Defined Open-Loop Matrices
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

%% 3. Control Gains
% Vertical Gains
Kpz = 10.80567;
Kiz = 1.08057;
Kdz = 6.13958; % W

% Attitude Inner-Loop Gains
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

% Midloop gains
Kpu = 0.81125;
Kpv = 0.81125;

% Outerloop gains
Kpx = 0.39792;
Kpy = 0.39792;
%% 4. Build State Feedback Gain Matrix (K_state: 4x12)
% Modeled for u = -K_state * x
K_state = zeros(4,12);

% Input 1: Vertical Thrust Control (Z_c)
K_state(1,3) = Kpz;  % z
K_state(1,9) = Kdz;  % z_dot

% Input 2: Roll Control (L_c) -> Cascaded with Outer Loop Y
% phi_cmd = -Kpy*y - Kpv*y_dot
K_state(2,2) = Kpphi * Kpy;  % y
K_state(2,8) = Kpphi * Kpv;  % y_dot
K_state(2,4) = Kpphi;        % phi
K_state(2,10) = Kdphi;       % p

% Input 3: Pitch Control (M_c) -> Cascaded with Outer Loop X
% theta_cmd = Kpx*x + Kpu*x_dot
K_state(3,1) = -Kptheta * Kpx; % x
K_state(3,7) = -Kptheta * Kpu; % x_dot
K_state(3,5) = Kptheta;        % theta
K_state(3,11) = Kdtheta;       % q

% Input 4: Yaw Control (N_c)
K_state(4,6)  = Kppsi; % psi
K_state(4,12) = Kdpsi; % r

%% 5. Build Integral Gain Matrix (K_integral: 4x4)
K_integral = diag([Kiz, Kiphi, Kitheta, Kipsi]);

%% 6. Build Integrator Dynamics Matrix (C_int: 4x12)
C_int = zeros(4,12);
C_int(1,3) = 1.0;  % e_z_dot = z

% e_phi_dot = phi - phi_cmd = phi + Kpy*y + Kpv*y_dot
C_int(2,2) = Kpy; C_int(2,8) = Kpv; C_int(2,4) = 1.0; 

% e_theta_dot = theta - theta_cmd = theta - Kpx*x - Kpu*x_dot
C_int(3,1) = -Kpx; C_int(3,7) = -Kpu; C_int(3,5) = 1.0; 

C_int(4,6) = 1.0;  % e_psi_dot = psi

%% 7. Assemble 16x16 Closed-Loop System Matrix (A_cl)
TopLeft     = A - B * K_state;
TopRight    = -B * K_integral;
BottomLeft  = C_int;
BottomRight = zeros(4,4);

A_cl = [TopLeft,    TopRight; ...
        BottomLeft, BottomRight];

%% 8. Calculate and Analyze Eigenvalues
tuned_eigenvalues = eig(A_cl);

% Output Results to Command Window
fprintf('\n=======================================\n');
fprintf('     16x16 Tuned Closed-Loop Eigenvalues  \n');
fprintf('=======================================\n');
for i = 1:length(tuned_eigenvalues)
    fprintf('  lambda(%2d) = %10.4f + %10.4fi\n', i, real(tuned_eigenvalues(i)), imag(tuned_eigenvalues(i)));
end

% Stability Assertion
if all(real(tuned_eigenvalues) < 0)
    fprintf('\nSTATUS: SYSTEM IS STABLE! (All real parts < 0)\n');
else
    fprintf('\nWARNING: SYSTEM IS UNSTABLE! (Check positive real parts)\n');
end

%% 9. Plot Eigenvalues on the Complex Plane
figure('Position', [100, 100, 800, 600]);

% Plot the stable region boundary (Imaginary axis line)
xline(0, 'k-', 'LineWidth', 2, 'HandleVisibility', 'off'); 
hold on;
yline(0, 'k-', 'LineWidth', 1, 'HandleVisibility', 'off');

% Shaded green patch for the stable Left-Half Plane (LHP)
xl = xlim; yl = ylim;
patch([-50 0 0 -50], [-50 -50 50 50], [0.9 0.98 0.9], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.5, 'DisplayName', 'Stable Region (LHP)');

% Plot the actual closed-loop eigenvalues
plot(real(tuned_eigenvalues), imag(tuned_eigenvalues), 'ro', ...
    'MarkerSize', 10, 'LineWidth', 2, 'MarkerFaceColor', 'r', 'DisplayName', 'Closed-Loop Poles');

% Visual tuning and labels
grid on;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

title('Quadrotor Closed-Loop Eigenvalues on the Complex Plane', 'FontSize', 13, 'FontWeight', 'bold');
xlabel('Real Axis (\sigma)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Imaginary Axis (i\omega)', 'FontSize', 11, 'FontWeight', 'bold');

% Auto-scale axes gracefully around data points with some breathing room
padding_x = max(abs(real(tuned_eigenvalues))) * 0.2 + 1;
padding_y = max(abs(imag(tuned_eigenvalues))) * 0.2 + 1;
xlim([min(real(tuned_eigenvalues)) - padding_x, max(real(tuned_eigenvalues)) + padding_x]);
ylim([min(imag(tuned_eigenvalues)) - padding_y, max(imag(tuned_eigenvalues)) + padding_y]);

legend('show', 'Location', 'best');