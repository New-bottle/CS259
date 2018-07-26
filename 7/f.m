function [y] = f(tmp, X)
	x = linspace(-1, 1, 10);
	y = tmp(11) * ones(1, length(X)) + tmp(12) * X;
	for i = 1:10
		y = y + tmp(i) * (abs(X - x(i)).^3);
	end
	
