% Before using this method, set num_train to be the number of training
% examples you wish to read.
clear;

[sparseTrainMatrix, tokenlist, trainCategory] = ...
    readMatrix(sprintf('MATRIX.TRAIN.%d', 50));

% Make y be a vector of +/-1 labels and X be a {0, 1} matrix.
ytrain = (2 * trainCategory - 1)';
Xtrain = 1.0 * (sparseTrainMatrix > 0);

numTrainDocs = size(Xtrain, 1);
numTokens = size(Xtrain, 2);

% Xtrain is a (numTrainDocs x numTokens) sparse matrix.
% Each row represents a unique document (email).
% The j-th column of the row $i$ represents if the j-th token appears in
% email i.

% tokenlist is a long string containing the list of all tokens (words).
% These tokens are easily known by position in the file TOKENS_LIST

% trainCategory is a (1 x numTrainDocs) vector containing the true 
% classifications for the documents just read in. The i-th entry gives the 
% correct class for the i-th email (which corresponds to the i-th row in 
% the document word matrix).

% Spam documents are indicated as class 1, and non-spam as class 0.
% For the SVM, we convert these to +1 and -1 to form the numTrainDocs x 1
% vector ytrain.

% This vector should be output by this method
average_alpha = zeros(numTrainDocs, 1);

%---------------
% YOUR CODE HERE
alphas = zeros(40, numTrainDocs);

tau = 8;
TrainMatrix = full(Xtrain);
WordVectorLengthSquare = sum(TrainMatrix .^ 2, 2);
t = bsxfun(@plus, WordVectorLengthSquare, WordVectorLengthSquare');
K = exp(-(t - 2 .* TrainMatrix * TrainMatrix')/(2 * tau^2));

for j = 1:40
    iteration = 1;
    alpha = zeros(numTrainDocs, 1);
    for i = randperm(numTrainDocs)
        if (K(:,i)' * alpha * ytrain(i,1) < 1)
            alpha = alpha - (1/(sqrt(iteration))) * (-ytrain(i,1) * K(:,i) + (1/64) * alpha(i,1) * K(:,i));
        else
            alpha = alpha - (1/(sqrt(iteration))) * ((1/64) * alpha(i,1) * K(:,i));
        end
        iteration = iteration + 1;
    end
    alphas(j,:) = alpha;
end

average_alpha = (sum(alphas) ./ 40)';

