#' Query users from the Goodreads API 
#'
#' Query for Goodreads user by IDs.
#' @param id User ID.
#' @return A \code{data.frame} of the user with corresponding information
#'
#' @export
user <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('user/show', id=id)
    tbl <- goodreads_parse_user(ggr)
    tbl
}
