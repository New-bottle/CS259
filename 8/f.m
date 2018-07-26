function [y] = f(x)
	m = size(x, 1);
	y = zeros(m, 3);
	y(:,1) = x(:,1) + sin(x(:,1));
	y(:,2) = x(:,2) + cos(x(:,2));
	y(:,3) = x(:,1) .* x(:,2);
