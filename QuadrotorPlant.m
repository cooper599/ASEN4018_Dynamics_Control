%% Cooper Wark

function var_dot = QuadrotorPlant(t, var, motor_forces, params)
%{
Description:
    Computes the full nonlinear equations of motion for the quadrotor.

Inputs:
    var          - 12x1 aircraft state vector
                   [x y z phi theta psi u v w p q r]'

    motor_forces - 4x1 motor thrust vector
                   [f1 f2 f3 f4]' [N]

    params       - structure containing:
                   g   gravitational acceleration [m/s^2]
                   m   vehicle mass [kg]
                   I   inertia tensor [kg*m^2]
                   d   CG-to-motor distance [m]
                   km  motor moment coefficient [N*m/N]
                   nu  aerodynamic force coefficient
                   mu  aerodynamic moment coefficient

Outputs:
    var_dot      - 12x1 state derivative vector
%}

% Seperate state vector:
x = var(1); y = var(2); z = var(3);

phi = var(4); theta = var(5); psi = var(6);

u = var(7); v = var(8); w = var(9);

p = var(10); q = var(11); r = var(12);

% Separate Params
% Weight
g = params.g; m = params.m;

% Structural
I = params.I; d = params.d; km = params.km;

% Flying
nu = params.nu; mu = params.mu;

% Calculate Gamma Matrix for p,q,r dot
GammaArr = calculateGammas(I);

% Compute and seperate control moments
control_moments = ComputeMomentMatrix(motor_forces, d, km);
Zc = control_moments(1);
Lc = control_moments(2);
Mc = control_moments(3);
Nc = control_moments(4);

% Compute and seperate aerodynamic moments
moments = -mu * norm([p, q, r],2) * [p; q; r];
L = moments(1);
M = moments(2);
N = moments(3);

% Build [x_dot, y_dot, z_dot]:
pos_matrix = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi), cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
              cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
              -sin(theta), sin(phi)*cos(theta), cos(phi)*cos(theta)];

pos_dot = pos_matrix * [u; v; w];

% Build [phi_dot, theta_dot, psi_dot]:
ang_matrix1 = [1, sin(phi)*tan(theta), cos(phi)*tan(theta);
              0, cos(phi), -sin(phi);
              0, sin(phi)*sec(theta), cos(phi)*sec(theta)];

ang_dot = ang_matrix1 * [p; q; r];

% Build [u_dot, v_dot, w_dot]: 
angle_vel_matrix = -cross([p; q; r], [u; v; w]);

grav_matrix = [-sin(theta);
               cos(theta)*sin(phi);
               cos(theta)*cos(phi)];

% Aerodynamic Forces
airspeed = norm([u, v, w],2);
aero_forces_matrix = -nu * airspeed * [u; v; w];

vel_dot = angle_vel_matrix + g * grav_matrix + (1/m) * aero_forces_matrix + (1/m)*[0;0;Zc];

% I(1,1) = Ixx, I(2,2) = Iyy, I(3,3) = Izz
I_ang_rate_matrix = [GammaArr(1)*p*q-GammaArr(2)*q*r;...
                     GammaArr(5)*p*r-GammaArr(6)*(p^2-r^2);...
                     GammaArr(7)*p*q-GammaArr(1)*q*r];

Moment_Matrix = [GammaArr(3)*L+GammaArr(4)*N;...
                M/I(2,2);...
                GammaArr(4)*L+GammaArr(8)*N];

control_moment_matrix = [Lc/I(1,1);...
                         Mc/I(2,2);...
                         Nc/I(3,3)];

ang_rate_dot = I_ang_rate_matrix + Moment_Matrix + control_moment_matrix;

% Put together derivative state vector
var_dot = [pos_dot; ang_dot; vel_dot; ang_rate_dot];
end