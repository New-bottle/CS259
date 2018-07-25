% code for problem 1 (HALS-RRI)

n = 4;
k = 5;
m = 6;

A = rand(n, m) * 10;
W = rand(n, k);
H = rand(k, m);
u = zeros(n, 1);
v = zeros(1, m);

steps = 100;
err = zeros(steps, 1);
for l = 1:steps
	err(l) = norm(R, 'fro') / norm(A, 'fro');
	for j = 1:k
		R = A - W * H;
		RH = R * H';
		HH = H * H';
		for i = 1:n
			u(i) = max(-W(i, j), RH(i, j) / HH(j, j));
		end
		W(:, j) = W(:, j) + u;
	end
	for i = 1:k
		R = A - W * H;
		WR = W' * R;
		WW = W' * W;
		for j = 1:m
			v(j) = max(-H(i, j), WR(i, j) / WW(i, i));
		end
		H(i, :) = H(i, :) + v;
	end
end

A
W*H
plot(err);
xlabel('steps');
ylabel('err');

