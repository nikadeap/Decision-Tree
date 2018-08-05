# Decision-Tree
Implement Decision tree algorithm
Consider the LasagnaTriers dataset from the Albright Winston textbook. The final column HaveTried indicates as to whether the individual (whose attributes are specified by other variables in the row) has tried Lasagna or not. 

a.	Split the dataset into training (770 rows) and testing (86 rows) datasets, using random selection.
b.	Let HaveTried be the target variable for a prediction model. Use the rpart library in R to construct decision tree models for predicting HaveTried values for all records in the training set. 
Derive decision tree models for three different sets of predictors. A maximum of 4 levels may be employed.
i.	Using the set of numerical predictors alone
ii.	Using the set of categorical predictors alone
iii.	Using the entire set of predictors
c.	Transfer the three model trees to your submission document.
d.	Interpret the different components of the tree in Part iii.
e.	Contrast the trees in Part b using various metrics. Comment on their accuracy.
f.	Validate each of the tree models in Part b against the testing dataset. Which is the best model? Why so?
