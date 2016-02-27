group_search <- function(q) {
    tbl <- NULL
    ggr <- goodreads_GET ('group/search', q=q)
    tbl <- goodreads_parse_group(ggr)
    tbl
}
