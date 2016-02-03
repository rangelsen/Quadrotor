function r_x = rot_x(phi)

r_x = [ 1           0         0;
        0    cos(phi) -sin(phi);
        0    sin(phi)  cos(phi)];
    
end