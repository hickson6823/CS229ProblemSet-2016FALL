% Function to calculate the derivative vector of the cost function for
% introducing Newton's method
%   INPUT: variable x[m * n_x] in training set, variable y[m * 1] in training set,
%   parameters theta[n*x * 1]
%   OUTPUT: derivative vector [n_x * 1]

function d = derivative(x, y, theta)
    m = size(x,1);
    d = -sum((y .* sigmoid(x, -y, theta)) .* x)/m;
end