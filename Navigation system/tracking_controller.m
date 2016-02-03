function theta_wb_c = tracking_controller(X, alpha, cross_track_error, d_cross_track_error)

persistent alpha_last

K_p_phi         = evalin('base', 'K_p_phi');
K_d_phi         = evalin('base', 'K_d_phi');
K_p_theta       = evalin('base', 'K_p_theta');
max_velocity    = evalin('base', 'max_velocity');
phi_c_max       = evalin('base', 'phi_c_max');
theta_c_max     = evalin('base', 'theta_c_max');
psi_c_tolerance = evalin('base', 'psi_c_tolerance');

d_x      = X(4);
d_y      = X(5);

theta    = X(8);
psi      = X(9); 

phi_c   = 0;
theta_c = 0;
psi_c   = alpha;

e_theta = theta_c_max - theta;

velocity = norm([d_x d_y]');

if (abs(psi - psi_c) < psi_c_tolerance)
    phi_c   = K_p_phi * cross_track_error + K_d_phi * d_cross_track_error;

    if (velocity > max_velocity)
    	theta_c = 0;
    else
    	theta_c = .1;
    end
end

phi_c   = saturate(phi_c,   phi_c_max);
theta_c = saturate(theta_c, theta_c_max);

alpha_last = alpha;

theta_wb_c = [phi_c theta_c psi_c]';

end