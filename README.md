## Intro

A website built around the [Southeastern daily performance](http://www.southeasternrailway.co.uk/your-journey/daily-performance/) reports.  It's currently hosted on github using [github pages](http://pages.github.com/).

To generate/view it locally you'll need [jekyll](https://github.com/mojombo/jekyll) installed.  You'll also need to build the archive pages.

    $ rake build_archive_pages
    $ jekyll --server --auto

## TODO

* Make it easy to query the raw data from both tables
* Find journeys that took over 30 minutes as they're refundable (i think)

* Add a history of queries.