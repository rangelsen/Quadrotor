%{
Developing a relationship between the torques/forces
and the respective motors. This is done by solving
a set of linear equations T = r x F and 
F = sum(k_F*omega_motor_i^2), i = {1, 2, 3, 4}
%}

syms m_F m_T T_1 T_2 T_3 T_4

A1 = [-m_F -m_F m_F m_F];
A2 = [-m_F m_F m_F -m_F];
A3 = [m_T -m_T m_T -m_T];
A4 = [m_F m_F m_F m_F];

A = [A1;
     A2;
     A3;
     A4];

B = [T_1;
     T_2;
     T_3;
     T_4];

X = linsolve(A, B);
