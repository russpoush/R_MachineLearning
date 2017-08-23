library(Rfacebook)
app_id = "1644591858918498"
app_secret = "4fa78abdbd9f5132dabdfce5c0ea51e7"
myauth <- fbOAuth(app_id = app_id, app_secret = app_secret)

## save(myauth, file = "/users/russpoush/documents/machinelearningr/machinelearning/facebook/FbAuth")

load("/users/russpoush/documents/machinelearningr/machinelearning/facebook/FbAuth")

entity_id <- "35686273690"
dates <- seq(as.Date("2014/09/01"), as.Date("2015/12/01"), by="month")
n <- length(dates)-1
page_info <- getPage(entity_id, token = myauth, n=10, feed = TRUE,
                     reactions = TRUE, since=dates[i], until=dates[i+1]))


df <- list()

for (i in 1:n){
  cat(as.character(dates[i]), " ")
  try(df[[i]] <- page_info
  cat("\n")
}

df <- do.call(rbind, df)


