function motor_forces = PD_controller(t, var, targets, params)
%{
    Function inputs current time and statevector, as well as targets for
    position and velocity, and parameters needed for calculations.
    Calculates the necessary "virtual controls" that would theoretically be
    needed to get to desired state, back solves system to find individual
    motor forces needed using moment matrix, checks to see if all motor
    forces are below a physical limit, returns the maximum realistic motor
    forces to be used to calculate that actual controls in EOM function.

    Inputs:
        t - time
        var - 12x1 state vector
        targets - desired positions or velocities (will get from nav)
        params - necessary parameteres like km, d, m, g, etc.
    Outputs:
        motor_forces - 4x1 vector [f1, f2, f3, f4] of motor forces, clamped
        to a realistic maximum value
%}
    % Seperate state vector:
    x = var(1); y = var(2); z = var(3);
    phi = var(4); theta = var(5); psi = var(6);
    u = var(7); v = var(8); w = var(9);
    p = var(10); q = var(11); r = var(12);

    V_body = [u; v; w];

    % 2. Build the standard rotation matrix from Body to Inertial (matching your pos_matrix)
    R = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi), cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
         cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
         -sin(theta),         sin(phi)*cos(theta),                           cos(phi)*cos(theta)];
    
    % 3. Transform body velocities to inertial velocities
    V_inertial = R * V_body;
    x_dot = V_inertial(1);
    y_dot = V_inertial(2);

    % Given x,y,z (from guidance and nav), calculate desired angles to get there (roll/pitch)
    % May have switched signs
    phi_d = 1/params.g * (params.Kpy * (targets.y - y) + params.Kdy * (targets.v - y_dot));
    theta_d = -1/params.g * (params.Kpx * (targets.x - x) + params.Kdx * (targets.u - x_dot));

    % phi_d = 0;
    % theta_d = 0;

    % Calculate Vertical control
    Zc_temp = -(params.m * params.g) + params.Kpz*(targets.z-z) + params.Kdz*(targets.w-w);
    den = cos(phi)*cos(theta);
    Zc = Zc_temp / max(den,0.1); % Adds safetly for div 0 error

    % Calculate speed control
    Lc = params.Kpphi * (phi_d - phi) - params.Kdphi * p;
    Mc = params.Kptheta * (theta_d - theta) - params.Kdtheta * q;

    % Calculate spin control
    Nc = params.Kppsi * (targets.psi - psi) - params.Kdpsi * r;

    % Consolitdate
    virtual_controls = [Zc;Lc;Mc;Nc];
    motor_forces = ControlAllocation(virtual_controls,params);
end