task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

require File.join(File.dirname(__FILE__), 'lib', 'sedpr')
task 'convert' do
  if data_dir = ENV['DATA_DIR']
    Dir[File.join(data_dir, '*.html')].each do |html_file|
      html = File.read(html_file)
      puts DailyPerformanceReport.new(html).to_csv
    end
  else
    puts "Usage: DATA_DIR=/path/to/html-reports rake convert"
    exit 1
  end
end