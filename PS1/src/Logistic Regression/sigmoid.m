% Function to get value of the sigmoid function as part of calculations
% of the cost/derivate/hessian
%   INPUT: variable x[m * n_x] in training set, variable y[m * 1] in training set,
%   parameters theta[n*x * 1]
%   OUTPUT: sigmoid function value s[m * 1]

function s = sigmoid(x,y,theta)
    s = 1 ./ (1 + exp(-y .* (x * theta)));
end