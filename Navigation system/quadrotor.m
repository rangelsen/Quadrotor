function dx = quadrotor(x, u, constants)
%% Extract states
d_r = x(4:6);
theta_wb = x(7:9);
omega_wb = x(10:12);

%% Process
tau = generate_forces_moments(u, constants);

T_motor = tau(1:3);                                                         % Generate moment vector about quad's center mass
F_motor = tau(4:6);

d_theta_wb = angular_velocity_transformation(theta_wb)*omega_wb;

d_omega_wb = process_rotation(omega_wb, T_motor, constants);                % Compute rotational process

dd_r       = process_position(theta_wb, F_motor, constants);

%% Return
dx =  [        d_r;
              dd_r;
        d_theta_wb;
        d_omega_wb];

end