# Rgoodreads - an R package to interact with the Goodreads API
----------------------------

This R package acts as a wrapper for the read-only features of the [Goodreads API](https://www.goodreads.com/api) with the ability to retrieve information on books, authors, users, reviews, etc. so that they can be analyzed in R. 

Check out the [API documentation](https://www.goodreads.com/api/documentation) for more details.

## Dependencies

- XML
- httr
- RCurl

## Installation

You can install the package with [devtools](https://github.com/hadley/devtools) as such: 

```{r}
# install.packages("devtools")
devtools::install_github("famguy/rgoodreads")
```

## Getting Started

Before using Goodreads API you must create a new application and get an API key. Visit [signup form](http://www.goodreads.com/api/keys) for details. Once you have your API key, set up an environment variable, by adding the following line to your `.Rprofile`:

```r
Sys.setenv(GOODREADS_KEY = "YOUR_KEY_HERE")
```

After that, queries made from your system will use your key.


### Global configuration

You can define client credentials on global level. Just create an initializer file (if using rails) under
`config/initializers`:

``` ruby
Goodreads.configure(
  :api_key => 'KEY',
  :api_secret => 'SECRET'
)
```

Get global configuration:

``` ruby
Goodreads.configuration # => {:api_key => 'YOUR_KEY'}
```

In case you need to reset options:

```ruby
Goodreads.reset_configuration
```

## Examples

### Lookup books

You can lookup a book by ISBN, ID or Title:

```ruby
client.book('id')
client.book_by_isbn('ISBN')
client.book_by_title('Book title')
```

Search for books (by title, isbn, genre):

```ruby
search = client.search_books('The Lord Of The Rings')

search.results.work.each do |book|
  book.id        # => book id
  book.title     # => book title
end
```

### Authors
 
Look up an author by their Goodreads Author ID:

```ruby
author = client.author('id')

author.id              # => author id
author.name            # => author's name
author.link            # => link to author's Goodreads page
author.fans_count      # => number of fans author has on Goodreads
author.image_url       # => link to image of the author
author.small_image_url # => link to smaller of the author
author.about           # => description of the author
author.influences      # => list of links to author's influences
author.works_count     # => number of works by the author in Goodreads
author.gender          # => author's gender
author.hometown        # => author's hometown
author.born_at         # => author's birthdate
author.died_at         # => date of author's death
```

Look up an author by name:

```ruby
author = client.author_by_name('Author Name')

author.id     # => author id
author.name   # => author name
author.link   # => link to author's Goodreads page
```

### Reviews

Pull recent reviews:

```ruby
client.recent_reviews.each do |r|
  r.id            # => review id
  r.book.title    # => review book title
  r.body          # => review message
  r.user.name     # => review user name
end
```

Get review details:

```ruby
review = client.review('id')

review.id         # => review id
review.user       # => user information
review.book       # => uook information
review.rating     # => user rating
```

### Shelves

Get the books on a user's shelf:

```ruby
shelf = client.shelf(user_id, shelf_name)

shelf.books  # array of books on this shelf
shelf.start  # start index of this page of paginated results
shelf.end    # end index of this page of paginated results
shelf.total  # total number of books on this shelf
```

### Groups

Get group details:

```ruby
group = client.group('id')

group.id                 # => group id
group.title              # => group title
group.access             # => group's access settings
                         # => (e.g., public or private)
group.group_users_count  # => number of users in the group
```

List the groups a given user is a member of:

```ruby
group_list = client.group_list('user_id', 'sort')

group_list.total         # => total number of groups
group_list.group.count  # => number of groups returned in the request

# Loop through the list to get details for each of the groups.

group_list.group.each do |g|
  g.id                 # => group id
  g.access             # => access settings (private, public)
  g.users_count        # => number of members
  g.title              # => title
  g.image_url          # => url of the group's image
  g.last_activity_at   # => date and time of the group's last activity
end
```

The `sort` parameter is optional, and defaults to `my_activity`. 
For other sorting options, [see here](http://www.goodreads.com/api#group.list).

## Feedback

Feel free to raise issues [here](http://github.com/famguy/rgoodreads/issues).
