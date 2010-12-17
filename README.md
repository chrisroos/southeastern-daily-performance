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

I just ran the conversion for the all the raw data.  I got warnings from the following files:

* 2010-01-29
* 2010-02-01
* 2010-02-10
* 2010-02-11
* 2010-02-16
* 2010-02-17
* 2010-02-28
* 2010-03-05
* 2010-04-06

The markup must've changed on the 2010-04-15 as the last successful conversion is from 2010-04-14.