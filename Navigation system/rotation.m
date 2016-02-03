function R_wb = rotation(theta_wb)

phi = theta_wb(1);
theta = theta_wb(2);
psi = theta_wb(3);

R_x = rot_x(phi);
R_y = rot_y(theta);
R_z = rot_z(psi);

R_wb = R_z*R_y*R_x;
end