function plot_circle(center, radius)

	t = 0:.001:2*pi;
	circle = NaN(2, length(t) - 1);

	for k = 1:length(t) - 1
		circle(:, k) = center + radius * [cos(t(k)) sin(t(k))]';
	end

	plot(circle(1, :), circle(2, :), 'b--', 'LineWidth', 2);

end