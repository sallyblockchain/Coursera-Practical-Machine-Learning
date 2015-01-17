## Quiz 1
# Problem 1.
# Which of the following are steps in building a machine learning algorithm?
# Deciding on an algorithm, Creating features, Evaluating the prediction.

# Problem 2.
# Suppose we build a prediction algorithm on a data set and it is 100% accurate on that data set. 
# Why might the algorithm not work well if we collect a new data set?
# Our algorithm may be overfitting the training data, 
# predicting both the signal and the noise.

# Problem 3.
# typical sizes for the training and the test sets:
# 60% in the training set, 40% in the testing set.

# Problem 4. 
# What are some common error rates for predicting binary variables (i.e. variables with two possible 
# values like yes/no, disease/normal, clicked/didn't click)?
# Specificity, Sensitivity

# Problem 5.
# Suppose that we have created a machine learning algorithm that predicts whether a link will be 
# clicked with 99% sensitivity and 99% specificity. The rate the link is clicked is 1/1000 of 
# visits to a website. If we predict the link will be clicked on a specific visit, 
# what is the probability it will actually be clicked?
# 100,000 visits => 100 clicks
# 99% = sensitivity = TP/(TP+FN) = 99/(99+1) = 99/100
# 99% specificity =TN/(TN+FP) = 98901/(98901+999) = 98901/99900
# P(actually clicked|clicked) = TP/(TP+FP) = 99/(99+999) = 9%