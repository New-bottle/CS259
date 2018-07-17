load('cricket.dat');
A = cricket(:,1);
b = cricket(:,2);

A = [A, ones(length(b), 1)];

I = eye(2);

% initial
% Ax=b ---> x=A\B

choose_times = 1000;
samples = [1:1:5];
log_rho_g = zeros(length(samples), 1);
for k = 1:length(samples)
	sample_size = samples(k);
	log_rho_i = zeros(choose_times, 1);
	m = length(b);

	for i=1:choose_times
		idx = randi(m, sample_size, 1);
		G = zeros(2, 2);
		for j=1:sample_size
			G = G + m / sample_size * (A(idx, :)' * A(idx, :));
		end
		tmp = eig(G * A' * A);
		eig_max = max(tmp);
		eig_min = min(tmp);
		alpha_opt = 2 / (eig_max + eig_min);

		log_rho_i(i) = log(norm(I - alpha_opt*G*A'*A));
	end

	plot(log_rho_i);
	log_rho_g(k) = mean(log_rho_i);
end

samples
log_rho_g
bar(samples, log_rho_g);
ylabel('log \rho (G)');
xlabel('sample sizes');
