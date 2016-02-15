function gamma_motors = controller_attitude_nonlinear(X, theta_wb_c, constants)

%% Constants
k_F       = constants.k_F;
k_T       = constants.k_T;

phi = X(7);
theta = X(8);
psi = X(9);

theta_wb = X(7:9);
omega_wb = X(10:12);

d_theta_wb = angular_momentum_transformation(theta_wb)*omega_wb;

T = -constants.K_p*(theta_wb - theta_wb_c) - constants.K_d*d_theta_wb;

T_4 = constants.m*constants.g/(cos(phi)*cos(theta));

T = [  T;
     T_4];

gamma_NE = 1/(4*k_F*k_T)*(T(3)*k_F - T(1)*k_T - T(2)*k_T + T(4)*k_T);
gamma_SE = 1/(4*k_F*k_T)*(-T(3)*k_F - T(1)*k_T + T(2)*k_T + T(4)*k_T);
gamma_SW = 1/(4*k_F*k_T)*(T(3)*k_F + T(1)*k_T + T(2)*k_T + T(4)*k_T);
gamma_NW = 1/(4*k_F*k_T)*(-T(3)*k_F + T(1)*k_T - T(2)*k_T + T(4)*k_T);

if (gamma_NE > constants.gamma_max) , gamma_NE = constants.gamma_max; end
if (gamma_NE < constants.gamma_min) , gamma_NE = constants.gamma_min; end

if (gamma_SE > constants.gamma_max) , gamma_SE = constants.gamma_max; end
if (gamma_SE < constants.gamma_min) , gamma_SE = constants.gamma_min; end

if (gamma_SW > constants.gamma_max) , gamma_SW = constants.gamma_max; end
if (gamma_SW < constants.gamma_min) , gamma_SW = constants.gamma_min; end

if (gamma_NW > constants.gamma_max) , gamma_NW = constants.gamma_max; end
if (gamma_NW < constants.gamma_min) , gamma_NW = constants.gamma_min; end


gamma_motors = [ gamma_NE;
                 gamma_SE;
                 gamma_SW;
                 gamma_NW];
end