clear all; clc;  
%% Options

% Plotting options
PLOT_POSITION            = false;
PLOT_POSITION_NORTH_WEST = true;
PLOT_VELOCITY            = false;
PLOT_ORIENTATION         = false;
PLOT_CROSS_TRACK_ERROR   = false;
PLOT_MOTORS              = false;

%% Initialize system constants
constants = Constants();

%% Initial Conditions

r_0     = [10 0 0]';
d_r_0   = [ 0 0 0]';
theta_0 = [ 0 0 0]';
omega_0 = [ 0 0 0]';

r_z_c = 150;

x_0 = [    r_0;
         d_r_0;
       theta_0;
       omega_0];
   
[mx0, nx0] = size(x_0);  
[mt0, nt0] = size(theta_0);

%% Simulation parameters

sim_time = 200;

dt = .005;
T  = 0:dt:sim_time;
N  = length(T);

% Allocations
X                 = NaN(mx0, N);
u                 = NaN(constants.n_motors, N - 1);
theta_wb_c        = NaN(mt0, N - 1);
cross_track_error = NaN(1, N );


% Initial conditions
X(:, 1) = x_0;

for i = 1:N-1
    
    waypoints  = update_waypoints(X(:, i), constants);

    output_guidance_system  = guidance_system(X(:, i), waypoints.previous_waypoint, waypoints.next_waypoint, constants);

    theta_wb_c(:, i)        = output_guidance_system(1:3);
    cross_track_error(:, i) = output_guidance_system(4);
    
    attitude_controller_contribution = controller_attitude_nonlinear(X(:, i), theta_wb_c(:, i), constants);
    altitude_controller_contribution = controller_altitude_feedback_linearizing(X(:, i), r_z_c, constants);
    
    u(:, i) = attitude_controller_contribution + altitude_controller_contribution;
    u(:, i) = saturate(u(:, i), constants.gamma_min, constants.gamma_max);
    
    d_X(:, i) = quadrotor(X(:, i), u(:, i), constants);
    X(:, i+1) = X(:, i) + dt*d_X(:, i);

end

%% Extract results
theta_wb_out = X(7:9, :);           
r = X(1:3, :);
d_r = X(4:6, :);

%% Plot
plotter = data_plotter();
plotter.figure_nr = 0;

%% Plot - Orientation
if(PLOT_ORIENTATION)
    plotter.figure_nr = plotter.figure_nr + 1;
    plotter.plot_orientation(T, theta_wb_out, theta_wb_c);
end

%% Plot - Position
if(PLOT_POSITION)
    plotter.figure_nr = plotter.figure_nr + 1;
    plotter.plot_position(T, r);
end

%% Plot - Motors
if(PLOT_MOTORS)
    plotter.figure_nr = plotter.figure_nr + 1;
    plotter.plot_motors(T, u, constants);
end

%% Plot - XY
if(PLOT_POSITION_NORTH_WEST)
    plotter.figure_nr = plotter.figure_nr + 1;
    plotter.plot_XY(r, waypoints, constants.approach_distance);
end

%% Plot - Translational speed
if(PLOT_VELOCITY)
    plotter.figure_nr = plotter.figure_nr + 1;
    plotter.plot_speed(T, d_r);
end

%% Plot - Cross_track_error
if(PLOT_CROSS_TRACK_ERROR)
    plotter.figure_nr = plotter.figure_nr + 1;
    plotter.plot_cross_track_error(T, cross_track_error);
end
