d = quasar_train(2,:);
% construct x 
x = [lambdas, ones(size(lambdas,1),1)];
y = d';
% use nornal equation to get theta instead of the gradient descent method
theta = (x' * x) \ x' * y;
scatter(lambdas, d', 20, 'g');
hold on;
plot(lambdas, theta(1) * lambdas + theta(2));