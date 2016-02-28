#' Query book from the Goodreads API by ISBN
#'
#' Query for Goodreads books based on ISBN.
#' @param isbn ISBN of the book
#' @return A \code{data.frame} of book with corresponding information
#'
#' @export
book_by_isbn <- function(isbn) {
    tbl <- NULL
    ggr <- goodreads_GET ('book/isbn', isbn=isbn)
    tbl <- goodreads_parse_book(ggr)
    tbl
}
