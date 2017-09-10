% smooth the data
smooth_train_qso = smooth(train_qso, lambdas);
smooth_test_qso = smooth(test_qso, lambdas);
% set neighbor = 3
k = 3;

f_left_errors = 0;

% use the training data set to test the functional regression
for j = 1:size(smooth_train_qso,1)
    f_right = smooth_train_qso(j,:);
    
    % calculate the distance between f_right with each f^(i)_right in the
    % training set
    dis_list = zeros(size(smooth_train_qso,1),1);
    for i = 1:size(smooth_train_qso,1)
        dis_list(i,1) = distance(smooth_train_qso(i,:), f_right);
    end

    [V I] = sort(dis_list);

    den = zeros(1,50);
    num = 0;
    for i = 1:k
        den = den + ker(V(i)/V(end)) * smooth_train_qso(I(i),1:50);
        num = num + ker(V(i)/V(end));
    end

    f_left = den/num;
    f_left_errors = f_left_errors + distance_left(f_left, smooth_train_qso(j,:));
end

ave_f_left_error = f_left_errors / size(smooth_train_qso,1);

f_left_errors_t = 0;

% use the training test set to test the functional regression
for j = 1:size(smooth_test_qso,1)
    f_right = smooth_test_qso(j,:);

    dis_list = zeros(size(smooth_train_qso,1),1);
    for i = 1:size(smooth_train_qso,1)
        dis_list(i,1) = distance(smooth_train_qso(i,:), f_right);
    end

    [V I] = sort(dis_list);

    den = zeros(1,50);
    num = 0;
    for i = 1:k
        den = den + ker(V(i)/V(end)) * smooth_train_qso(I(i),1:50);
        num = num + ker(V(i)/V(end));
    end

    f_left = den/num;
    f_left_errors_t = f_left_errors_t + distance_left(f_left, smooth_test_qso(j,:));
    
    if(j == 1)
        plot(lambdas, smooth_test_qso(j,:)');
        hold on;
        plot(lambdas(1:50), f_left');
    end
end

ave_f_left_error_t = f_left_errors_t / size(smooth_test_qso,1);