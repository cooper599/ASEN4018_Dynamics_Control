function GammaArr = calculateGammas(I)
%{
Inputs:
    I - Inertia Tensor Matrix
    [Ixx, Ixy, Ixz]
    [Iyx, Iyy, Iyz]
    [Izx, Iyz, Izz]
Outputs:
    GammaArr - 9x1 vector of Gamma1, Gamma2, ..., Gamma9 needed for
    calculating pdot, qdot, rdot
%}
% Easier to read basic inertia's
Ixx = I(1,1); Ixy = I(1,2); Ixz = I(1,3);
Iyz = I(2,3); Iyy = I(2,2); Izz = I(3,3);

Gamma0 = Ixx*Izz - Ixz^2;
Gamma1 = (Ixz*(Ixx-Iyy+Izz))/Gamma0;
Gamma2 = (Izz*(Izz-Iyy)+Ixz^2)/Gamma0;
Gamma3 = Izz/Gamma0;
Gamma4 = Ixz/Gamma0;
Gamma5 = (Izz-Ixx)/Iyy;
Gamma6 = Ixz/Iyy;
Gamma7 = (Ixx*(Ixx-Iyy)+Ixz^2)/Gamma0;
Gamma8 = Ixx/Gamma0;

GammaArr = [Gamma1, Gamma2, Gamma3, Gamma4...
            Gamma5, Gamma6, Gamma7, Gamma8];
end