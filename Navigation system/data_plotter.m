classdef data_plotter
    properties
        figure_nr;
    end
    
    methods
        
        % Constructor
        function obj = data_plotter()
            obj.figure_nr = 1;
        end
        
        % ORIENTATION
        
        function plot_orientation(obj, t, theta_wb, theta_wb_c)
            
            y_axis_limit = 90;
            
            phi   = rad2deg(theta_wb(1, :));
            theta = rad2deg(theta_wb(2, :));
            psi   = rad2deg(theta_wb(3, :));
            
            phi_c   = rad2deg(theta_wb_c(1, :));
            theta_c = rad2deg(theta_wb_c(2, :));
            psi_c   = rad2deg(theta_wb_c(3, :));
            
            figure(obj.figure_nr);
            set(gcf, 'Name', 'Quadrotor orientation');
            
            subplot(3, 1, 1);
            plot(t, phi, 'b');
            hold on; grid on;
            plot(t(1:end-1), phi_c, 'r');
            title('\phi');
            axis([0 t(end) -y_axis_limit y_axis_limit]);
            xlabel('Time'), ylabel('Deg');
            hold off;
            
            subplot(3, 1, 2);
            plot(t, theta, 'b');
            hold on; grid on;
            plot(t(1:end-1), theta_c, 'r');
            title('\theta');
            axis([0 t(end) -y_axis_limit y_axis_limit]);
            xlabel('Time'), ylabel('Deg');
            hold off;
            
            subplot(3, 1, 3);
            plot(t, psi, 'b');
            hold on; grid on;
            plot(t(1:end-1), psi_c, 'r');
            title('\psi');
            axis([0 t(end) -180 180]);
            xlabel('Time'), ylabel('Deg');
            hold off;
        end
        
        % POSITION
        
        function plot_position(obj, t, r)
            r_x = r(1, :);
            r_y = r(2, :);
            r_z = r(3, :);
                       
            figure(obj.figure_nr);
            set(gcf, 'Name', 'Quadrotor position');
            
            subplot(3, 1, 1);
            plot(t, r_x, 'b');
            grid on;
            title('x(t)');
            hold off; 
            
            subplot(3, 1, 2);
            plot(t, r_y, 'b');
            grid on;
            title('y(t)');
            hold off;
            
            subplot(3, 1, 3);
            plot(t, r_z, 'b');
            grid on;
            title('z(t)');
            hold off;
        end
        
        % MOTORS
        
        function plot_motors(obj, t, u, constants)
            
            gamma_NE = u(1, :);
            gamma_SE = u(2, :);
            gamma_SW = u(3, :);
            gamma_NW = u(4, :);
            
            figure(obj.figure_nr);
            set(gcf, 'Name', 'Quadrotor motors');
            
            subplot(2, 2, 1);
            hold on;
            stairs(t(1:end-1), gamma_NW, 'b');
            plot([t(1) t(end)], constants.gamma_max*ones(1, 2), 'r');
            title('\gamma_{NW}');
            hold off;
            
            subplot(2, 2, 2);
            hold on;
            stairs(t(1:end-1), gamma_NE, 'b');
            plot([t(1) t(end)], constants.gamma_max*ones(1, 2), 'r');
            title('\gamma_{NE}');
            hold off;
            
            subplot(2, 2, 3);
            hold on;
            stairs(t(1:end-1), gamma_SW, 'b');
            plot([t(1) t(end)], constants.gamma_max*ones(1, 2), 'r');
            title('\gamma_{SW}');
            hold off;
            
            subplot(2, 2, 4);
            hold on;
            stairs(t(1:end-1), gamma_SE, 'b');
            plot([t(1) t(end)], constants.gamma_max*ones(1, 2), 'r');
            title('\gamma_{SE}');
            hold off;
        end
        
        % XY 
        
        function plot_XY(obj, r, waypoints, approach_distance)

            r_north = r(1, :);
            r_west  = r(2, :);

            waypoints_coordinates       = waypoints.collection;
            waypoint_coordinates_north  = waypoints_coordinates(1, :);
            waypoint_coordinates_west   = waypoints_coordinates(2, :);

            figure(obj.figure_nr);
            set(gcf, 'Name', 'XY - position');

            hold on; grid on;
            plot(waypoint_coordinates_north, waypoint_coordinates_west, 'r');
            
            for i = 1:waypoints.n_waypoints
                plot(waypoint_coordinates_north(i), waypoint_coordinates_west(i), 'k.', 'LineWidth', 2);

                if (i > 1)
                    plot_circle([waypoint_coordinates_north(i) waypoint_coordinates_west(i)]', approach_distance);
                end
            end

            plot(r_north, r_west, 'k', 'LineWidth', 2);

            xlabel('North [m]'); ylabel('West [m]');
            axis equal;
            hold off;
        end

        function plot_XY_single_destination(obj, t, r, previous_waypoint, next_waypoint, approach_distance)
            r_x = r(1, :);
            r_y = r(2, :);
            
            r_x_0 = r_x(1);
            r_y_0 = r_y(1);
            
            
            
            figure(obj.figure_nr);
            set(gcf, 'Name', 'XY - position');
            
            plot(r_x, r_y, 'k');
            hold on; grid on;
            plot(previous_waypoint(1), previous_waypoint(2), 'r.');
            plot(next_waypoint(1), next_waypoint(2), 'k.');
            plot([previous_waypoint(1) next_waypoint(1)], [previous_waypoint(2) next_waypoint(2)], 'r');
            axis equal;
            xlabel('North [m]'); ylabel('West [m]');

            % Added approach distance circle

            i = 0:.001:2*pi;
            circle = NaN(2, length(i)-1);

            for j = 1:length(i)-1
                circle(:, j) = next_waypoint + approach_distance*[cos(i(j)); sin(i(j))];
            end

            plot(circle(1, :), circle(2, :), 'b--', 'LineWidth', 2);

            % Change END

            hold off;

        end
        
        % TRANSLATIONAL SPEED
        
        function plot_speed(obj, T, d_r)
            d_x = d_r(1, :);
            d_y = d_r(2, :);
            d_z = d_r(3, :);
            
            figure(obj.figure_nr);
            set(gcf, 'Name', 'Quadrotor Translational speed');
            
            subplot(3, 1, 1);
            plot(T, d_x, 'b');
            hold off; grid on;
            
            subplot(3, 1, 2);
            plot(T, d_y, 'b');
            hold off; grid on;
            
            subplot(3, 1, 3);
            plot(T, d_z, 'b');
            hold off; grid on;
            
        end

        % CROSS-TRACK ERROR

        function plot_cross_track_error(obj, T, cross_track_error)
            figure(obj.figure_nr);
            set(gcf, 'Name', 'Cross-track error');

            plot(T, cross_track_error);
            hold off; grid on;
            xlabel('Time'); ylabel('m');
        end
    end
end