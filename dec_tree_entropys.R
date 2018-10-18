df <- read.csv('australia_credit.csv')

samp1 <- sample(nrow(df),100)
test <- df[samp1,]
df <- df[-samp1,]

output_0 <- length(which(df$output==0))
output_1 <- length(which(df$output==1))

output_entropy = -(output_0*log2(output_0/nrow(df)) + output_1*log2(output_1/nrow(df)))/nrow(df)

entropys <- rep(0,ncol(df)-1)
discrete <- c(1,4,5,6,8,9,10,11,12)
continuous <- c(2,3,7,13,14)
# df = df[which(df$F8==1),]
# df = df[which(df$F6==0),]

for (i in discrete)
{
  dat <- df[1:nrow(df),i]
  uni <- unique(dat)
  entropy <- 0
  for(j in uni)
  {
    cla_0 <- length(which(dat==j & df$output == 0))
    cla_1 <- length(which(dat==j & df$output == 1))
    total <- cla_0 + cla_1
    
    if(cla_0 != 0 & cla_1 != 0)
      entropy <- entropy + (total/nrow(df)) * (((cla_0/total)*log2(cla_0/total)) + ((cla_1/total)*log2(cla_1/total)))
    else
      entropy <- entropy + 0
  }
  entropys[i] <- (-entropy)  
}

for (i in continuous)
{
  dat <- df[1:nrow(df),i]
  maximum <- max(dat)
  minimum <- min(dat)
  
  ran <- ceiling((maximum - minimum) / 10)
  print(i)
  if(maximum %% 10 == 0)
    dat <- cut(dat,seq(min(dat),max(dat),10),labels = 1:ran , TRUE )
  else if(maximum %% 10 == 1)
    dat <- cut(dat,seq(min(dat),max(dat)+1,10),labels = 1:ran , TRUE )
  else
    dat <- cut(dat,seq(min(dat),max(dat)+10,10),labels = 1:ran , TRUE )
  
  #df[,i] <- dat
  
  uni <- unique(dat)
  entropy <- 0
  
  for(j in uni)
  {
    cla_0 <- length(which(dat==j & df$output == 0))
    cla_1 <- length(which(dat==j & df$output == 1))
    total <- cla_0 + cla_1
    
    if(cla_0 != 0 & cla_1 != 0)
      entropy <- entropy + (total/nrow(df)) * (((cla_0/total)*log2(cla_0/total)) + ((cla_1/total)*log2(cla_1/total)))
    else
      entropy <- entropy + 0
  }
  entropys[i] <- (-entropy)  
}

print(entropys)
tree <- rpart(output ~ . ,data=df , method="poisson")
rpart.plot(tree)

acc = 0
for( i in 1:nrow(test))
{
  predicted <- predict(tree,test[i,])
  
  y_cap = round(predicted[1])
  
  if(y_cap == test[i,ncol(test)])
    acc = acc + 1
}

cat('Information Gain',output_entropy-entropys)
cat('Accuracy:',acc*100/nrow(test))
