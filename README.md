## Intro

A website built around the [Southeastern daily performance](http://www.southeasternrailway.co.uk/your-journey/daily-performance/) reports.  It's currently hosted on github using [github pages](http://pages.github.com/).

To generate/view it locally you'll need [jekyll](https://github.com/mojombo/jekyll) installed.  You'll also need to build the archive pages.

    $ rake build_archive_pages
    $ jekyll --server --auto

## TODO

* work out how to extract the delay and pop it in it's own column

* import de-normalized set of data into fusion table - generate it with something like

        # Export all data in a denormalised format
        mysql sedpr -uroot -e"select date, year(date) as year, month(date) as month, day(date) as day, weekday(date) as weekday, \
        dayname(date) as dayname, problem, departure_time, scheduled_departure_station, scheduled_arrival_station, affect_on_service \
        from problems \
        into outfile '/Users/chrisroos/Desktop/wem-sedpr.csv' \
        fields terminated by ',' \
        optionally enclosed by '\"'"
    
* use google visualization api to present the data in purdy graphs

* use the google [table visualization](http://code.google.com/apis/visualization/documentation/gallery/table.html) instead of my hand-rolled html tables

* Make it easy to query the raw data from both tables

* Find journeys that took over 30 minutes as they're refundable (i think).

* Add a history of queries.

* Think about displaying the raw data in a table (and therefore get rid of the two separate pages), e.g.

    | date       | html | csv | csv overview |
    | 2010-01-01 | yes  | yes | no           |