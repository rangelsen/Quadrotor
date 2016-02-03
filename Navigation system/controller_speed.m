function d_r_c = controller_speed(theta_wb, r, dd_r, r_c)

K_d_x = evalin('base', 'K_d_x');
K_d_y = evalin('base', 'K_d_y');
K_d_z = evalin('base', 'K_d_z');

phi   = theta_wb(1);
theta = theta_wb(2);
psi   = theta_wb(3);

x = r(1);
y = r(2);
z = r(3);

x_c = r_c(1);
y_c = r_c(2);
z_c = r_c(3);

d_x = d_r(1);
d_y = d_r(2);
d_z = d_r(3);

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



end