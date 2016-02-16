function output = saturate(input, lower_limit, upper_limit)

s_lower_limit = size(lower_limit);
s_upper_limit = size(upper_limit);
s_input       = size(input);

lower_limit_scalar = false;
upper_limit_scalar = false;

if (s_lower_limit == ones(1, 2)) lower_limit_scalar = true; end
if (s_upper_limit == ones(1, 2)) upper_limit_scalar = true; end

if ((s_lower_limit ~= s_input & lower_limit_scalar == false) | (s_upper_limit ~= s_input & upper_limit_scalar == false))
	error('ERROR -> saturate: Dimension of saturation limits not valid.')
end

if (upper_limit_scalar) upper_limit = upper_limit * ones(size(input)); end
if (lower_limit_scalar) lower_limit = lower_limit * ones(size(input)); end

output = NaN(size(input));

for i = 1:length(input)
	if (input(i) > upper_limit(i))
		output(i) = upper_limit(i);
	elseif (input(i) < lower_limit(i))
		output(i) = lower_limit(i);
	else
		output(i) = input(i);
	end
end

end