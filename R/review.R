#' Query review from the Goodreads API 
#'
#' Query for Goodreads reviews based on IDs.
#' @param id Goodreads ID of the review
#' @return A \code{data.frame} of review with corresponding information
#'
#' @export
review <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('review/show', id=id)
    tbl <- goodreads_parse_review(ggr)
    tbl
}
