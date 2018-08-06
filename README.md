### Decision-Tree

#### Implement Decision tree algorithm

In the given dataset, the final column dependent column indicates user's binary response

A decision tree is a decision support tool that uses a tree-like graph or model of decisions and their possible consequences, including chance event outcomes, resource costs, and utility. It is one way to display an algorithm that only contains conditional control statements.Decision trees are commonly used in operations research, specifically in decision analysis, to help identify a strategy most likely to reach a goal, but are also a popular tool in machine learning.


#### Implementation

* Split the dataset into training and testing datasets, using random selection.
* Use the rpart library in R to construct decision tree models for predicting dependent variable Y for all records in the training set. 
* Derive decision tree models for three different sets of predictors. A maximum of 4 levels may be employed.
  * Using the set of numerical predictors alone
  * Using the set of categorical predictors alone
  * Using the entire set of predictors
* Transfer the three model trees to your submission document.
* Interpret different components of the tree
