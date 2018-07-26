function E = spline(x)
	E = 0;
	m = size(x, 1);
	K = zeros(m, m);
	for i = 1:m
		for j = 1:m
			r = norm(x(i,:)-x(j,:),2);
			if r == 0
				K(i,j) = 0;
			else
				K(i,j) = r.^2*log(r);
			end
		end
	end
	P = [x ones(m, 1)];
	A = [K P; P' zeros(3, 3)];
	y = f(x);

	for i = 1:3
		b = [y(:,i) ; zeros(3,1)];
		coef = A \ b;
		c = coef(1:m,:);
		E = E + c'*K*c;
	end

