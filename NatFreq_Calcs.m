%% REQ-Dyn-03
% Finding natural frequencies and damping ratios
clear all; close all; clc;

N = 100;

% Range of damping ratios and settling times
zeta = linspace(0.7,1.1,N);
ts = linspace(1.0,2.0,N);

p = 0.05; % Percent (want within 95% so 5% error)

[TS, ZETA] = meshgrid(ts, zeta);

Omega_n_mid = -log(p) ./ (ZETA .* TS);

% Inner loop targets
Omega_n_inner_rps = Omega_n_mid * 10.0;      % in radians per second
Omega_n_inner_hz  = Omega_n_inner_rps / (2 * pi); % in Hertz

% Motor limitations: frequency response limits (bandwidth limits)
% Need to modify once know rough propellor size and motor update rate
motor_ceiling_rps = 62.8;  % 10 Hz
risky_ceiling_rps = 31.4;  % 5 Hz boundary (high vibrations)

% Plotting
figure('Position', [100, 100, 900, 600]);
surf_handle = surf(TS, ZETA, Omega_n_inner_rps, 'EdgeColor', 'none', 'FaceAlpha', 0.85);
hold on;
contour3(TS, ZETA, Omega_n_inner_rps, 20, 'k--');

[TS_mesh, ZETA_mesh] = meshgrid(ts, zeta);
z_ceiling = motor_ceiling_rps * ones(size(TS_mesh));
z_risky   = risky_ceiling_rps * ones(size(TS_mesh));

mesh(TS_mesh, ZETA_mesh, z_ceiling, 'FaceColor', 'r', 'EdgeColor', 'none', 'FaceAlpha', 0.75, 'DisplayName', 'Absolute Motor Limit (~20 Hz)');
mesh(TS_mesh, ZETA_mesh, z_risky, 'FaceColor', 'y', 'EdgeColor', 'none', 'FaceAlpha', 0.75, 'DisplayName', 'High Noise/Vibration Threshold (~10 Hz)');

colormap(jet);
colorbar_handle = colorbar;
ylabel(colorbar_handle, 'Required Inner \omega_n (rad/s)', 'FontSize', 11, 'FontWeight', 'bold');

title('Quadrotor Design Envelope: Inner Loop \omega_n vs. Requirements', 'FontSize', 13, 'FontWeight', 'bold');
xlabel('95% Velocity Settling Time T_s (seconds)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Damping Ratio \zeta', 'FontSize', 11, 'FontWeight', 'bold');
zlabel('Required Inner \omega_n (rad/s)', 'FontSize', 11, 'FontWeight', 'bold');

zlim([0, 70]);
xlim([0.5, 2.5]);
view(45, 25); % Set a clean 3D perspective angle
grid on;
