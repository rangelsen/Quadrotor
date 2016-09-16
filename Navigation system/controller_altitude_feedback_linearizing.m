function gamma_motors = controller_altitude_feedback_linearizing(X, z_c, constants)

persistent error_accumulated;

if(isempty(error_accumulated))
    error_accumulated = 0;
end

z = X(3);
d_z = X(6);

phi   = X(7);
theta = X(8);

error_z = z_c - z;

desired_accel_z = constants.K_p_z * error_z - constants.K_d_z * d_z + constants.K_i_z * error_accumulated;

% f_z = compute_vertical_air_resistance(X);

F = cos(theta) * cos(phi) * (constants.m * desired_accel_z + constants.m * constants.g); % + f_z);

error_accumulated = error_accumulated + error_z;
gamma = F/constants.k_F;
gamma_motors = gamma * ones(constants.n_motors, 1);
end