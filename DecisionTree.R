#Question 6:Decision Tree
#Submitted by:Apurva Nikade

########################################################################################################
#Read the LasagnaTriers.csv file
setwd('C:/Users/Harish/Desktop/BDA/Assignment_3')

LasagnaTriers <- read.csv("Lasagna Triers.csv", header = TRUE)
#Load required libraries
library(ggplot2)
library(e1071)
library(rattle)
library('rpart')
View(LasagnaTriers)

#Q6.a. Split dataset into training(770) and testing(86) using random selection
set.seed(100)

sample <- sample.int(n = nrow(LasagnaTriers), size = floor(.90*nrow(LasagnaTriers)), replace = FALSE)
train <- LasagnaTriers[sample, ]
cat("length of training data is",length(train$Person))
test  <- LasagnaTriers[-sample, ]
cat("length of test data is", length(test$Person))

#b.Let haveTried be the response variable and use rpart library to construct decision tree in traing set

#Note: Not using Person variable in decision tree classification s it is a nominal categorical variable

## Q6.b.1 Using the set of numeric predictors alone

Model_numeric <- rpart(Have.Tried ~ Age + Weight + Income+
                         + Car.Value + CC.Debt + Mall.Trips,
                       data=train, control=rpart.control(maxdepth=4),
                       method="class")

#Plot the decision tree
plot(Model_numeric,uniform=TRUE,margin=0.2)
text(Model_numeric,use.n=TRUE,all=0.2)

#Use rattle to plot the tree:
fancyRpartPlot(Model_numeric, main ="Model_numeric tree")


# Q6.b.2 Using the set of categorical predictors alone
Model_categorical <- rpart(Have.Tried ~ Pay.Type + Gender +
                             Live.Alone + Dwell.Type +Nbhd,
                           data=train, control=rpart.control(maxdepth=4),
                           method="class")

#Plot the decision tree

plot(Model_categorical,uniform=TRUE,margin=0.2)
text(Model_categorical,use.n=TRUE,all=0.2)

#Use rattle to plot the tree:
fancyRpartPlot(Model_categorical,main ="Categorical")

# Q6.b.3 Using entire set of pedictors
Model_all <- rpart(Have.Tried ~  Age + Weight + Income+
                     Pay.Type + Car.Value + CC.Debt + Gender +
                     Live.Alone + Dwell.Type + Mall.Trips +Nbhd,
                   data=train, control=rpart.control(maxdepth=4),
                   method="class")
#Plot the decision tree
plot(Model_all,uniform=TRUE,margin=0.2)
text(Model_all,use.n=TRUE,all=0.2)

#use rattle to plot the decision tree
fancyRpartPlot(Model_all)

#Q6.e  Contrast the trees in part b using various metrics and comment on accuracy

#To validate the model we use the printcp and plotcp functions.
#Model with numeric predictors alone
printcp(Model_numeric)
plotcp(Model_numeric)

#Model with categorical predictors alone
printcp(Model_categorical)
plotcp(Model_categorical)
#Model with entire set of predictors
printcp(Model_all)
plotcp(Model_all)

#Prune the model as per cptable errors
#Prune Model_all and print the decision tree
ptree_all<- prune(Model_all,cp= Model_all$cptable[which.min(Model_all$cptable[,"xerror"]),"CP"])
fancyRpartPlot(ptree_all, uniform=TRUE, main="Pruned all Model")

#Prune Model_numeric and print the decision tree
ptree_numeric<- prune(Model_numeric,cp= Model_numeric$cptable[which.min(Model_numeric$cptable[,"xerror"]),"CP"])
fancyRpartPlot(ptree_numeric, uniform=TRUE, main="Pruned all Model")

#Prune the model as per cptable errors
#Prune categorical model and print the decision tree
ptree_categorical<- prune(Model_categorical,cp= Model_categorical$cptable[which.min(Model_categorical$cptable[,"xerror"]),"CP"])
fancyRpartPlot(ptree_categorical, uniform=TRUE, main="Pruned categorical Model")

## Q6.f Validate the trees in part b against testing dataset and identify the best model

#Model with numeric set
pred_numeric <- predict(Model_numeric, newdata = test, type = 'class')

test_numeric <- data.frame(Have.Tried=test$Have.Tried,pred_numeric)
ntab_test <- table(test_numeric)

cat("\n\n *************** print accuracy details for numeric model*********************")
#overall Model accuracy
cat("\n\n accuracy for model with numeric variables is", sum(diag(ntab_test))/sum(ntab_test) ) 	# Note: 2 ?table

#model precision


cat("\n precision for model with numeric variables is ",sum(ntab_test[2,2])/sum(ntab_test[,2]) )	# Note: 3 

#model recall

cat("\n recall for model with numeric variables is", sum(ntab_test[2,2])/sum(ntab_test[2,])) 	# Note: 4 
#false positive rate

cat("\n FPR for model with numeric variables is", sum(ntab_test[2,1])/sum(ntab_test[2,])) 	# Note: 5 



#Model with category set
pred_category <- predict(Model_categorical, newdata = test, type = 'class')

test_category <- data.frame(Have.Tried=test$Have.Tried,pred_category)
ctab_test <- table(test_category)

cat("\n\n *********** print accuracy details for categorical model**************************")
#overall Model accuracy
cat(" \n\n accuracy for model with categorical variables is ", sum(diag(ctab_test))/sum(ctab_test) ) 

#model precision

cat("\n precision for model with categorical variables is ",sum(ctab_test[2,2])/sum(ctab_test[,2]) ) 

#model recall

cat("\n recall for model with categorical variables is", sum(ctab_test[2,2])/sum(ctab_test[2,]))  
#false positive rate

cat("\n FPR for model with categorical variables is", sum(ctab_test[2,1])/sum(ctab_test[2,])) 


#Model with entire set
pred_all <- predict(Model_all, newdata = test, type = 'class')

test_all <- data.frame(Have.Tried=test$Have.Tried,pred_all)
atab_test <- table(test_all)

cat("\n\n***************************** print accuracy details for entire dataset model****************************")
#overall Model accuracy
cat("\n\n accuracy for model with categorical variables is", sum(diag(atab_test))/sum(atab_test) ) 	# Note: 2 ?table

#model precision

cat("\n precision for model with categorical variables is ",sum(atab_test[2,2])/sum(atab_test[,2]) )	# Note: 3 

#model recall

cat("\n recall for model with categorical variables is", sum(atab_test[2,2])/sum(atab_test[2,])) 	# Note: 4 
#false positive rate

cat("\n FPR for model with categorical variables is", sum(atab_test[2,1])/sum(atab_test[2,])) 	# Note: 5 
