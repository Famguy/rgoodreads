author <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('author/show', id=id)
    tbl <- goodreads_parse_author(ggr)
    tbl
}
