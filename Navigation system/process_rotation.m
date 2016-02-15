function d_omega_wb = process_rotation(omega_wb, T_motors, constants)

d_omega_wb = constants.I\(T_motors - cross(omega_wb, constants.I*omega_wb));

end