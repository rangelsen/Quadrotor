classdef waypoints_collection

	properties
		waypoints;
	end

	methods

		% CONSTRUCTOR
		function obj = waypoints_collection()
			wp_start = [ 0  0]';
			wp_1     = [10 10]';
			wp_end   = [ 0 20]';

			obj.waypoints = [wp_start wp_1 wp_end];
		end

		% Get number of waypoints
		function n_waypoints = get_n_waypoints(obj)
			[mwp, n_waypoints]  = size(obj.waypoints);
		end

		% Get waypoints
		function wp = get_waypoints(obj)
			wp = obj.waypoints;
		end

	end

end