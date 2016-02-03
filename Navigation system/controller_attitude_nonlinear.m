function gamma_motors = controller_attitude_nonlinear(X, theta_wb_c)

%% Constants
m         = evalin('base', 'm');
g         = evalin('base', 'g');
k_F       = evalin('base', 'k_F');
k_T       = evalin('base', 'k_T');
K_p       = evalin('base', 'K_p');
K_d       = evalin('base', 'K_d');
K_p_yaw   = evalin('base', 'K_p_yaw');
K_d_yaw   = evalin('base', 'K_d_yaw');
thr_base  = evalin('base', 'thr_base');
gamma_max = evalin('base', 'gamma_max');
gamma_min = evalin('base', 'gamma_min');

phi = X(7);
theta = X(8);
psi = X(9);

theta_wb = X(7:9);
omega_wb = X(10:12);

d_theta_wb = transformation(theta_wb)*omega_wb;

T = -K_p*(theta_wb - theta_wb_c) - K_d*d_theta_wb;

T_4 = m*g/(cos(phi)*cos(theta));

T = [  T;
     T_4];

gamma_NE = 1/(4*k_F*k_T)*(T(3)*k_F - T(1)*k_T - T(2)*k_T + T(4)*k_T);
gamma_SE = 1/(4*k_F*k_T)*(-T(3)*k_F - T(1)*k_T + T(2)*k_T + T(4)*k_T);
gamma_SW = 1/(4*k_F*k_T)*(T(3)*k_F + T(1)*k_T + T(2)*k_T + T(4)*k_T);
gamma_NW = 1/(4*k_F*k_T)*(-T(3)*k_F + T(1)*k_T - T(2)*k_T + T(4)*k_T);

if (gamma_NE > gamma_max) , gamma_NE = gamma_max; end
if (gamma_NE < gamma_min) , gamma_NE = gamma_min; end

if (gamma_SE > gamma_max) , gamma_SE = gamma_max; end
if (gamma_SE < gamma_min) , gamma_SE = gamma_min; end

if (gamma_SW > gamma_max) , gamma_SW = gamma_max; end
if (gamma_SW < gamma_min) , gamma_SW = gamma_min; end

if (gamma_NW > gamma_max) , gamma_NW = gamma_max; end
if (gamma_NW < gamma_min) , gamma_NW = gamma_min; end


gamma_motors = [ gamma_NE;
                 gamma_SE;
                 gamma_SW;
                 gamma_NW];
end