A = [6 3; 1 3];
E = [1 0; 0 0];

% h = [0:5:0.01];
h = linspace(0,0.1,1001);

ans = zeros(1, length(h));
for i=1:length(h)
	ans(i) = norm(inv(A + h(i)*E) - (inv(A)-h(i)*inv(A)*E*inv(A)));
end

loglog(h,ans);

logh = log(h);
logans = log(ans);
