% load the training set and initialize the parameters and cost list vector
train_x = load("assets/logistic_x.txt");
train_y = load("assets/logistic_y.txt");
train_x(:,size(train_x,2) + 1) = ones(size(train_x,1),1);
theta = zeros(size(train_x,2),1);
lostlist = zeros(1,500);

% apply the Newton's method to train the logistic regression model
for i = 1:500
    
    lostlist(1,i) = cost(train_x, train_y, theta);
    d = derivative(train_x, train_y , theta);
    h = hessian(train_x, train_y, theta);
    theta = theta - h\(d');    
    
end

% draw the distribution of training data and the final model
ind1 = train_y == 1;
ind2 = train_y == -1;
scatter(train_x(ind1,1), train_x(ind1,2),'g');
hold on;
scatter(train_x(ind2,1), train_x(ind2,2),'r');
hold on;
x = 0:8;
y = -(theta(1) * x + theta(3))/theta(2);
plot(x,y);