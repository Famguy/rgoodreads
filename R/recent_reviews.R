#' Query recent reviews from the Goodreads API 
#'
#' Query for Goodreads recent book reviews.
#' @return A \code{data.frame} of reviews with corresponding information
#'
#' @export
recent_reviews <- function() {
    tbl <- NULL
    ggr <- goodreads_GET ('review/recent_reviews')
    tbl <- goodreads_parse_review(ggr)
    tbl
}
