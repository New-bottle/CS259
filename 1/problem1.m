A = [6 3; 1 3];
E = [1 0; 0 0];

h = linspace(0,5,51);

ans = zeros(1, length(h));
for i=1:length(h)
	ans(i) = norm(inv(A + h(i)*E) - (inv(A)-h(i)*inv(A)*E*inv(A)));
end

% plot(h, ans);
loglog(h,ans);

