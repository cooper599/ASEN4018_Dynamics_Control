function var_dot = stateSpacequadrotorEOM(t, var, g, m, I, deltaFc, deltaGc)
%% Extracting variables from state vector
    target_u=0; target_z=0; target_yaw = 0;


    deltax = var(1);
    deltay = var(2);
    deltaz = var(3);
    deltaphi = var(4);
    deltatheta = var(5);
    deltapsi = var(6);
    deltau = var(7);
    deltav = var(8);
    deltaw = var(9);
    deltap = var(10);
    deltaq = var(11);
    deltar = var(12);
    err_speed = target_u - deltau; % Forward speed error
    err_altitude = target_z - deltaz;
    err_yaw = var(13);

    %Inertias
    Ix = I(1,1);
    Iy = I(2,2);
    Iz = I(3,3);

    %Control pertubations
    deltaXc = deltaFc(1);
    deltaYc = deltaFc(2);
    deltaZc = deltaFc(3);
    deltaLc = deltaGc(1);
    deltaMc = deltaGc(2);
    deltaNc = deltaGc(3);

 
 %% Construct monster A matrix
 Aquad = [ zeros(6,6) eye(6)   ;  ...
     
 0 0 0 0 -g 0 0 0 0 0 0 0;

 0 0 0 g 0 0 0 0 0 0 0 0;
 zeros(4,12)
 ];

 %% Construct B matrix
 Bquad = [ zeros(8,4);...
-1/m 0 0 0;
0 1/Ix 0 0;
0 0 1/Iy 0;
0 0 0 1/Iz;
 ];



 %% write control laws for height, speed, and yaw
 
 k1 = 0.01; k2=0.1; k3=0.01;
 commandYaw = 30;
 K = [k2 k1];
 xYaw = [(deltapsi-commandYaw) deltar]';
 uYaw = -K*xYaw + k3*(err_yaw);
 uSpeed = -k1.*deltaq -k2.*deltatheta + -k3.*(0.3-deltau);
 uAlt = -k1.*deltaw -k2.*(-100 - deltaz);

  %% Construct control vector U = [upward thrust Lc Mc Nc]'

 u = [0 0 0 uYaw]';




 %% Linearized Equations!

 % deltaInertialVelocity = [deltau;deltav;deltaw];
 % 
 % deltaEulerAngleRates = [deltap;deltaq;deltar];
 % 
 % deltaBodyAccelerations = g.*[-deltatheta;deltaphi;0] + (1/m).*[deltaXc;deltaYc;deltaZc];
 % 
 % deltaBodyAngleAccelerations = [(1/Ix).*deltaLc;(1/Iy).*deltaMc;(1/Iz).*deltaNc];

 
 %% State space EOM
 var_dotbeforeI = Aquad*var(1:12) + Bquad*u;
 err_yaw = commandYaw-deltapsi;

 var_dot = [var_dotbeforeI; err_yaw];

   


end



