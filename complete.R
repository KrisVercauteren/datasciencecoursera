complete <- function( directory, ids = 1:332 ) {
  
  count <- 0
  id <- c()
  nobs <- c()

  for( x in ids ) {
    filename <- if( x < 10 ) {
      paste( "00", toString( x ), sep = "" )
    } else if( x < 100 ) {
      paste( "0", toString( x ), sep = "" )
    } else {
      toString( x )
    }
    
    filepath <- paste( directory, "/", filename, ".csv", sep = "" )
    csv <- read.csv( filepath )
    
    count <- count + 1
    id[count] = x
    nobs[count] = 0
    
    sulfates <- !is.na( csv$sulfate )
    nitrate <- !is.na( csv$nitrate )

    for( y in 1:length( sulfates )) {
      if( sulfates[y] && nitrate[y] ) {
        nobs[count] = nobs[count] + 1
      }
    }
  }

  df <- data.frame( id, nobs )
  df
}