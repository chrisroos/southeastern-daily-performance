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

    $ cat data/csv/*.csv > combined.csv

## TODO

* 2010-04-21 breaks the parser...
* Ensure that I'm generating valid CSV (specifically that I'm quoting columns that contain commas)