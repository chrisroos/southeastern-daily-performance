---
layout: default
title: Analysing the data with mysql
---
# {{ page.title }}

## Importing the full data into mysql

    $ curl "http://www.google.com/fusiontables/api/query?sql=select%20*%20from%20359310" \
    > sedpr-full.csv
  
    $ mysql -uroot -e"CREATE DATABASE sedpr;"

    $ mysql sedpr -uroot -e \
    "CREATE TABLE problems \
    (id INTEGER AUTO_INCREMENT, date DATE, problem VARCHAR(255), departure_time VARCHAR(5), \
    scheduled_departure_station VARCHAR(255), scheduled_arrival_station VARCHAR(255), \
    affect_on_service VARCHAR(255), PRIMARY KEY(id));"
    
    $ mysql sedpr -uroot -e \
    "LOAD DATA LOCAL INFILE 'sedpr-full.csv' \
    INTO TABLE problems FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' IGNORE 1 LINES \
    (date, problem, departure_time, scheduled_departure_station, scheduled_arrival_station, affect_on_service);"
    
    $ mysql sedpr -uroot -e"SELECT COUNT(*) FROM problems;"
    
## Importing the overview data into mysql

    $ curl "http://www.google.com/fusiontables/api/query?sql=select%20*%20from%20363664" \
    > sedpr-overview.csv

    $ mysql -uroot -e"CREATE DATABASE sedpr;"

    $ mysql sedpr -uroot -e \
    "CREATE TABLE overview \
    (id INTEGER AUTO_INCREMENT, date DATE, services_scheduled INTEGER, actual_services INTEGER, \
    services_within_five_minutes_of_schedule FLOAT, PRIMARY KEY(id));"

    $ mysql sedpr -uroot -e \
    "LOAD DATA LOCAL INFILE 'sedpr-overview.csv' \
    INTO TABLE overview FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' IGNORE 1 LINES \
    (date, services_scheduled, actual_services, services_within_five_minutes_of_schedule);"
    
    $ mysql sedpr -uroot -e"SELECT COUNT(*) FROM overview;"
    
## Example queries

    # Ten most disrupted days
    $ mysql sedpr -uroot -e \
    "SELECT Date, COUNT(*) AS 'Affected services' \
    FROM problems \
    GROUP BY date \
    ORDER BY COUNT(*) DESC \
    LIMIT 10;"

    # Ten most disrupted services
    $ mysql sedpr -uroot -e \
    "SELECT departure_time, scheduled_departure_station, scheduled_arrival_station, \
    COUNT(*) AS 'Services affected' \
    FROM problems \
    GROUP BY departure_time, scheduled_departure_station, scheduled_arrival_station \
    ORDER BY COUNT(*) DESC \
    LIMIT 10;"

    # Ten most disrupted routes
    $ mysql sedpr -uroot -e \
    "SELECT scheduled_departure_station, scheduled_arrival_station, COUNT(*) AS 'Services affected' \
    FROM problems \
    GROUP BY scheduled_departure_station, scheduled_arrival_station \
    ORDER BY COUNT(*) DESC \
    LIMIT 10;"

    # Most disrupted months
    $ mysql sedpr -uroot -e \
    "SELECT YEAR(date) AS Year, MONTH(date) AS Month, COUNT(*) AS 'Services affected' \
    FROM problems \
    GROUP BY YEAR(date), MONTH(date) \
    ORDER BY COUNT(*) DESC;"

    # Most disruptive problems
    $ mysql sedpr -uroot -e \
    "SELECT Date, Problem, COUNT(*) AS 'Services affected' \
    FROM problems \
    GROUP BY date, problem \
    ORDER BY COUNT(*) DESC \
    LIMIT 10;"