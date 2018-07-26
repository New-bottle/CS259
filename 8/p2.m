m = 5;
eps = 0.8;
X = rand(m, 2);
Y = f(X);

W = zeros(m, m);
for i = 1:m
	for j = 1:m
		W(i,j) = norm(Y(i,:) - Y(j,:), 2);
		if (W(i,j) > eps)
			W(i,j) = 0;
		end
	end
end

N = floyd_warshall(W);
J = eye(m, m) - ones(m, m) / m;
B = -0.5 * J * (N .* N) * J';
[V, U] = eig(B);
v1 = V(:,1);
v2 = V(:,2);
u1 = U(1, 1);
u2 = U(2, 2);
Iso = [v1*sqrt(u1) v2*sqrt(u2)]
 
