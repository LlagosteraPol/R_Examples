

testit <- function(x = sort(runif(20)), ...)
{
  pb <- utils::txtProgressBar(...)
  for(i in c(0, x, 1)) {Sys.sleep(0.5); setTxtProgressBar(pb, i)}
  Sys.sleep(1)
  utils::close(pb)
}
testit()
testit(runif(10))
testit(style = 3)