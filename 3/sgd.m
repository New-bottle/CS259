load('cricket.dat');
X = cricket(:,1);
Y = cricket(:,2);

X = [X, ones(length(Y), 1)];


% initial
% W = [5, -4];
% Ax=b ---> x=A\B

W = [0; 0];
optimal_w =  X' * X \ X' * Y

alpha = 0.0005;
ite_steps = 1000;
cost_sgd = zeros(1, length(Y));

cost = ((X*W-Y)'*(X*W-Y))^0.5;


for i=1:ite_steps
	idx = randi(length(Y), 1, 1);
	W = W - alpha * X(idx,:)'*(X(idx,:)*W-Y(idx));
%	W = W - alpha * delta(W, X(idx,:), Y(idx));
	cost_sgd(i) = ((X*W-Y)'*(X*W-Y))^0.5;
end

W
cost = ((X*W-Y)'*(X*W-Y))^0.5;
optimal_w
optimal_cost = ((X*optimal_w-Y)'*(X*optimal_w-Y))^0.5;

id = [1:ite_steps / 50:ite_steps];
gap = cost_sgd - optimal_cost;
plot(id, gap(id));
xlabel('number of steps');
ylabel('optimality gap');
%{
function [ans] = delta(W, X, Y)
	len = length(Y);
	ans = X'*(X*W-Y);
	ans = ans / len;
%}
