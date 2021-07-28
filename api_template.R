library(rlist)

url <- ""
resp <- GET(url)

for(x in 0:(parsed$total_results/200)+1){
  resp <- GET(paste("url here"))
  parsed <- content(resp, as = "parsed")
  modJSON <- parsed$results 
  modJSON <- list.select(modJSON, selection)
  if(x == 1){
    data <- list.stack(modJSON)
  }
  if(x > 1){
    dataz <- list.stack(modJSON)
    data <- rbind(data, dataz)
  }
}
