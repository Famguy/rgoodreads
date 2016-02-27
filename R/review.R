review <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('review/show', id=id)
    tbl <- goodreads_parse_review(ggr)
    tbl
}
