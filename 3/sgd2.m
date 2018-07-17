load('cricket.dat');
X = cricket(:,1);
Y = cricket(:,2);

X = [X, ones(length(Y), 1)];


% initial
% Ax=b ---> x=A\B

W = [0; 0];
optimal_w =  X' * X \ X' * Y

alphas = [0.0005:0.0005:0.003];
ite_steps = 100000;
mean_gap = zeros(length(alphas));

for i =1:length(alphas)
	W = optimal_w;
	alpha = alphas(i);
	cost_sgd = zeros(1, ite_steps);

	cost = ((X*W-Y)'*(X*W-Y))^0.5;


	for j=1:ite_steps
		idx = randi(length(Y), 1, 1);
		W = W - alpha * X(idx,:)'*(X(idx,:)*W-Y(idx));
		cost_sgd(j) = ((X*W-Y)'*(X*W-Y))^0.5;
	end

	cost = ((X*W-Y)'*(X*W-Y))^0.5;
	optimal_cost = ((X*optimal_w-Y)'*(X*optimal_w-Y))^0.5;

	id = [1:ite_steps / 50:ite_steps];
	gap = cost_sgd - optimal_cost;
	figure(i);
	bar(id, gap(id));
	axis([0,id(end),0,15]);
	title(strcat('alpha =  ', num2str(alpha)));
	xlabel('number of steps');
	ylabel('optimality gap');

	mean_gap(i) = mean(gap);
end

figure(length(alphas)+1);
plot(alphas, mean_gap);
%{
function [ans] = delta(W, X, Y)
	len = length(Y);
	ans = X'*(X*W-Y);
	ans = ans / len;
%}
