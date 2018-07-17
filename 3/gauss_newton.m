load('cricket.dat');
A = cricket(:,1);
b = cricket(:,2);

A = [A, ones(length(b), 1)];

% ===== initial ===== %

max_step = 1000;
alpha = 0.005;
c = 0.0003;
threshold = 1e-4;

len = length(b);
phi = 0;
tmp = A*x-b;
for i = 1:len
	phi = phi + exp(tmp(i)^2);
end
phi = phi - 1;
% ===== calculate phi ===== %

x = [0; 0];
errors = zeros(1, max_step);

for i = 1:max_step
	r = b - A*x;

	df = -2 * c * exp(c*r.^2).*r.*A;
	f = exp(c*r.^2) - 1;

	p = -(df'*df) \ (df'*f);
	x = x + alpha * p;

	errors(i) = 0.5 * (f' * f);

	if norm(df, 2) < threshold
		break;
	end
end

x_step = 1:max_step;
plot(x_step, errors);
xlabel('steps');
ylabel('funciton loss');

