function T_theta = angular_velocity_thransformation(theta_wb)

phi = theta_wb(1);
theta = theta_wb(2);

T_theta = [ 1   sin(phi)*tan(theta)     cos(phi)*tan(theta);
            0              cos(phi)                -sin(phi);
            0   sin(phi)/cos(theta)     cos(phi)/cos(theta)];

end