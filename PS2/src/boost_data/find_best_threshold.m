function [ind, thresh] = find_best_threshold(X, y, p_dist)
% FIND_BEST_THRESHOLD Finds the best threshold for the given data
%
% [ind, thresh] = find_best_threshold(X, y, p_dist) returns a threshold
%   thresh and index ind that gives the best thresholded classifier for the
%   weights p_dist on the training data. That is, the returned index ind
%   and threshold thresh minimize
%
%    sum_{i = 1}^m p(i) * 1{sign(X(i, ind) - thresh) ~= y(i)}
%
%   OR
%
%    sum_{i = 1}^m p(i) * 1{sign(thresh - X(i, ind)) ~= y(i)}.
%
%   We must check both signed directions, as it is possible that the best
%   decision stump (coordinate threshold classifier) is of the form
%   sign(threshold - x_j) rather than sign(x_j - threshold).
%
%   The data matrix X is of size m-by-n, where m is the training set size
%   and n is the dimension.
%
%   The solution version uses efficient sorting and data structures to perform
%   this calculation in time O(n m log(m)), where the size of the data matrix
%   X is m-by-n.

[mm, nn] = size(X);
ind = 1;
thresh = 0;

% ------- Your code here -------- %
%
% A few hints: you should loop over each of the nn features in the X
% matrix. It may be useful (for efficiency reasons, though this is not
% necessary) to sort each coordinate of X as you iterate through the
% features.
err = zeros(1, nn);
threshs = zeros(1,nn);
for n = 1:nn
    df = X(:,n);
    [df_sort, df_ind] = sort(df, 'descend');
    y_sort = y(df_ind);
    p_sort = p_dist(df_ind);
    
    yp = sum(y_sort .* p_sort);
    p = 2 .* cumsum(y_sort .* p_sort) - yp;
    p = 1/2 - p ./ 2;
    [V, I] = max(abs(p - 0.5));
    err(1, n) = min(p(I), 1 - p(I));
    threshs(1, n) = df_sort(I);
end

[V, ind] = min(err);
thresh = threshs(1, ind);