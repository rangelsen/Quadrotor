function tau = generate_forces_moments(gamma_motors)

l = evalin('base', 'l');
k_F = evalin('base', 'k_F');
k_T = evalin('base', 'k_T');

F_motors = k_F*gamma_motors;

F_NE = F_motors(1);
F_SE = F_motors(2);
F_SW = F_motors(3);
F_NW = F_motors(4);

T_X = l*(F_NW + F_SW - F_NE - F_SE);
T_Y = l*(F_SE + F_SW - F_NE - F_NW);
T_Z = [k_T -k_T k_T -k_T]*gamma_motors;

T_motors = [T_X;
            T_Y;
            T_Z];
        
tau = [T_motors;
       F_motors];
end

