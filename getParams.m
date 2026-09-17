function params = getParams()
    %{
    Function initializes all parameters needed throughout code from
    constants to control gains used in control law functions
    %}
    % Constants
    params.m = 0.068; % [kg]
    params.d = 0.060; % [m]
    params.km = 0.0024; % [N*m/(N))]
    params.Ix = 5.8e-5; % [kg*m^2]
    params.Iy = 7.2e-5; % [kg*m^2]
    params.Iz = 1.0e-4; % [kg*m^2]
    params.I = [params.Ix 0 0;0 params.Iy 0;0 0 params.Iz];
    params.nu = 1e-3; % [N/(m/s)^2]
    params.mu = 2e-6; % [N*m/(rad/s)^2]
    params.g = 9.81; % [m/s^2]

    params.max_motor_force = params.m * params.g * 100;

    %% PD Control gains, guessing for now will need to change

    % Temporary position/outer loop gains (keep small for now)
    params.Kpx = 0.1; params.Kdx = 0.05;
    params.Kpy = 0.1; params.Kdy = 0.05;
    params.Kpz = 1.5; params.Kdz = 0.1; % Needs to be stronger to fight gravity
    
    % Inner loop attitude gains (Must be much faster/larger)
    params.Kpphi = 0.5;   params.Kdphi = 0.005;
    params.Kptheta = 0.5; params.Kdtheta = 0.005;
    params.Kppsi = 2;   params.Kdpsi = 0.01;
end