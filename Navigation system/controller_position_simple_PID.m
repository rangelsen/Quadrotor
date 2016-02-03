function theta_c = controller_position_simple_PID(theta_wb, int_r_error, r, d_r, r_c)
%% Constants
K_p_x = evalin('base', 'K_p_x');
K_p_y = evalin('base', 'K_p_y');
K_p_z = evalin('base', 'K_p_z');
K_d_x = evalin('base', 'K_d_x');
K_d_y = evalin('base', 'K_d_y');
K_i_x = evalin('base', 'K_i_x');
K_i_y = evalin('base', 'K_i_y');

phi_c_max   = evalin('base', 'phi_c_max');
theta_c_max = evalin('base', 'theta_c_max');

approach_distance = evalin('base', 'approach_distance');
approach_speed    = evalin('base', 'approach_speed');
travel_speed      = evalin('base', 'travel_speed');
pos_ref_tolerance = evalin('base', 'pos_ref_tolerance');

%% Extract parameters
int_x = int_r_error(1);
int_y = int_r_error(2);

x = r(1); x_c = r_c(1);
y = r(2); y_c = r_c(2);
z = r(3); z_c = r_c(3);

d_x = d_r(1);
d_y = d_r(2);

phi   = theta_wb(1);
theta = theta_wb(2);
psi   = theta_wb(3);

%% Compute desired speed
distance_to_pos_ref = norm([x_c y_c] - [x y]);

if (distance_to_pos_ref < pos_ref_tolerance)
    d_x_c = 0;
    d_y_c = 0;
elseif (distance_to_pos_ref < approach_distance)
    d_x_c = approach_speed;
    d_y_c = approach_speed;
else
    d_x_c = travel_speed;
    d_y_c = travel_speed;
end

if (x > x_c)
    d_x_c = -d_x_c;
end
if (y > y_c)
    d_y_c = -d_y_c;
end

%% Compute desired angles
phi_c   =  K_p_y*(y - y_c) + K_d_y*(d_y - d_y_c) + K_i_y*int_y;
theta_c =  -K_p_x*(x - x_c) - K_d_x*(d_x - d_x_c)- K_i_x*int_x;
psi_c   = 0;

%% Make desired angles within feasible range
if phi_c > phi_c_max
    phi_c = phi_c_max;
elseif phi_c < -phi_c_max
    phi_c = -phi_c_max;
end
if theta_c > theta_c_max
    theta_c = theta_c_max;
elseif theta_c < -theta_c_max
    theta_c = -theta_c_max;
end

%% Return
theta_c = [   phi_c;
            theta_c;
              psi_c];
end