
[spmatrix, tokenlist, trainCategory] = readMatrix('MATRIX.TRAIN.1400');

trainMatrix = full(spmatrix);
numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);

% trainMatrix is now a (numTrainDocs x numTokens) matrix.
% Each row represents a unique document (email).
% The j-th column of the row $i$ represents the number of times the j-th
% token appeared in email $i$. 

% tokenlist is a long string containing the list of all tokens (words).
% These tokens are easily known by position in the file TOKENS_LIST

% trainCategory is a (1 x numTrainDocs) vector containing the true 
% classifications for the documents just read in. The i-th entry gives the 
% correct class for the i-th email (which corresponds to the i-th row in 
% the document word matrix).

% Spam documents are indicated as class 1, and non-spam as class 0.
% Note that for the SVM, you would want to convert these to +1 and -1.


% YOUR CODE HERE

% split the training data set into two parts: Spam and Not Spam.
Spam = trainMatrix(trainCategory == 1,:);
NoSpam = trainMatrix(trainCategory == 0,:);

SpamProb = size(Spam,1) / numTrainDocs;
NoSpamProb = size(NoSpam,1) / numTrainDocs;

% use logarithms to avoid the problem of underflow
SpamWordProb = log((sum(Spam) + 1)/(sum(sum(Spam)) + numTokens)); 
NoSpamWordProb = log((sum(NoSpam) + 1)/(sum(sum(NoSpam)) + numTokens)); 

