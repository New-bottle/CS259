load('cricket.dat');
A = cricket(:,1);
b = cricket(:,2);

A = [A, ones(length(b), 1)];

% ===== initial ===== %

I = eye(length(b));

A
tmp = eig(I * A * A');
eig_max = max(tmp);
eig_min = min(tmp);
alpha_opt = 2 / (eig_max + eig_min);

log_rho_i = log(norm(I - alpha_opt*I*A*A'))
