function params = getParams()
    %{
    Function initializes all parameters needed throughout code from
    constants to control gains used in control law functions
    %}
    % Constants
    params.m = 5.6; % [kg]
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

    %% PD Control gains, guessing for now will need to changes
    % --- Outer Loop: X Position Control ---
    % Outer loops command target angles (radians), so they stay relatively small
    params.Kpx = 1.5;   
    params.Kdx = 3.0;  
    params.Kix = 0.5; 
    
    % --- Outer Loop: Y Position Control ---
    params.Kpy = 1.5;   
    params.Kdy = 3.0;  
    params.Kiy = 1.0; 
    
    % --- Outer Loop: Z Altitude Control (Scaled linearly up for 5.6 kg) ---
    params.Kpz = 1.0;  
    params.Kdz = 2.0;   
    params.Kiz = 0.25;    
    
    % --- Inner Loop: Phi (Roll) Attitude Control ---
    params.Kpphi   = 0.5;   
    params.Kdphi   = 0.015; 
    params.Kiphi   = 0.002; 
    
    % --- Inner Loop: Theta (Pitch) Attitude Control ---
    params.Kptheta = 0.5;   
    params.Kdtheta = 0.015; 
    params.Kitheta = 0.002; 
    
    % --- Inner Loop: Psi (Yaw) Spin Control ---
    params.Kppsi   = 2;   
    params.Kdpsi   = 0.1;   
    params.Kipsi   = 0.1; 
    
    % --- Anti-Windup Limits (Clamping values for the 13:18 state vector errors) ---
    % Position caps remain physically meaningful in meters*seconds
    params.max_int_x     = 0.5;   
    params.max_int_y     = 0.5;   
    params.max_int_z     = 1.0;   % Give the 5.6kg drone headroom to trim its throttle
    params.max_int_phi   = 0.05;  
    params.max_int_theta = 0.05;  
    params.max_int_psi   = 0.1;   

end