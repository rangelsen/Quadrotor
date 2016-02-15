function theta_wb_c = controller_position_hold(X, psi_c, position_c, constants)

persistent delta_position_rotated_last

position = [X(1); X(2)];

psi = X(9);

R = [cos(psi) -sin(psi);
	 sin(psi)  cos(psi)];

delta_position = position_c - position;

delta_position_rotated = R' * delta_position;

if (isempty(delta_position_rotated_last))
	delta_position_rotated_last = delta_position_rotated;
end

d_delta_position_rotated = delta_position_rotated - delta_position_rotated_last;

phi_c   = 0;
theta_c = 0;

if (abs(psi - psi_c) < constants.psi_c_tolerance)
	phi_c   = -(constants.K_p_pos * delta_position_rotated(2) + constants.K_d_pos * d_delta_position_rotated(2));
	theta_c =   constants.K_p_pos * delta_position_rotated(1) + constants.K_d_pos * d_delta_position_rotated(1);
end

phi_c   = saturate(phi_c,   -deg2rad(70), deg2rad(70));
theta_c = saturate(theta_c, -deg2rad(70), deg2rad(70));

delta_position_rotated_last = delta_position_rotated;

theta_wb_c = [phi_c theta_c psi_c]';

end