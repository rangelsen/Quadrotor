function tau = generate_forces_moments(gamma_motors, constants)

F_motors = constants.k_F*gamma_motors;

F_NE = F_motors(1);
F_SE = F_motors(2);
F_SW = F_motors(3);
F_NW = F_motors(4);

T_X = constants.l*(F_NW + F_SW - F_NE - F_SE);
T_Y = constants.l*(F_SE + F_SW - F_NE - F_NW);
T_Z = constants.k_T*[1 -1 1 -1]*gamma_motors;

T_motors = [T_X;
            T_Y;
            T_Z];
        
tau = [T_motors;
       F_motors];
end

