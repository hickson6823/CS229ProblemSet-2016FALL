function [theta, feature_inds, thresholds] = stump_booster(X, y, T)
% STUMP_BOOSTER Uses boosted decision stumps to train a classifier
%
% [theta, feature_inds, thresholds] = stump_booster(X, y, T)
%  performs T rounds of boosted decision stumps to classify the data X,
%  which is an m-by-n matrix of m training examples in dimension n,
%  to match y.
%
%  The returned parameters are theta, the parameter vector in T dimensions,
%  the feature_inds, which are indices of the features (a T dimensional
%  vector taking values in {1, 2, ..., n}), and thresholds, which are
%  real-valued thresholds. The resulting classifier may be computed on an
%  n-dimensional training example by
%
%   theta' * sign(x(feature_inds) - thresholds).
%
%  The resulting predictions may be computed simultaneously on an
%  n-dimensional dataset, represented as an m-by-n matrix X, by
%
%  sign(X(:, feature_inds) - repmat(thresholds', m, 1)) * theta.
%
%  This is an m-vector of the predicted margins.

[mm, nn] = size(X);
p_dist = ones(mm, 1);
p_dist = p_dist / sum(p_dist);

theta = [];
feature_inds = [];
thresholds = [];
w = ones(mm, 1);
for iter = 1:T
  [ind, thresh] = find_best_threshold(X, y, p_dist);
  feature_inds = [feature_inds; ind];
  thresholds = [thresholds; thresh];
  % ------- You should implement your code here -------- %
  di = (((X(:,ind) > thresh) * 2) - 1) .* y;
  W_plus = sum(w(di == 1));
  W_minus = sum(w(di == -1));
  newest_theta_param = (1/2) * log(W_plus/W_minus);  % Change this line so that newest_theta_param takes
                           % the optimal weight for the new decision stump.
  

  % ------- No need to change this part ------- %
  theta = [theta; newest_theta_param];
  w = exp(-y .* (...
    sign(X(:, feature_inds) - repmat(thresholds', mm, 1)) * theta));

  p_dist = w / sum(w);
  
  losses_per_example = exp(-y .* (...
    sign(X(:, feature_inds) - repmat(thresholds', mm, 1)) * theta));
  fprintf(1, 'Iter %d, empirical risk = %1.4f, empirical error = %1.4f\n', ...
          iter, sum(losses_per_example), sum(losses_per_example >= 1));
end
