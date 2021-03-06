classdef Constants

	properties
        
        %% Motors
		n_motors; motor_kv_rating; motor_voltage_max;
        motor_speed_max; gamma_max; gamma_min;

		%% Physical
		l; k_F; k_T; I; m; g;

		%% Attitude controller
		K_p; K_d; K_p_yaw; K_d_yaw; thr_base;

		%% Altitude controller
		K_p_z; K_d_z; K_i_z;

		%% Position controller
		K_p_phi; K_d_phi; K_p_theta; phi_c_max; theta_c_max; psi_c_tolerance;
		approach_distance; K_p_pos; K_d_pos; max_velocity;

	end

	methods

		%% Constructor

		function obj = Constants() 
            %% Motors
            
			obj.n_motors = 4;
            obj.motor_kv_rating   = 910;
            obj.motor_voltage_max = 12.6;
            obj.motor_speed_max   = obj.motor_kv_rating * obj.motor_voltage_max; % Maximum angular motor speed, rad/s
			obj.gamma_max         = obj.motor_speed_max^2;
            obj.gamma_min         = 0;
		
			%% Physical

			obj.l = .15;		% Length of arm in x-configuration
			obj.k_F = 1e-6;		% Motor force constant F = k_F*w^2 = k_F*gamma
			obj.k_T = 1e-6;		% Motor torque constant T = k_T*w^2 = k_T*gamma

			obj.I = 4*eye(3);	% Inertia matrix

			obj.m = 2;			% Mass
			obj.g = 9.81;		% Gravitational acceleration

			%% Attitude controller

			obj.K_p = 300;								% Proportional gain in roll and pitch
			obj.K_d = 120;								% Derivative gain in roll and pitch
			obj.K_p_yaw = obj.K_p;						% Porportional gain in yaw
			obj.K_d_yaw = obj.K_d;						% Derivative gain in yaw
			obj.thr_base = 2*9.81/(4*obj.k_F) + 100;	% Base throttle for approximate altitude hold

			%% Altitude controller

			obj.K_p_z = 30;		% Gains for the altitude PID
			obj.K_d_z = 100;
			obj.K_i_z = 0.01;

			%% Position controller

			obj.K_p_phi = .02;				% Gains for roll error
			obj.K_d_phi = 10;
			obj.K_p_theta = .1;

			obj.phi_c_max = deg2rad(30);	% Maximum allowed commanded roll angle (phi)
			obj.theta_c_max = 10;			% Maximum allowed commanded pitch angle (theta)

			obj.psi_c_tolerance = pi/12;	% Region of acceptance around psi_c

			obj.approach_distance = 2;		% Distance away from waypoint where the position hold controller takes over

			obj.K_p_pos = .04;				% Gains for position hold controller
			obj.K_d_pos = 20;

			obj.max_velocity = 2;			% Max speed in tracking mode
		end
	end
end