%% Driver file for testing EOM and control laws
clear all; clc; close all;

tic
% Call params
params = getParams();

%% Setup ode45 call
% Options for numerical stabilty
opt = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);

% Time span and initial conditions
tspan = [0 10];

% Steady hover at (0,0,2) in normal coord system
ang_pert = deg2rad(5); % 5 degree angle perturbation
init_cond = [0; 0; -2;...
             ang_pert/2; ang_pert; 0;...
             0; 0; 0;...
             0; 0; 0];

% Targets throughout, currently testing hover
% z, u, v, w, psi. Can add more assuming nav will give us either target
% velocity, position, or attitude
% Maintain initial pos
targets.x = 0;
targets.y = 0;
targets.z = -2;

targets.u = 0; % No velocity
targets.v = 0;
targets.w = 0;
targets.psi = 0; % No yaw

% Call test scenario
[t, var_dot] = ode45(@(t,x) QuadrotorEOM(t, x, targets, params, @PD_controller), tspan, init_cond, opt);

% Post processing to regain control forces and motor forces
num_steps = length(t);
Zc_hist = zeros(num_steps, 1);
Lc_hist = zeros(num_steps, 1);
Mc_hist = zeros(num_steps, 1);
Nc_hist = zeros(num_steps, 1);
motor_forces_hist = zeros(num_steps, 4);

for i = 1:num_steps
    % Extract the 12x1 state vector at time step i
    current_state = var_dot(i, :)'; 
    current_t = t(i);
    
    % Call your controller exactly how it runs inside the EOM
    forces = PD_controller(current_t, current_state, targets, params);
    motor_forces_hist(i, :) = forces';
    
    % Reconstruct the moments using your Forward Mixer Matrix
    control_moments = ComputeMomentMatrix(forces, params.d, params.km);
    
    % Save them to your history arrays
    Zc_hist(i) = control_moments(1);
    Lc_hist(i) = control_moments(2);
    Mc_hist(i) = control_moments(3);
    Nc_hist(i) = control_moments(4);
end
% Consolidating
control_input_array = [Zc_hist, Lc_hist, Mc_hist, Nc_hist];

plot_tol = 6; % round to 8 decimals
% Plotting
PlotAircraftSim(t,round(var_dot,plot_tol),round(control_input_array,plot_tol),[1,2,3,4,5,6],'g-',0,'',"Test Hover")
toc