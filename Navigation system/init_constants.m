%% generate_moment
l = .15;
k_F = .04;
k_T = .05;

%% process_rotation
I = 4*eye(3);

m = 2;
g = 9.81;

%% controller_attitude
K_p = 300;
K_d = 120;
K_p_yaw = K_p;
K_d_yaw = K_d;
thr_base = 2*9.81/(4*k_F) + 100;
gamma_max = 5000;
gamma_min = 0;

%% Controller position

K_p_phi = .02;
K_d_phi = 10;
K_p_theta = .1;

phi_c_max = deg2rad(30);
theta_c_max = 10;

psi_c_tolerance = pi/12;

approach_distance = 2;						% Distance away from waypoint where the 
										    % position hold controller takes over

K_p_pos = .04;								% Gains for position hold controller
K_d_pos = 20;

max_velocity = 2;							% Max speed in tracking mode
