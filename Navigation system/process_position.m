function dd_r = process_position(theta_wb, F_motors, constants)

F_sum = [           0;
                    0;
         sum(F_motors)];
     
R_wb = rotation(theta_wb);     

dd_r = 1/constants.m*([0 0 -constants.m*constants.g]' + R_wb*F_sum);

end