#' This will request with the prepared Query to the Google Analytics 
#' Data feed API and returns the data in dataframe R object.
#' 
#' @keywords internal 
#' 
#' @param query.uri The URI prepared by the QueryBuilder class.  
#' @param split_daywise Boolean; default FALSE If the query is a Daywise search then don't keep searching if 0 results are found on a day.
#' 
#' @return GA.list The Google Analytics API JSON response converted to a 
#' list object
#' 
#' @importFrom httr GET
GetDataFeed <- function(query.uri,split_daywise = FALSE) {
  
  GA.Data <- GET(query.uri)  
  GA.list <- ParseDataFeedJSON(GA.Data)
  if (is.null(GA.list$rows)) {
    # This check fails for a Daywise search, we need it to keep searching even after it found 0 results on one day.
    if (split_daywise) {
      return (GA.list)
    } else {
      cat("Your query matched 0 results. Please verify your query using the Query Feed Explorer and re-run it.")
      break
    }
  } else {
    return (GA.list)
  }
}
