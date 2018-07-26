m = 5;
try_times = 100;

plot_num = 30;
eps = linspace(2, 3, plot_num);
value = zeros(3, plot_num);

for i = 1:plot_num
	for j = 1:try_times
		x = rand(m, 2);
		y = f(x);

		W = zeros(m, m);
		for k = 1:m
			for l = 1:m
				W(k,l) = norm(y(k,:) - y(l,:), 2);
				if (W(k,l) > eps(i))
					W(k,l) = 0;
				end
			end
		end

		D = diag(sum(W, 2));
		L = D - W;
		[V1, D1] = eig(L);
		X_1 = [V1(:,2)/sqrt(D1(2,2)) V1(:,3)/sqrt(D1(3,3))];

		M = floyd_warshall(W);
		J = eye(m,m) - ones(m,m).* (1.0/m);
		B = -0.5 * J * (M.*M) * J';
		[V2, D2] = eig(B);
		X_2 = [V2(:,1)*sqrt(D2(1,1)) V2(:,2)*sqrt(D2(2,2))];

		value(1,i) = value(1,i) + spline(x);
		value(2,i) = value(2,i) + spline(X_1);
		value(3,i) = value(3,i) + spline(X_2);
	end
end
value = value / try_times;

plot(eps, value(1,:), eps, value(2,:), eps, value(3,:));
legend('Original', 'Laplace eigenmap', 'Isomap embeddings');
xlabel('\epsilon');
ylabel('Spline energy');
