---
layout: default
title: Southeastern daily performance - Intro
---
This site is all about the [Southeastern daily performance reports](http://www.southeasternrailway.co.uk/your-journey/daily-performance/).  I think it's great that Southeastern are making this data available.  Unfortunately, I think there are a couple of problems with it as it is: It's presented in a human friendly format that's hard for a computer to interpret, and the southeastern site only contains about the last two month's worth of data.

Each daily report contains some top level stats on the number of planned services, number of actual services and percentage of services that ran within five minutes of schedule.  It then details any problem on the network and the effect that had on various services.

I created the [southeastern-daily-performance](https://github.com/chrisroos/southeastern-daily-performance) library in order to convert the human friendly report into something a computer can understand.  I'm in the process of building out this site to make it easier to interrogate the data.

The [raw](https://github.com/chrisroos/southeastern-daily-performance/tree/master/data/html) and [parsed](https://github.com/chrisroos/southeastern-daily-performance/tree/master/data/csv) data is currently available in the library repo but I hope to make that available on this site shortly.  The raw data has also been uploaded to [Google Fusion Tables](http://www.google.com/fusiontables/Home).

The [dashboard](./dashboard.html) contains some 'interesting' queries made against the data in the fusion tables.

The [query tool](./query-tool.html) contains a simple tool that you can use to run queries against the data in the fusion tables.

The [mysql](./mysql.html) page contains some commands you can use to export the fusion table data and import it into mysql to query locally.

The [raw html data](./raw-html-data.html) page contains an index of all the raw performance data that I've grabbed from the southeastern website.

The [raw csv data](./raw-csv-data.html) page contains an index of all the raw data in csv format.