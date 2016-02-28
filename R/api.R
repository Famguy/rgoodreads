# API utilities

#' Parse the results of a Goofreads API query into a data.frame.
#'
#' @param req a request from httr::GET
#'
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

# key: gYWXsF4VUU2YcXkKryosbA
# secret: hhz8Wnw8byEQartBjrSk6m1wsM2Dzht8igmiIP4sA

# goodreads_GET('book/show',id=1)
# goodreads_GET('book/isbn',isbn='0618640150')
# goodreads_GET('book/title',title='The Lord Of The Rings')
# goodreads_GET('search/index',q='The Lord Of The Rings')
# author id 1077326
# author Chetan Bhagat

goodreads_GET <- function(path, site = "goodreads", page = 1, num_pages = 1, ...) {
    # auth <- github_auth(pat)
    base_path <- "https://www.goodreads.com/"
    query <- list(site = site, page = page, ...)

    goodreads_key <- Sys.getenv("GOODREADS_KEY")
# 	goodreads_key <- "gYWXsF4VUU2YcXkKryosbA"
    if (goodreads_key != "") {
        query$key <- goodreads_key
    }

    req <- httr::GET(base_path, path = path, query = query)
    if (httr::http_status(req)$category != "Success"){
    	print (paste0(httr::http_status(req)$reason," ",httr::http_status(req)$message))
    }

    req
}


goodreads_parse_book <- function(req) {
    text <- httr::content(req, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    j <- XML::xmlParse(text)

    # Remove unwanted stuff for further parsing
    sb <- XML::getNodeSet(j, "//similar_books")
    XML::removeNodes(sb)
    rw <- XML::getNodeSet(j, "//reviews_widget")
    XML::removeNodes(rw)
    bl <- XML::getNodeSet(j, "//book_links")
    XML::removeNodes(bl)
    bul <- XML::getNodeSet(j, "//buy_links")
    XML::removeNodes(bul)
    sw <- XML::getNodeSet(j, "//series_works")
    XML::removeNodes(sw)
    ps <- XML::getNodeSet(j, "//popular_shelves")
    XML::removeNodes(ps)

    # Convert to dataframe, add new parameters
    d <- XML::xmlToDataFrame(j)
    d <- d[!(is.na(d$id)),]
    d$work <- NULL
    d$authentication <- NULL
    d$key <- NULL
    d$method <- NULL
    rd <- XML::getNodeSet(j, "//rating_dist")
    d$rating_dist <- XML::xmlValue(rd[[1]])
    an <- XML::xmlSApply(XML::getNodeSet(j, "//authors/author/name"), XML::xmlValue)
    ai <- XML::xmlSApply(XML::getNodeSet(j, "//authors/author/id"), XML::xmlValue)
    d$authors <- list(paste0(an,":",ai))

    # Rename row names as per results
    row.names(d)<-1:nrow(d)
    d
}

goodreads_parse_author <- function(req) {
    text <- httr::content(req, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    j <- XML::xmlParse(text)
    d <- XML::xmlToDataFrame(j)
    d <- d[!(is.na(d$id)),]
    d$books <- NULL
    d$authentication <- NULL
    d$key <- NULL
    d$method <- NULL
    at <- XML::xmlSApply(XML::getNodeSet(j, "//books/book/title"), XML::xmlValue)
    ai <- XML::xmlSApply(XML::getNodeSet(j, "//books/book/id"), XML::xmlValue)
    d$books <- list(paste0(at,":",ai))
    row.names(d)<-1:nrow(d)
    d
}

goodreads_parse_review <- function(req) {
    text <- httr::content(req, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    j <- XML::xmlParse(text)
    print(j)
    d <- XML::xmlToDataFrame(nodes = XML::getNodeSet(j, "//review"))
    print (d)
    d <- d[!(is.na(d$id)),]
    d$authentication <- NULL
    d$key <- NULL
    d$method <- NULL
    bt <- XML::xmlSApply(XML::getNodeSet(j, "//book/title"), XML::xmlValue)
    bi <- XML::xmlSApply(XML::getNodeSet(j, "//book/id"), XML::xmlValue)
    un <- XML::xmlSApply(XML::getNodeSet(j, "//user/name"), XML::xmlValue)
    ui <- XML::xmlSApply(XML::getNodeSet(j, "//user/id"), XML::xmlValue)
    d$user <- paste0(un,":",ui)
    d$book <- paste0(bt,":",bi)
    row.names(d)<-1:nrow(d)
    d
}

goodreads_parse_user <- function(req) {
    text <- httr::content(req, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    j <- XML::xmlParse(text)
    d <- XML::xmlToDataFrame(j)
    d <- d[!(is.na(d$id)),]
    d$authentication <- NULL
    d$key <- NULL
    d$method <- NULL
    d$user_shelves <- NULL
    d$user_statuses <- NULL
    d$favorite_books <- NULL
    d$favorite_authors <- NULL
    row.names(d)<-1:nrow(d)
    d
}

goodreads_parse_group <- function(req) {
    text <- httr::content(req, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    j <- XML::xmlParse(text)
    d <- XML::xmlToDataFrame(nodes = XML::getNodeSet(j, "//group"))
    d <- d[!(is.na(d$id)),]
    d$authentication <- NULL
    d$key <- NULL
    d$method <- NULL
    row.names(d)<-1:nrow(d)
    d
}

