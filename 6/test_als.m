m = 1000;
n = 500;
k = 5;
d = 0.2;
lambda = 10;

U = rand(m,k);
V = rand(n,k);
tmp = rand(m,n);
exist = tmp < d;
I = find(tmp >= d);

A = U*V';
PA = A;
PA(I) = 0;

X = rand(m,k);
Y = rand(n,k);
M = X * Y';
M(I) = 0;
err = zeros(100,1);
for l = 1:100
  err(l) = norm(M - PA)/norm(PA);
  for i = 1:m
	  loca = find(exist(i, :) ~= 0);
	  y = Y(loca,:);
	  a = A(i,:)';
	  a = a(loca,:);
	  X(i, :) = ((y' * y + lambda * eye(k,k)) \ (y' * a))';
  end
  for j = 1:n
	  loca = find(exist(:, j) ~= 0);
	  x = X(loca,:);
	  a = A(:,j);
	  a = a(loca,:);
	  Y(j, :) = ((x' * x + lambda * eye(k,k)) \ (x' * a))';
  end
  M = X*Y';
  M(I) = 0;
end
plot(err)
title('Error v.s. Iter-times');
xlabel('Iter-times');
ylabel('Error');
