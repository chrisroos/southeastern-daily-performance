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
    
## TODO/Notes

I just re-ran the conversion for the raw data from the 21st Jan to the 11th Feb.  I got warnings from the following files:

* 2010-01-26
* 2010-01-29
* 2010-02-01
* 2010-02-08
* 2010-02-10
* 2010-02-11

Additionally, 2010-01-26 and 2010-02-08 csv files were changed.