require 'date'
require 'erb'

site_root = File.expand_path('../../', __FILE__)
html_dir  = File.join('data', 'html')
csv_dir   = File.join('data', 'csv')

first_date = Dir[File.join(site_root, html_dir, '*.html')].first
first_date = Date.parse(first_date)
last_date  = Date.today

dates = (first_date..last_date).inject({}) do |hash, date|
  html_file = File.join(html_dir, "#{date}.html")
  csv_file  = File.join(csv_dir, "#{date}.csv")
  hash[date] = {
    :html_exists => File.exists?(File.join(site_root, html_file)),
    :html_href   => html_file,
    :csv_exists  => File.exists?(File.join(site_root, csv_file)),
    :csv_href    => csv_file
  }
  hash
end

template = File.read(File.expand_path('../templates/raw-html-data.html.erb', __FILE__))
File.open('../raw-html-data.html', 'w') do |file|
  file.puts ERB.new(template, nil, '>').result
end

template = File.read(File.expand_path('../templates/raw-csv-data.html.erb', __FILE__))
File.open('../raw-csv-data.html', 'w') do |file|
  file.puts ERB.new(template, nil, '>').result
end