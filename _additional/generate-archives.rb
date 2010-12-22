require 'date'
require 'erb'

site_root = File.expand_path('../../', __FILE__)
html_dir  = File.join('data', 'html')

first_date = Dir[File.join(site_root, html_dir, '*.html')].first
first_date = Date.parse(first_date)
last_date  = Date.today

dates = (first_date..last_date).inject({}) do |hash, date|
  hash[date] = {
    :exists => File.exists?(File.join(site_root, html_dir, "#{date}.html")),
    :href   => File.join(html_dir, "#{date}.html")
  }
  hash
end

template = File.read(File.expand_path('../templates/raw-html-data.html.erb', __FILE__))
File.open('../raw-html-data.html', 'w') do |file|
  file.puts ERB.new(template, nil, '>').result
end