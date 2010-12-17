Dir['data/html/*.html'].each do |file|
  p file
  
  html_filename = File.basename(file)
  csv_filename = html_filename.sub(/\.html/, '.csv')
  
  cmd = "ruby -Ilib ./bin/sedpr-to-csv #{file} > data/csv/#{csv_filename}"
  `#{cmd}`
end