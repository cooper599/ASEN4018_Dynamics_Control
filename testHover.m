%% Kevin Jenkins

clear;
clc;
close all;

% Vehicle parameters
params = getParams();

% TEMPORARY saturation limit
% Replace with actual motor thrust limit later
params.max_force = 1.0;   % [N]

% Desired hover state
targets.z   = 0;     % [m]
targets.u   = 0;     % [m/s]
targets.v   = 0;     % [m/s]
targets.w   = 0;     % [m/s]
targets.psi = 0;     % [rad]

% Initial aircraft state
% [x y z phi theta psi u v w p q r]'

var0 = zeros(12,1);

% Give the aircraft a small initial disturbance
% so we can actually see the controller respond
var0(3) = 0.25;              % z displacement [m]
%var0(4) = deg2rad(5);        % roll disturbance [rad]
%var0(5) = deg2rad(-5);       % pitch disturbance [rad]

% Simulation time
tspan = [0 10];              % [s]

% Run simulation
[t, var] = ode45(@(t,var) closedLoopEOM(t,var,targets,params), ...
                 tspan, var0);

% Recalculate motor forces for plotting
motor_forces = zeros(length(t),4);

for i = 1:length(t)

    motor_forces(i,:) = ...
        PD_controller(t(i),var(i,:)',targets,params)';

end

% Plot Position
figure;

plot(t,var(:,1),'LineWidth',1.5);
hold on;
plot(t,var(:,2),'LineWidth',1.5);
plot(t,var(:,3),'LineWidth',1.5);

xlabel('Time [s]');
ylabel('Position [m]');
title('Quadrotor Position');
legend('x','y','z');
grid on;

% Plot Velocity
figure;

plot(t,var(:,7),'LineWidth',1.5);
hold on;
plot(t,var(:,8),'LineWidth',1.5);
plot(t,var(:,9),'LineWidth',1.5);

xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Quadrotor Body Velocity');
legend('u','v','w');
grid on;

% Plot Attitude
figure;

plot(t,rad2deg(var(:,4)),'LineWidth',1.5);
hold on;
plot(t,rad2deg(var(:,5)),'LineWidth',1.5);
plot(t,rad2deg(var(:,6)),'LineWidth',1.5);

xlabel('Time [s]');
ylabel('Angle [deg]');
title('Quadrotor Attitude');
legend('\phi','\theta','\psi');
grid on;

% Plot Motor Forces
figure;

plot(t,motor_forces(:,1),'LineWidth',1.5);
hold on;
plot(t,motor_forces(:,2),'LineWidth',1.5);
plot(t,motor_forces(:,3),'LineWidth',1.5);
plot(t,motor_forces(:,4),'LineWidth',1.5);

yline(params.m*params.g/4,'--','Hover Thrust');

xlabel('Time [s]');
ylabel('Motor Force [N]');
title('Motor Forces');
legend('Motor 1','Motor 2','Motor 3','Motor 4','Hover Thrust');
grid on;

% Expected hover thrust
expected_thrust = params.m*params.g/4;

fprintf('Expected hover thrust per motor: %.6f N\n', ...
        expected_thrust);

function var_dot = closedLoopEOM(t,var,targets,params)

    % Controller determines required motor forces
    motor_forces = PD_controller(t,var,targets,params);

    % Motor forces are sent to nonlinear plant
    var_dot = QuadrotorPlant(t,var,motor_forces,params);

end