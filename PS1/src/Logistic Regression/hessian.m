% Function to calculate the hessian matrix of the cost function for
% introducing Newton's method
%   INPUT: variable x[m * n_x] in training set, variable y[m * 1] in training set,
%   parameters theta[n*x * 1]
%   OUTPUT: hessian matrix h[n_x * n_x]

function [ h ] = hessian( x, y, theta )
    s = sigmoid(x, y, theta);
    m = (size(x, 1));
    h = (x' * (((s .* (1 - s)) .* (y .^ 2)) .* x)) ./ m;
end

