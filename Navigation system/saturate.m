function output = saturate(input, lower_limit, upper_limit)

if (input > upper_limit)
	output = upper_limit;
elseif (input < lower_limit)
	output =  lower_limit;
else
	output = input;
end

end