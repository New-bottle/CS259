x = linspace(-1, 1, 10);
fx = sin(2 * pi * x);

% generate Kxx, P
Kxx = zeros(10, 10);
for i = 1:10
	for j = 1:10
		Kxx(i,j) = abs((x(i)-x(j))^3);
	end
end
P = [ones(10, 1) x'];

A = [Kxx, P; P' zeros(2, 2)];
b = [fx'; zeros(2, 1)];
tmp = A\b;

d1 = tmp(11);
d2 = tmp(12);
% f(x) = d1 + d2*x + sum(c_i*|x_i-x_j|^3)

x_fit = linspace(-1, 1, 100);
y = f(tmp, x_fit);
y_true = sin(2 * pi * x_fit);

figure(1);
plot(x_fit, y, x_fit, y_true);
xlabel('x');
ylabel('y');
legend('interpolation curve', 'ground truth');

figure(2);
plot(x_fit, (y - y_true).^2);
xlabel('x');
ylabel('approximation error');
