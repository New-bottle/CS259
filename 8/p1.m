% routine to construct W
% y is a m*3 matrix, eps is the threshold
m = 5;
eps = 0.8;

x = rand(m, 2);
y = f(x);
W = zeros(m, m);
for i = 1:m
	for j = 1:m
		W(i,j) = norm(y(i,:) - y(j,:), 2);
		if (W(i,j) > eps)
			W(i,j) = 0;
		end
	end
end

D = diag(sum(W,2));
L = D - W;
[V, U] = eig(L);
u2 = U(2, 2);
u3 = U(3, 3);
v2 = V(:, 2);
v3 = V(:, 3);
B = [v2 / sqrt(u2) v3 / sqrt(u3)]
