library(data.table)
library(readr)
library(neuralnet)
library(caret)
RICE <- read_csv("RICE.csv")
#removing space from column name
colnames(RICE)[colnames(RICE) == 'PEST NAME'] <- 'PESTNAME'
# Neural network Setup: choosing parameter, layers of network and particular parameter to be compared i.e. location
NN = neuralnet(Location ~ EVP(mm)+SSH(hrs)+WS(kmph)+RF(mm), RICE, hidden = 1 )
plot(NN)
#to make predictions using a trained neural network model (NN) 
pred <-  neuralnet::compute(NN, RICE[,c(9,10,11,12)])
# this gives probabilities of output suppose to be and not exact output
# so biggest probability as answer, to change output from numbers to location name
pred2 <- data.frame()
for(i in 1:19404){ pred2 <- rbind(pred2 ,which.max(pred$net.result[i,]))}
pred2$X6L <- gsub(1,"Cuttack",pred2$X6L)
pred2$X6L <- gsub(2,"Ludhiana",pred2$X6L)
pred2$X6L <- gsub(3,"Maruteru",pred2$X6L)
pred2$X6L <- gsub(4,"Palampur",pred2$X6L)
pred2$X6L <- gsub(5,"Raipur",pred2$X6L)
pred2$X6L <- gsub(6,"Rajendranagar",pred2$X6L)
prediction <- as.factor(pred2$X6L) # prediction from NN
# most probably "Maruteru" & "Rajendranagar" cities affected by other factors
