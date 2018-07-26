X = zeros(3,1);
Y = zeros(3,1);
m = 7;
for k = 1:3
	n = k*m;
	x = linspace(-1, 1, n);
	A = chebmatrix(x, n);
	X(k) = n;
	Y(k) = n * norm(pinv(A), inf);
end
semilogy(X, Y, '--o');
xlabel('n');
ylabel('n||A||_{\infty}');
