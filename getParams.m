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
    params.I = [Ix 0 0;0 Iy 0;0 0 Iz];
    params.nu = 1e-3; % [N/(m/s)^2]
    params.mu = 2e-6; % [N*m/(rad/s)^2]
    params.g = 9.81; % [m/s^2]

    %% PD Control gains, guessing for now will need to change
    % z
    params.Kpz = 0.5;
    params.Kdz = 0.25;

    % speed
    params.Kpv = 0.5;
    params.Kpu = 0.5;

    % speed control
    params.Kpphi = 0.5;
    params.Kdphi = 0.25;

    params.Kptheta = 0.5;
    params.Kdtheta = 0.25;

    % spin
    params.Kppsi = 0.5;
    params.Kdpsi = 0.25;
end