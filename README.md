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
    $ cat data/csv/*.csv >> combined.csv
    
### Importing the combined data into mysql
  
    $ mysql -uroot -e"CREATE DATABASE sedpr;"

    $ mysql sedpr -uroot -e"CREATE TABLE problems (id INTEGER AUTO_INCREMENT, date DATE, problem VARCHAR(255), departure_time VARCHAR(5), scheduled_departure_station VARCHAR(255), scheduled_arrival_station VARCHAR(255), affect_on_service VARCHAR(255), PRIMARY KEY(id));"
    
    $ mysql sedpr -uroot -e"LOAD DATA LOCAL INFILE 'combined.csv' INTO TABLE problems FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' IGNORE 1 LINES (date, problem, departure_time, scheduled_departure_station, scheduled_arrival_station, affect_on_service);"
    
    $ mysql sedpr -uroot -e"SELECT COUNT(*) FROM problems;"
    
### Combining all csv overview files into one file

    $ echo "Services scheduled,Services run,Services within 5 minutes of schedule" > combined.overview.csv
    $ cat data/csv/*.overview.csv >> combined.overview.csv
    
### Importing the combined overview data into mysql

    $ mysql -uroot -e"CREATE DATABASE sedpr;"
    
    $ mysql sedpr -uroot -e"CREATE TABLE overview (id INTEGER AUTO_INCREMENT, date DATE, services_scheduled INTEGER, actual_services INTEGER, services_within_five_minutes_of_schedule FLOAT, PRIMARY KEY(id));"
    
    $ mysql sedpr -uroot -e"LOAD DATA LOCAL INFILE 'combined.overview.csv' INTO TABLE overview FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' IGNORE 1 LINES (date, services_scheduled, actual_services, services_within_five_minutes_of_schedule);"
    
### Stats

    # Ten most disrupted days
    # SELECT date, COUNT(*) FROM problems GROUP BY date ORDER BY COUNT(*) DESC LIMIT 10;
    
    # Ten most disrupted services
    # SELECT departure_time, scheduled_departure_station, scheduled_arrival_station, COUNT(*) FROM problems GROUP BY departure_time, scheduled_departure_station, scheduled_arrival_station ORDER BY COUNT(*) DESC LIMIT 10;
    
    # Ten most disrupted routes
    # SELECT scheduled_departure_station, scheduled_arrival_station, COUNT(*) FROM problems GROUP BY scheduled_departure_station, scheduled_arrival_station ORDER BY COUNT(*) DESC LIMIT 10;
    
    # Most disrupted months
    # SELECT YEAR(date), MONTH(date), COUNT(*) FROM problems GROUP BY YEAR(date), MONTH(date) ORDER BY COUNT(*) DESC;
    
    # Most disruptive problems
    # SELECT date, problem, COUNT(*) FROM problems GROUP BY date, problem ORDER BY COUNT(*) DESC LIMIT 20;

## TODO

* 2010-04-21 breaks the parser...
* Ensure that I'm generating valid CSV (specifically that I'm quoting columns that contain commas)
* I currently have an empty file for 2010-11-30.csv.  Investigate the cause.
* Republish the gem
* Think about splitting the data out from the parser