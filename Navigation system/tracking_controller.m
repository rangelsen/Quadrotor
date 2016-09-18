function theta_wb_c = tracking_controller(X, alpha, cross_track_error, d_cross_track_error, constants)

d_x      = X(4);
d_y      = X(5);

theta    = X(8);
psi      = X(9); 

phi_c   = 0;
theta_c = 0;
psi_c   = alpha;

velocity = norm([d_x d_y]');

if (abs(psi - psi_c) < constants.psi_c_tolerance)
    phi_c   = constants.K_p_phi * cross_track_error + constants.K_d_phi * d_cross_track_error;

    if (velocity > constants.max_velocity)
    	theta_c = 0;
    else
    	theta_c = .1;
    end
end

phi_c   = saturate(phi_c, -constants.phi_c_max, constants.phi_c_max);
theta_c = saturate(theta_c, -constants.theta_c_max, constants.theta_c_max);

alpha_last = alpha;

theta_wb_c = [phi_c theta_c psi_c]';

end