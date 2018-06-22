function [pinvA] = tikhonov_inv(A)
	[u z v] = svd(A, 'econ');
	lambda = sqrt(z(1,1)) / 100;
	for k = 1:length(z)
		iz(k,k) = z(k,k) / (z(k,k) ^ 2 + lambda ^ 2);
	end
	pinvA = v * iz * u';
