if (!require("twitteR")) {
  install.packages("twitteR", repos="http://cran.rstudio.com/") 
  library("twitteR")
}
consumer_key <- "############"
consumer_secret <- "############"
access_token <- "############"
access_secret <- "############"
options(httr_oauth_cache=T) #This will enable the use of a local file to cache OAuth access credentials between R sessions.
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

#############

tweets<- searchTwitter("cerner",250)
df<- do.call("rbind", lapply(tweets, as.data.frame))
names(df)
head(df,15)
counts=table(df$screenName)
barplot(counts)
cc=subset(counts,counts>1)
barplot(cc,las=2,cex.names = 0.3)
df$text=sapply(df$text,function(row) iconv(row,to='UTF-8'))
trim<-function(x) sub('@','',x)
library(stringr)

df$to=sapply(df$text,function(tweet) str_extract(tweet,"^(@[[:alnum:]_]*)"))
df$to=sapply(df$to,function(name) trim(name))
df$rt=sapply(df$text,function(tweet) trim(str_match(tweet,"^RT (@[[:alnum:]_]*)")[2]))

require(ggplot2)
ggplot()+geom_bar(aes(x=na.omit(df$rt)))+opts(axis.text.x=theme_text(angle=-90,size=6))+xlab(NULL)

head(tweets)
