## Intro

Southeastern publish [Daily Performance reports](http://www.southeasternrailway.co.uk/your-journey/daily-performance/).  They're not very usable as they are.  This project currently contains the code I've used to parse that data and the parsed data itself.

I've also popped the data into [this Google Fusion table](http://www.google.com/fusiontables/DataSource?dsrcid=359310) and added a bit of a [query tool](http://chrisroos.github.com/southeastern-daily-performance/) and [dashboard](http://chrisroos.github.com/southeastern-daily-performance/dashboard.html) (of sorts).

## Installation

    $ gem install southeastern-daily-performance -r http://gemcutter.org

## Usage

    $ sedpr-to-csv <location-of-html>

## Examples

### Explicitly download html and convert local file

    $ curl "http://www.southeasternrailway.co.uk/index.php/cms/pages/view/132" > sedpr.html
    $ sedpr-to-csv sedpr.html

### Implicitly download html and convert

    $ sedpr-to-csv http://www.southeasternrailway.co.uk/index.php/cms/pages/view/132
    
## Notes

### Combining all csv files into one big file

    $ echo "Date,Problem,Scheduled departure time,Scheduled departure station,Scheduled arrival station,Affect on service" > combined.csv
    $ cat /path/to/csv/files/*.csv >> combined.csv
    
### Combining all csv overview files into one file

    $ echo "Date,Services scheduled,Services run,Services within 5 minutes of schedule" > combined.overview.csv
    $ cat /path/to/csv/files/*.overview.csv >> combined.overview.csv

## TODO

* 2010-04-21 breaks the parser...
* Ensure that I'm generating valid CSV (specifically that I'm quoting columns that contain commas)
* I currently have an empty file for 2010-11-30.csv.  Investigate the cause.
* Republish the gem
* I'm getting 0s for the parsed overview from 2010-11-30.  Investigate the cause.