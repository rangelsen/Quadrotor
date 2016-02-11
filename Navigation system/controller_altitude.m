% Altitude reference PD controller

function gamma_motors_altitude = controller_altitude(X, z_c, gamma_motors_attitude)

K_p_z     = evalin('base', 'K_p_z');
K_d_z     = evalin('base', 'K_d_z');
gamma_min = evalin('base', 'gamma_min');
gamma_max = evalin('base', 'gamma_max');
n_motors  = evalin('base', 'n_motors');

persistent error_z_last

if (isempty(error_z_last))
	error_z_last = 0;
end

z = X(3);

error_z   = z_c - z;
d_error_z = error_z - error_z_last;

gamma_motors_altitude = (K_p_z*error_z + K_d_z*d_error_z) * ones(n_motors, 1);
gamma_motors_altitude = saturate(gamma_motors_altitude, gamma_min, gamma_max - gamma_motors_attitude);

error_z_last = error_z;

end