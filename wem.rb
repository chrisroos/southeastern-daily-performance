require 'csv'

p CSV.open('se-2010-01-27.csv', 'r').collect { |row| row.length }.uniq