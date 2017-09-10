d = quasar_train(2,:);
% construct x 
x = [lambdas, ones(size(lambdas,1),1)];
y = d';
% use nornal equation to get theta instead of the gradient descent method
tau = [1,5,10,100,1000];
y_predict = zeros(size(lambdas,1),5);
for k = 1:size(tau,2)
    for i = 1:size(lambdas, 1)
        W = diag(exp(-((lambdas(i,1) - x(:,1)') .^ 2) ./ (2 * (tau(1,k) ^ 2))));
        theta = (x' * W * x) \ (x' * W * y);
        y_predict(i,k) = theta(1) * lambdas(i,1) + theta(2);
    end
    plot(lambdas, y_predict(:,k));
    hold on;
end
scatter(lambdas, d', 20, 'b');
legend('tau = 1','tau = 5', 'tau = 10', 'tau = 100', 'tau = 1000', 'train data');
hold on;
