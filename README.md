## Intro

Southeastern publish [Daily Performance reports](http://www.southeasternrailway.co.uk/your-journey/daily-performance/).  They're not very usable as they are.  This project contains a library, and some tools, to convert that data to splendid CSV.

If you're interested in analysing the data (rather than using this library to convert it) then checkout the [southeastern daily performance website](http://chrisroos.github.com/southeastern-daily-performance/).

## Installation

    $ gem install southeastern-daily-performance

## Usage

    # To convert a single html report to csv
    $ sedpr-to-csv <location-of-html>
    
    # To convert a directory containing multiple html reports to multiple csv reports
    $ convert-all-html-data <location-of-html-reports> <location-of-csv-output>

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

* I should now be in a position to use origin and destination stations rather than using the affect on service to parse the routes.  This should remove these warnings: "Warning. Unknown, or missing, affect on service: '10:24 Dover Priory - Charing Cross'"

* Don't generate empty csv files when the data doesn't exist (e.g 1st-5th dec 2010)

* Don't generate csv overview files containing 0s when the data doesn't exist (e.g. 1st-5th dec 2010)