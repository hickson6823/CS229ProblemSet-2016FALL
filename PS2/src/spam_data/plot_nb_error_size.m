n = [50,100,200,400,800,1400];
e = [0.0387, 0.0262, 0.0262, 0.0187, 0.0175, 0.0163];
plot(n,e);
title('Naive Bayes & SVM Classifier Error Rate - Training Data Size');
xlabel('Training Data Size');
ylabel('Error Rate');
hold on;

svm_e = [0.03, 0.0138, 0.005, 0.0025, 0.0013, 0.000];
plot(n, svm_e, 'o-');
legend('Naive Bayes','Support Vector Machine');
