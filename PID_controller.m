function [motor_forces, phi_d, theta_d] = PID_controller(t, var, error_sum, targets, params)
%{
    PID Controller extracting accumulated errors from the expanded 18x1 state vector.
    
    Inputs:
        var - 18x1 state vector (1:12 physical, 13:18 integrated errors)
        phi_d_prev, theta_d_prev - The desired angles from the LAST time step 
                                   used to calculate the current angle errors.
%}
    % 1. Extract physical states (1 to 12)
    x = var(1); y = var(2); z = var(3);
    phi = var(4); theta = var(5); psi = var(6);
    u = var(7); v = var(8); w = var(9);
    p = var(10); q = var(11); r = var(12);

    % 2. Extract integrated errors from state vector (13 to 18)
    error_sum_x     = error_sum(1);
    error_sum_y     = error_sum(2);
    error_sum_z     = error_sum(3);
    error_sum_phi   = error_sum(4);
    error_sum_theta = error_sum(5);
    error_sum_psi   = error_sum(6);

    % 3. Transform body velocities to inertial velocities
    V_body = [u; v; w];
    R = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi), cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
         cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
         -sin(theta),         sin(phi)*cos(theta),                           cos(phi)*cos(theta)];
    
    V_inertial = R * V_body;
    x_dot = V_inertial(1);
    y_dot = V_inertial(2);

    % 4. Outer Loop: Translational Control (Uses x/y state integrals)
    phi_d   =  1/params.g * (params.Kpy * (targets.y - y) + params.Kiy * error_sum_y + params.Kdy * (targets.v - y_dot));
    theta_d = -1/params.g * (params.Kpx * (targets.x - x) + params.Kix * error_sum_x + params.Kdx * (targets.u - x_dot));

    % 5. Compute Virtual Controls (PID Equations)
    % Vertical Control (Zc)
    Zc_temp = -(params.m * params.g) + params.Kpz*(targets.z-z) + params.Kiz*error_sum_z + params.Kdz*(targets.w-w);
    den = cos(phi)*cos(theta);
    Zc = Zc_temp / max(den,0.1); 

    % Attitude Controls (Lc, Mc, Nc)
    Lc = params.Kpphi * (phi_d - phi)     + params.Kiphi * error_sum_phi   - params.Kdphi * p;
    Mc = params.Kptheta * (theta_d - theta) + params.Kitheta * error_sum_theta - params.Kdtheta * q;
    Nc = params.Kppsi * (targets.psi - psi) + params.Kipsi * error_sum_psi   - params.Kdpsi * r;

    % 6. Control Allocation
    virtual_controls = [Zc; Lc; Mc; Nc];
    motor_forces = ControlAllocation(virtual_controls, params);
end