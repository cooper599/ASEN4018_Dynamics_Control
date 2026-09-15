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
    
    % Calculate Vertical control
    Zc = params.m * params.g - params.Kpz*(targets.z-z)-params.Kdz*(targets.w-w);

    % Calculate needed angles for speed controls (pitch and roll/x and y speed)
    phi_d = -1/params.g * (params.Kpv*(targets.v-v));
    theta_d = 1/params.g * (params.Kpu*(targets.u-u));

    % Calculate speed control
    Lc = params.Kpphi * (phi_d - phi) - params.Kdphi * p;
    Mc = params.Kptheta * (theta_d - theta) - params.Kdtheta * q;

    % Calculate spin control
    Nc = params.Kppsi * (targets.psi - psi) - params.Kdpsi * r;

    % Consolitdate
    virtual_controls = [Zc;Lc;Mc;Nc];
    motor_forces = ControlAllocation(virtual_controls,params);
end