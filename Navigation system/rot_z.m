function r_z = rot_z(psi)

r_z = [ cos(psi) -sin(psi)   0;
        sin(psi)  cos(psi)   0;
               0         0   1];

end