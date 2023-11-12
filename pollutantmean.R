pollutantmean <- function( directory, pollutant, id = 1:332 ) {
  
  totalSum <- 0
  totalCount <- 0

  for( x in id ) {
    filename <- if( x < 10 ) {
      paste( "00", toString( x ), sep = "" )
    } else if( x < 100 ) {
      paste( "0", toString( x ), sep = "" )
    } else {
      toString( x )
    }
    
    filepath <- paste( directory, "/", filename, ".csv", sep = "" )
    
    df <- read.csv( filepath )

    if ( pollutant == "nitrate" ) {
      totalSum <- totalSum + sum( df$nitrate, na.rm = TRUE )
      totalCount <- totalCount + sum( !is.na( df$nitrate ))
    } else {
      totalSum <- totalSum + sum( df$sulfate, na.rm = TRUE )
      totalCount <- totalCount + sum( !is.na( df$sulfate ))
    }
    
  }
  
  totalSum / totalCount
}
