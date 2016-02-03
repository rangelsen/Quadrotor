clear all; clc;  
%% Options

%% Initialize system constants
run('init_constants.m');

%% Initial Conditions
r_0     = [10 0 0]';
d_r_0   = [ 0 0 0]';
theta_0 = [ 0 0 0]';
omega_0 = [ 0 0 0]';

x_0 = [    r_0;
         d_r_0;
       theta_0;
       omega_0];
   
[mx0, nx0] = size(x_0);  
[mt0, nt0] = size(theta_0);

%% Simulation

sim_time = 125;
dt = .005;
T  = 0:dt:sim_time;
N  = length(T);

% Allocations
X          = NaN(mx0, N);
u          = NaN(4, N - 1);
theta_wb_c = NaN(mt0, N - 1);
cross_track_error   = NaN(1, N );


% Initial conditions
X(:, 1) = x_0;

for i = 1:N-1

    waypoints  = update_waypoints(X(:, i));

    output_guidance_system  = guidance_system(X(:, i), waypoints.previous_waypoint, waypoints.next_waypoint);

    theta_wb_c(:, i)        = output_guidance_system(1:3);
    cross_track_error(:, i) = output_guidance_system(4);

    u(:, i)                 = controller_attitude_nonlinear(X(:, i), theta_wb_c(:, i));
    
    d_X(:, i) = quadrotor(X(:, i), u(:, i));
    X(:, i+1) = X(:, i) + dt*d_X(:, i);

end

%% Extract results
theta_wb_out = X(7:9, :);           
r = X(1:3, :);
d_r = X(4:6, :);

%% Plot - Orientation
plotter = data_plotter();

plotter.figure_nr = 1;
plotter.plot_orientation(T, theta_wb_out, theta_wb_c);

%% Plot - Position
plotter.figure_nr = plotter.figure_nr + 1;
plotter.plot_position(T, r);

%% Plot - Motors
% plotter.figure_nr = plotter.figure_nr + 1;
% plotter.plot_motors(T, u);

%% Plot - XY
plotter.figure_nr = plotter.figure_nr + 1;
plotter.plot_XY(r, waypoints, approach_distance);

%% Plot - Translational speed
plotter.figure_nr = plotter.figure_nr + 1;
plotter.plot_speed(T, d_r);

%% Plot - Cross_track_error
plotter.figure_nr = plotter.figure_nr + 1;
plotter.plot_cross_track_error(T, cross_track_error);