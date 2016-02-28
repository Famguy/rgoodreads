#' Search for groups from the Goodreads API 
#'
#' Search for groups based on query terms.
#' @param q Query term for group search
#' @return A \code{data.frame} of groups with corresponding information
#'
#' @export
group_search <- function(q) {
    tbl <- NULL
    ggr <- goodreads_GET ('group/search', q=q)
    tbl <- goodreads_parse_group(ggr)
    tbl
}
