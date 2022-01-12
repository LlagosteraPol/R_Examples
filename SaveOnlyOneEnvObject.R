
x <- 1; y <- 2 #First, create some objects
save.image()  # save workspace to disk
rm(list=ls()) # remove everything from workspace
tmp.env <- new.env() # create a temporary environment
load(".RData", envir=tmp.env) # load workspace into temporary environment
x <- get("x", pos=tmp.env) # get the objects you need into your globalenv()
#x <- tmp.env$x # equivalent to previous line
rm(tmp.env) # remove the temporary environment to free up memory
save.image(file="test.RData")