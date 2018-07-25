m = 1000;
n = 500;
k = 5;
d = 0.2;
lambda = 10;

U = rand(m,k);
V = rand(n,k);
I = find(rand(m,n) >= d);
A = U*V';
PA = A;
PA(I) = 0;

M = rand(m,k) * rand(n,k)';
err = zeros(100,1);
for j = 1:100
  % Take a step of the thresholded SVD iteration with threshold lambda.
  PAM = A - M;
  PAM(I) = 0;
  M = M + PAM;
  [U, S, V] = svd(M);
  S = max(S - eye(size(S)) .* lambda, zeros(size(S)));
  M = U * S * V';
  MM = M;
  MM(I) = 0;
  err(j) = norm(MM-PA)/norm(PA);
end
plot(err)
title('Error v.s. Iter-times');
xlabel('Iter-times');
ylabel('Error');
