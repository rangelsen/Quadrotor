function dd_r = process_position(theta_wb, F_motors)

m = evalin('base', 'm');
g = evalin('base', 'g');

F_sum = [           0;
                    0;
         sum(F_motors)];
     
R_wb = rotation(theta_wb);     

dd_r = 1/m*([0 0 -m*g]' + R_wb*F_sum);

end