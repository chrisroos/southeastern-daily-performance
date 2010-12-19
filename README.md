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
    $ cat data/csv/*.csv >> combined.csv
    
### Importing the data into mysql
  
    $ mysql -uroot -e"CREATE DATABASE sedpr;"

    $ mysql sedpr -uroot -e"CREATE TABLE problems (id INTEGER AUTO_INCREMENT, date DATE, problem VARCHAR(255), departure_time VARCHAR(5), scheduled_departure_station VARCHAR(255), scheduled_arrival_station VARCHAR(255), affect_on_service VARCHAR(255), PRIMARY KEY(id));"
    
    $ mysql sedpr -uroot -e"LOAD DATA LOCAL INFILE 'combined.csv' INTO TABLE problems FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' IGNORE 1 LINES (date, problem, departure_time, scheduled_departure_station, scheduled_arrival_station, affect_on_service);"
    
    $ mysql sedpr -uroot -e"SELECT COUNT(*) FROM problems;"
    

## TODO

* 2010-04-21 breaks the parser...
* Ensure that I'm generating valid CSV (specifically that I'm quoting columns that contain commas)
* I currently have an empty file for 2010-11-30.csv.  Investigate the cause.