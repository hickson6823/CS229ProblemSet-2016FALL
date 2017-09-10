% Function to calculate the cost in logistic regression
%   INPUT: variable x in training set, variable y in training set,
%   parameters theta
%   OUTPUT: cost

function loss = cost(x, y, theta)
    m = size(x,1);
    loss = sum(-log(sigmoid(x, y, theta))) / m;
end