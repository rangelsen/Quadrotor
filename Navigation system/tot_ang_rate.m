function omega_wb = tot_ang_rate(d_theta_wb, R_x, R_y)

omega_wb = d_theta_wb(1) + R_x'*d_theta_wb(2) + R_x'*R_y'*d_theta_wb(3);

end