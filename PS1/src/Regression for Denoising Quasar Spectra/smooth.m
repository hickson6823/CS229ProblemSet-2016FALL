% function to smooth training and test data with locally weighted
% regressions
% INPUT: 
% data[m * n], m is the number of the training data, n is the length
% of a training sample
% lambdas[n * 1], lambdas is the corresponding wavelength of the data of
% intensity
% 
% OUTPUT:
% smooth_data[m * n], data smoothed with locally weighted regressions

function smooth_data = smooth(data, lambdas)
    % use nornal equation to get theta instead of the gradient descent method
    x = [lambdas, ones(size(lambdas,1),1)];
    tau = 5;
    smooth_data = zeros(size(data,1),size(data,2));
    
    for k = 1:size(data, 1)
        y = data(k,:)';
        for i = 1:size(data,2) 
            W = diag(exp(-((lambdas(i,1) - x(:,1)') .^ 2) ./ (2 * (tau ^ 2))));
            theta = (x' * W * x) \ (x' * W * y);
            smooth_data(k,i) = theta(1) * lambdas(i,1) + theta(2);
        end
    end
end