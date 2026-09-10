function control_moment_matrix = ComputeMomentMatrix(motor_forces, d, km)
%{
% Description: Compute the control moment outputs from the motor forces.
% Inputs: 
%   motor_forces: 4x1 vector of forces due to 4 motors [N] 
%   d: distance between center of mass and propeller [m]
%   km: control moment coefficient [(N*m)/N]

% Outputs: 
%    
%}

moment_matrix = [ -1, -1, -1, -1;
                  -d/sqrt(2), -d/sqrt(2), d/sqrt(2), d/sqrt(2);
                   d/sqrt(2), -d/sqrt(2), -d/sqrt(2), d/sqrt(2);
                   km, -km, km, -km];

control_moment_matrix = moment_matrix * motor_forces;
end