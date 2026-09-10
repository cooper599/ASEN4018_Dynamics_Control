function motor_forces = ControlAllocation(virtual_controls, d, km, max_force)
    %{
        Helper function used by all controller function in order to
        calculate motor forces returned to EOM function, to ensure that all
        motor forces are within the limits.
    %}
    M = [ -1,         -1,         -1,         -1; ...
         -d/sqrt(2), -d/sqrt(2),  d/sqrt(2),  d/sqrt(2); ...
          d/sqrt(2), -d/sqrt(2), -d/sqrt(2),  d/sqrt(2); ...
          km,        -km,         km,        -km];
      
    motor_forces = M \ virtual_controls;
    motor_forces = max(0, min(motor_forces, max_force)); % Saturation check
end
