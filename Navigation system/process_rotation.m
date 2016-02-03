function d_omega_wb = process_rotation(omega_wb, T_motors)

I = evalin('base', 'I');

d_omega_wb = I\(T_motors - cross(omega_wb, I*omega_wb));

end