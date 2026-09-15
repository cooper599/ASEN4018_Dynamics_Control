function motor_forces = ControlAllocation(virtual_controls, params)
    %{
        Helper function used by all controller function in order to
        calculate motor forces returned to EOM function, to ensure that all
        motor forces are within the limits.
    Params should include: d, km, max_force
    %}
    M = [ -1,         -1,         -1,         -1; ...
         -params.d/sqrt(2), -params.d/sqrt(2),  params.d/sqrt(2),  params.d/sqrt(2); ...
          params.d/sqrt(2), -params.d/sqrt(2), -params.d/sqrt(2),  params.d/sqrt(2); ...
          params.km,        -params.km,         params.km,        -params.km];
      
    motor_forces = M \ virtual_controls;
    % Make sure actual motor force is limited to physical model
    motor_forces = max(0, min(motor_forces, params.max_force)); % Saturation check
end
