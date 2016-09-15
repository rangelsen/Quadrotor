% Altitude reference PD controller

function gamma_motors_altitude = controller_altitude(X, z_c, constants)

persistent error_accumulated

if (isempty(error_accumulated))
	error_accumulated = 0;
end

z   = X(3);
d_z = X(6);

error_z   = z_c - z;

gamma_motors_altitude = constants.K_p_z * error_z; % + constants.K_d_z*d_z + constants.K_i_z * error_accumulated) * ones(constants.n_motors, 1);

error_accumulated = error_accumulated + error_z;

end