function output = saturate(input, limit)

if (input > limit)
	output = limit;
elseif (input < -limit)
	output = - limit;
else
	output = input;
end

end